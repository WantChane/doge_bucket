function Invoke-LeStoreApi {
    param(
        [Parameter(Mandatory)]
        [string]$SoftwareId,
        [string]$LeStoreDomain = "https://lestore.lenovo.com",
        [Parameter(Mandatory)]
        [string]$ApiEndpoint,
        [Parameter(Mandatory)]
        [hashtable]$Payload
    )

    # 获取页面内容并提取JS路径
    $detailUrl = "$LeStoreDomain/detail/$SoftwareId"
    $jsPath = (Invoke-WebRequest -Uri $detailUrl -UseBasicParsing).Content -match '<script src="(\/static\/js\/main\..+?\.js)"' |
    ForEach-Object { $matches[1] }
    if (-not $jsPath) { throw "Failed to find main.js path" }

    # 获取AES加密密钥
    $jsContent = (Invoke-WebRequest -Uri "$LeStoreDomain$jsPath" -UseBasicParsing).Content
    $aesKey = $jsContent -match 'enc\.Utf8\.parse\("(.+?)"\)' |
    ForEach-Object { $matches[1] }
    if (-not $aesKey) { throw "Failed to extract AES key" }

    # AES-CBC加密函数
    function Protect-LeStorePayload {
        param(
            [string]$plainText,
            [string]$key
        )
        $keyBytes = [Text.Encoding]::UTF8.GetBytes($key)
        $aes = [Security.Cryptography.Aes]::Create()
        $aes.Mode = [Security.Cryptography.CipherMode]::CBC
        $aes.Padding = [Security.Cryptography.PaddingMode]::PKCS7
        $aes.Key = $keyBytes
        $aes.IV = $keyBytes  # IV与Key相同

        $encryptor = $aes.CreateEncryptor()
        try {
            [Convert]::ToBase64String(
                $encryptor.TransformFinalBlock(
                    [Text.Encoding]::UTF8.GetBytes($plainText),
                    0,
                    [Text.Encoding]::UTF8.GetByteCount($plainText)
                )
            )
        } finally {
            $encryptor.Dispose()
            $aes.Dispose()
        }
    }

    $headers = @{
        "Content-Type" = "application/json"
        "Origin"       = $LeStoreDomain
        "Referer"      = $detailUrl
    }

    $encryptedData = Protect-LeStorePayload -plainText ($Payload | ConvertTo-Json -Compress) -key $aesKey
    $response = Invoke-RestMethod `
        -Uri "$LeStoreDomain/api/webstorecontents/$ApiEndpoint" `
        -Method Post `
        -Headers $headers `
        -Body (@{ data = $encryptedData } | ConvertTo-Json)

    if ($response.status -ne 0) {
        throw "API Error [$($response.status)]: $($response.message)"
    }

    return $response.data
}

function Get-LeStoreAppVersion {
    param(
        [Parameter(Mandatory)]
        [string]$SoftwareId,
        [string]$LeStoreDomain = "https://lestore.lenovo.com"
    )
    (Invoke-LeStoreApi -SoftwareId $SoftwareId -LeStoreDomain $LeStoreDomain `
        -ApiEndpoint "app/details" -Payload @{softId = $SoftwareId }).version
}

function Get-LeStoreDownloadUrl {
    param(
        [Parameter(Mandatory)]
        [string]$SoftwareId,
        [string]$LeStoreDomain = "https://lestore.lenovo.com"
    )
    (Invoke-LeStoreApi -SoftwareId $SoftwareId -LeStoreDomain $LeStoreDomain `
        -ApiEndpoint "download/getDownloadUrl" -Payload @{
        bizType = "1"
        product = "3"
        softId  = $SoftwareId
        type    = "0"
    }).downloadUrls |
    Sort-Object { $_.downLoadUrl.Length } |
    Select-Object -First 1 -ExpandProperty downLoadUrl
}

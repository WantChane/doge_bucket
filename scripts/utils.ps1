function Set-Junction {
    param(
        [Parameter(Mandatory)]
        [string]$Source,
        [Parameter(Mandatory)]
        [string]$Target
    )

    if (-not (Test-Path $Source)) {
        New-Item -Path $Source -ItemType Directory -Force | Out-Null
    }

    if (Test-Path $Target) {
        $item = Get-Item $Target -ErrorAction SilentlyContinue
        if ($item.LinkType -eq 'Junction') {
            Remove-Item $Target -Force
        } else {
            Get-ChildItem $Target -Force | Move-Item -Destination $Source -Force
            Remove-Item $Target -Force -Recurse
        }
    }
    New-Item -Path $Target -ItemType Junction -Value $Source -Force | Out-Null
}

function Remove-Junction {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (Test-Path $Path) {
        $item = Get-Item $Path -ErrorAction SilentlyContinue
        if ($item.LinkType -eq 'Junction') {
            Remove-Item $Path -Force
        } else {
            throw "卸载失败"
        }
    }
}

function Set-PersistFile {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet('Json', 'Lua')]
        [string]$InitType
    )

    $targetPath = Join-Path -Path $dir -ChildPath $Name
    $persistPath = Join-Path -Path $persist_dir -ChildPath $Name

    if (-not (Test-Path -LiteralPath $persistPath) -and
        -not (Test-Path -LiteralPath $targetPath)) {

        $initialContent = switch ($InitType) {
            'Json' { '{}' }
            'Lua' { 'return {}' }
            default { $null }
        }

        $null = New-Item -Path $targetPath -ItemType File -Value $initialContent -Force
    }
}


function Test-ScheduledTask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TaskName
    )

    schtasks /query /tn $TaskName *>$null

    return $LASTEXITCODE -eq 0
}

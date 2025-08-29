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

function Get-InitialContent {
    param([string]$InitType)
    switch ($InitType) {
        'Json' { '{}' }
        'Lua' { 'return {}' }
        default { $null }
    }
}

function Set-PersistFile {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet('Json', 'Lua')]
        [string]$InitType
    )
    $targetPath = Join-Path $dir $Name
    $persistPath = Join-Path $persist_dir $Name
    if (-not (Test-Path $persistPath) -and -not (Test-Path $targetPath)) {
        $initialContent = Get-InitialContent -InitType $InitType
        $null = New-Item $targetPath -ItemType File -Value $initialContent -Force
    }
}

function Remove-PersistFile {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet('Json', 'Lua')]
        [string]$InitType,

        [switch]$Force
    )
    $paths = $dir, $persist_dir | ForEach-Object { Join-Path $_ $Name }
    $initialContent = Get-InitialContent -InitType $InitType
    foreach ($path in $paths) {
        if (-not (Test-Path $path)) { continue }
        $shouldDelete = $Force -or (
            $initialContent -and
            (Get-Content $path -Raw) -eq $initialContent
        )
        if ($shouldDelete) { Remove-Item $path -Force }
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

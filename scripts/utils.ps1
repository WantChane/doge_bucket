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

function Sync-PersistFile {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )

    $targetPath = Join-Path -Path $dir -ChildPath $Name
    $persistPath = Join-Path -Path $persist_dir -ChildPath $Name

    $targetExists = Test-Path -LiteralPath $targetPath -PathType Leaf
    $persistExists = Test-Path -LiteralPath $persistPath -PathType Leaf

    switch ($true) {
        (-not $targetExists -and -not $persistExists) {
            Write-Warning "Both files missing. Exiting."
        }

        ($targetExists -and -not $persistExists) {
            $null = New-Item -ItemType HardLink -Path $persistPath -Target $targetPath
            Write-Host "Created hard link from $targetPath to $persistPath" -ForegroundColor Cyan
        }

        (-not $targetExists -and $persistExists) {
            $null = New-Item -ItemType HardLink -Path $targetPath -Target $persistPath
            Write-Host "Created hard link from $persistPath to $targetPath" -ForegroundColor Cyan
        }

        ($targetExists -and $persistExists) {
            Write-Host "Both files exist, Exiting." -ForegroundColor Green
        }
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

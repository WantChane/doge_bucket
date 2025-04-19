function Ensure-Junction {
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

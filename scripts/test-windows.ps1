$global:FAIL = 0

function FileExists {
    param([string]$Path)
    if (Test-Path $Path -PathType Leaf) {
        Write-Output "::notice [Windows] $Path exists"
    } else {
        Write-Output "::warning [Windows] $Path does not exist"
        $global:FAIL = 1
    }
}

function FileNotExists {
    param([string]$Path)
    Write-Output "Checking $Path"
    if (-not (Test-Path $Path -PathType Leaf)) {
        Write-Output "::notice [Windows] $Path does not exist"
    } else {
        Write-Output "::warning [Windows] $Path exists"
        $global:FAIL = 1
    }
}

$CONFIG_DIR = chezmoi target-path

# --------------------------------------------------- #

FileExists "$CONFIG_DIR/.wslconfig"

# --------------------------------------------------- #

if ($FAIL -eq 1) {
    Write-Output "::error [Windows] Some tests failed"
    exit 1
} else {
    Write-Output "::notice [Windows] All tests passed"
}

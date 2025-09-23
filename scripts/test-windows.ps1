$global:FAIL = 0

function FileExists {
  param([string]$Path)
  if (Test-Path $Path -PathType Leaf) {
    Write-Output "::notice::[Windows] $Path exists"
  } else {
    Write-Output "::warning::[Windows] $Path does not exist"
    $global:FAIL = 1
  }
}

function FileNotExists {
  param([string]$Path)
  Write-Output "Checking $Path"
  if (-not (Test-Path $Path -PathType Leaf)) {
    Write-Output "::notice::[Windows] $Path does not exist"
  } else {
    Write-Output "::warning::[Windows] $Path exists"
    $global:FAIL = 1
  }
}

function FileContains {
  param([string]$Path, [string]$Content)
  $fileContent = Get-Content $Path -Raw
  if ($fileContent -match [regex]::Escape($Content)) {
    Write-Output "::notice::[Windows] $Path contains '$Content'"
  } else {
    Write-Output "::warning::[Windows] $Path does not contain '$Content'"
    $global:FAIL = 1
  }
}

function FileNotContains {
  param([string]$Path, [string]$Content)
  $fileContent = Get-Content $Path -Raw
  if ($fileContent -notmatch [regex]::Escape($Content)) {
    Write-Output "::notice::[Windows] $Path does not contain '$Content'"
  } else {
    Write-Output "::warning::[Windows] $Path contains '$Content'"
    $global:FAIL = 1
  }
}

$CONFIG_DIR = chezmoi target-path

# --------------------------------------------------- #

FileExists "$CONFIG_DIR/.wslconfig"
FileExists "$CONFIG_DIR/.gitconfig"

FileContains "$CONFIG_DIR/.gitconfig" "ssh-pubkey"

# --------------------------------------------------- #

if ($FAIL -eq 1) {
    Write-Output "::error::[Windows] Some tests failed"
    exit 1
} else {
    Write-Output "::notice::[Windows] All tests passed"
}

$global:FAIL = 0

function FileExists {
  param([string]$Path)
  if (-Not (Test-Path $Path -PathType Leaf)) {
    Write-Output "::warning::$Path does not exist"
    $global:FAIL = 1
  }
}

function FileNotExists {
  param([string]$Path)
  Write-Output "Checking $Path"
  if (Test-Path $Path -PathType Leaf) {
    Write-Output "::warning::$Path exists"
    $global:FAIL = 1
  }
}

function FileContains {
  param([string]$Path, [string]$Content)
  $fileContent = Get-Content $Path -Raw
  if ($fileContent -notmatch [regex]::Escape($Content)) {
    Write-Output "::warning::$Path does not contain '$Content'"
    $global:FAIL = 1
  }
}

function FileNotContains {
  param([string]$Path, [string]$Content)
  $fileContent = Get-Content $Path -Raw
  if ($fileContent -match [regex]::Escape($Content)) {
    Write-Output "::warning::$Path contains '$Content'"
    $global:FAIL = 1
  }
}

$CONFIG_DIR = chezmoi target-path

# --------------------------------------------------- #

FileExists "$CONFIG_DIR/.wslconfig"

FileExists "$CONFIG_DIR/.gitconfig"
FileContains "$CONFIG_DIR/.gitconfig" "ssh-test-pubkey"

FileExists "$CONFIG_DIR/.npmrc"
FileContains "$CONFIG_DIR/.npmrc" "//registry.npmjs.org/:_authToken=test-npm-access-token"
FileContains "$CONFIG_DIR/.npmrc" "//npm.pkg.github.com/:_authToken=test-github-packages-pat"

# --------------------------------------------------- #

if ($FAIL -eq 1) {
    Write-Output "::error::Some tests failed"
    exit 1
} else {
    Write-Output "::notice::All tests passed"
}

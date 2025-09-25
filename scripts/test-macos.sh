#!/bin/sh
FAIL=0

FileExists() {
  if [ ! -f "$1" ]; then
    echo "::warning::$1 does not exist"
    FAIL=1
  fi
}

FileNotExists() {
  if [ -f "$1" ]; then
    echo "::warning::$1 exists"
    FAIL=1
  fi
}

FileContains() {
  if ! grep -q "$2" "$1"; then
    echo "::warning::$1 does not contain $2"
    FAIL=1
  fi
}

FileNotContains() {
  if grep -q "$2" "$1"; then
    echo "::warning::$1 contains $2"
    FAIL=1
  fi
}


CONFIG_DIR=$(chezmoi target-path)

# --------------------------------------------------- #

FileNotExists "$CONFIG_DIR/.wslconfig"

FileExists "$CONFIG_DIR/.gitconfig"
FileContains "$CONFIG_DIR/.gitconfig" "ssh-test-pubkey"

FileExists "$CONFIG_DIR/.npmrc"
FileContains "$CONFIG_DIR/.npmrc" "//registry.npmjs.org/:_authToken=test-npm-access-token"
FileContains "$CONFIG_DIR/.npmrc" "//npm.pkg.github.com/:_authToken=test-github-packages-pat"

FileNotExists "$CONFIG_DIR/.bashrc"

FileExists "$CONFIG_DIR/.zshrc"

# --------------------------------------------------- #

if [ $FAIL -eq 1 ]; then
  echo "::error::Some tests failed"
  exit 1
else
  echo "::notice::All tests passed"
fi

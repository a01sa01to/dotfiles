#!/bin/sh
FAIL=0

file_exists() {
  if [ -f "$1" ]; then
    echo "::notice::[macOS] $1 exists"
  else
    echo "::warning::[macOS] $1 does not exist"
    FAIL=1
  fi
}

file_not_exists() {
  if [ ! -f "$1" ]; then
    echo "::notice::[macOS] $1 does not exist"
  else
    echo "::warning::[macOS] $1 exists"
    FAIL=1
  fi
}

CONFIG_DIR=$(chezmoi target-path)

# --------------------------------------------------- #

file_not_exists "$CONFIG_DIR/.wslconfig"

# --------------------------------------------------- #

if [ $FAIL -eq 1 ]; then
  echo "::error::[macOS] Some tests failed"
  exit 1
else
  echo "::notice::[macOS] All tests passed"
fi

#!/bin/sh
FAIL=0

file_exists() {
  if [ -f "$1" ]; then
    echo "::notice:: [Linux] $1 exists"
  else
    echo "::warning:: [Linux] $1 does not exist"
    FAIL=1
  fi
}

file_not_exists() {
  if [ ! -f "$1" ]; then
    echo "::notice:: [Linux] $1 does not exist"
  else
    echo "::warning:: [Linux] $1 exists"
    FAIL=1
  fi
}

CONFIG_DIR=$(chezmoi target-path)

# --------------------------------------------------- #

file_not_exists "$CONFIG_DIR/.wslconfig"

# --------------------------------------------------- #

if [ $FAIL -eq 1 ]; then
  echo "::error:: [Linux] Some tests failed"
  exit 1
else
  echo "::notice:: [Linux] All tests passed"
fi

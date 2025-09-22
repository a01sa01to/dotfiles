#!/bin/sh

set -e

# Install and Setup chezmoi
# ref: https://www.chezmoi.io/install/
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply a01sa01to

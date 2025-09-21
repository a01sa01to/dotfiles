# dotfiles

a01sa01to's Personal Dotfiles

## Prerequisites

Install [chezmoi](https://www.chezmoi.io/install/) first.

```bash
winget install twpayne.chezmoi
snap install chezmoi --classic
brew install chezmoi
```

### Windows

- `winget` (pre-installed on Windows 11)
- `git` (`winget install git.git`)
- `pwsh` (`winget install Microsoft.PowerShell`)

### Linux

- `snap` <https://snapcraft.io/docs/installing-snapd> (pre-installed on Ubuntu)

### macOS

- `brew` <https://brew.sh/>

## Setup

```bash
chezmoi init --apply a01sa01to
```

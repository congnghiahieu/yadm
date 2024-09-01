# Oh my posh

1. Install scoop:

```sh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

2. Install terminal icon:

```sh
Install-Module -Name Terminal-Icons
```

3. Install oh my posh and restart terminal:

```sh
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
```

4. Set up oh my posh profile. Open profile with notepad and paste the content of `profile.ps1` into new profile. After that, restart terminal

```sh
oh-my-posh get shell
notepad $PROFILE
```

# GUI Applications

## Required

- VSCode
- Obsidian
- MSTeam
- MSOffice
- Vivaldi
- Zalo
- Teamviewer
- AnyDesk
- JetBrain, JetBrain Nerd Font
- EVKey
- Window Debloat, Microsoft Activation Script
- Git Bash
- Java
- Python
- Node
- Docker Desktop
- Terminal
- PowerToys

## Optional

- Choco | Scoop | Winget
- OBS
- balenaEtcher
- CloudFlare Warp
- Postman
- Adobe Acrobat
- Android Studio
- EdraVietnam Driver
- MSI Afterburner
- ScreenToGif

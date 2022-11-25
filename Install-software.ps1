Measure-Command {
    #
    # Author: Johannes Drechsler
    #

    #
    # Variables
    #
    $user = 'qxz0rmr'

    #
    # Set personal path
    #
    New-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' Personal -Value "C:\Users\$user" -Type ExpandString -Force

    #
    # Package Managers
    #

    # Choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    refreshenv
    choco feature enable -n allowGlobalConfirmation

    # Utils
    choco install everything
    choco install vscode
    choco install k9s
    choco install awscli
    choco install 7zip

    #
    # Git
    #

    choco install git --yes --params '/GitAndUnixToolsOnPath'
    choco install tortoisegit --yes
    refreshenv

    git config --global core.editor "code --wait"
    git config --global init.defaultBranch main

    # Python
    choco install python

    # Windows Terminal
    choco install microsoft-windows-terminal
    choco install cascadia-code-nerd-font
    choco install oh-my-posh
    choco install poshgit
    choco install powershell-core

    # NodeJS
    choco install nodejs-lts

    # GLobal NPM packages
    npm install -g cross-env

    # Java JDK
    choco install microsoft-openjdk

    choco install microsoft-windows-terminal
    choco install cascadia-code-nerd-font

    # WSL
    wsl --install

    # Docker / Podman
    choco install podman-desktop
    pip3 install https://github.com/containers/podman-compose/archive/devel.tar.gz

    # DB
    choco install dbeaver

    # HyperV
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

    # Windows folders and settings
    Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0
    Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -value 1

    New-Item -ItemType Directory -Force -Path "c:\users\${user}\documents\gits\bitbucket\FMS"
    New-Item -ItemType Directory -Force -Path "c:\users\${user}\documents\gits\github"

    $o = new-object -com shell.application
    $o.Namespace("c:\users\${user}\documents\gits\github").Self.InvokeVerb("pintohome") 
    $o.Namespace("c:\users\${user}\documents").Self.InvokeVerb("pintohome") 
}
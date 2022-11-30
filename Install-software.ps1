Measure-Command {
    #
    # Author: Johannes Drechsler
    #

    #
    # Variables
    #
    $user = 'qxz0rmr'
    $pathNewPSProfileScript = ".\Microsoft.PowerShell_profile.ps1"
    $pathProfileWindowsPowerShell = "C:\Users\$user\Documents\WindowsPowerShell"
    $pathProfilePowerShell = "C:\Users\$user\Documents\PowerShell"

    #
    # Set powershell script execution policy
    #
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

    #
    # Importants
    #
    Make sure onedrive is not syncing or using system folders

    # Windows folders and settings
    # Show file extensions
    # Show hidden files
    # Show hidden folders
    # Set view to details
    # Apply to all folders
    # TODO: automate through PS

    #
    # Set personal paths
    #
    New-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' Personal -Value "C:\Users\$user" -Type ExpandString -Force
    New-Item -ItemType Directory -Force -Path "c:\users\${user}\documents\gits\bitbucket\FMS"
    New-Item -ItemType Directory -Force -Path "c:\users\${user}\documents\gits\github"
    New-Item -ItemType Directory -Force -Path $pathProfileWindowsPowerShell
    New-Item -ItemType Directory -Force -Path $pathProfilePowerShell
    $o = new-object -com shell.application
    $o.Namespace("c:\users\${user}\documents\gits\github").Self.InvokeVerb("pintohome") 
    $o.Namespace("c:\users\${user}\documents").Self.InvokeVerb("pintohome") 

    # Copy PS profiles
    Copy-Item -Path $pathNewPSProfileScript -Destination "$pathProfileWindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force  
    Copy-Item -Path $pathNewPSProfileScript -Destination "$pathProfilePowerShell\Microsoft.PowerShell_profile.ps1" -Force
    Copy-Item -Path $pathNewPSProfileScript -Destination "$pathProfilePowerShell\Microsoft.VSCode_profile.ps1" -Force

    # Choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    refreshpath
    choco feature enable -n allowGlobalConfirmation

    # Install terminal packages
    choco install powershell-core
    choco install cascadia-code-nerd-font
    choco install oh-my-posh
    choco install poshgit

    # Windows Terminal
    add-appxpackage "./Dependencies/Microsoft.VCLibs.x64.14.00.Desktop.appx" # needed for terminal https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx
    add-appxpackage "./Dependencies/Microsoft.VCLibs.x86.14.00.Desktop.appx" # needed for terminal https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx
    choco install microsoft-windows-terminal --pre 
    # install manually if automatic fails
    # dism.exe /online /Add-ProvisionedAppxPackage /PackagePath:"C:\ProgramData\chocolatey\lib-bad\microsoft-windows-terminal\tools\Microsoft.WindowsTerminal_Win10_1.15.2874.0_8wekyb3d8bbwe.msixbundle" /SkipLicense

    # Utils
    choco install everything
    choco install vscode
    choco install k9s
    choco install awscli
    choco install 7zip

    # Browsers
    choco install googlechrome
    choco install firefox-dev --pre 

    #
    # Git
    #
    choco install git --yes --params '/GitAndUnixToolsOnPath'
    choco install tortoisegit --yes
    refreshpath
    git config --global core.editor "code --wait"
    git config --global init.defaultBranch main

    # Python
    choco install python

    # NodeJS
    choco install nodejs-lts
    refreshpath

    # GLobal NPM packages
    npm install -g cross-env

    # Java JDK
    choco install microsoft-openjdk
    refreshpath

    # WSL
    wsl --install

    # Docker / Podman
    choco install podman-desktop
    pip3 install https://github.com/containers/podman-compose/archive/devel.tar.gz

    # DB
    choco install dbeaver
    choco install postgresql --params '/Password:password' --paramsglobal

    # HyperV
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
}
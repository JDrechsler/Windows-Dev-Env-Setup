Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'
Invoke-Expression (oh-my-posh --init --shell pwsh --config " C:\Program Files (x86)/oh-my-posh/themes/paradox.omp.json")

function refreshpath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function gitStatus {
    git status
}

function gitFetch {
    git fetch
}

Set-Alias gs gitStatus
Set-Alias s gitStatus
Set-Alias g gitStatus
Set-Alias f gitFetch
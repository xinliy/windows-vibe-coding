$ErrorActionPreference = "SilentlyContinue"

function Write-Check {
    param(
        [string]$Name,
        [bool]$Ok,
        [string]$Hint = ""
    )

    if ($Ok) {
        Write-Host "[OK]   $Name" -ForegroundColor Green
    } else {
        Write-Host "[MISS] $Name" -ForegroundColor Yellow
        if ($Hint) {
            Write-Host "       $Hint" -ForegroundColor DarkYellow
        }
    }
}

Write-Host "Windows Vibe Coding Doctor" -ForegroundColor Cyan
Write-Host ""

$wsl = Get-Command wsl.exe
Write-Check "WSL command" ($null -ne $wsl) "Run: wsl --install"

if ($wsl) {
    $wslStatus = & wsl.exe --status 2>$null
    Write-Host ""
    Write-Host "WSL status:" -ForegroundColor Cyan
    $wslStatus | ForEach-Object { Write-Host "  $_" }
}

$commands = @(
    @{ Name = "Windows Terminal"; Command = "wt.exe"; Hint = "Install via Microsoft Store or winget install Microsoft.WindowsTerminal" },
    @{ Name = "PowerShell 7"; Command = "pwsh.exe"; Hint = "winget install Microsoft.PowerShell" },
    @{ Name = "Git"; Command = "git.exe"; Hint = "winget install Git.Git" },
    @{ Name = "GitHub CLI"; Command = "gh.exe"; Hint = "winget install GitHub.cli" },
    @{ Name = "VS Code"; Command = "code.cmd"; Hint = "winget install Microsoft.VisualStudioCode" },
    @{ Name = "Docker"; Command = "docker.exe"; Hint = "Install Docker Desktop and enable WSL integration" }
)

Write-Host ""
Write-Host "Windows tools:" -ForegroundColor Cyan
foreach ($item in $commands) {
    Write-Check $item.Name ($null -ne (Get-Command $item.Command)) $item.Hint
}

Write-Host ""
Write-Host "Next: open WSL and run ./scripts/doctor.sh from this repo." -ForegroundColor Cyan

$ErrorActionPreference = "Stop"

Write-Host "Windows Vibe Coding Windows Installer" -ForegroundColor Cyan
Write-Host ""
Write-Host "MVP installer is conservative. It prints recommended commands instead of changing your system." -ForegroundColor Yellow
Write-Host ""

$commands = @(
    "wsl --install",
    "winget install Microsoft.WindowsTerminal",
    "winget install Microsoft.PowerShell",
    "winget install Git.Git",
    "winget install GitHub.cli",
    "winget install Microsoft.VisualStudioCode",
    "winget install Docker.DockerDesktop"
)

foreach ($command in $commands) {
    Write-Host $command
}

Write-Host ""
Write-Host "Run .\scripts\doctor.ps1 before and after installation." -ForegroundColor Cyan

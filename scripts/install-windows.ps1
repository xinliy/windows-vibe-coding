param(
    [ValidateSet("minimal", "docker", "all")]
    [string[]]$Group = @("minimal"),
    [switch]$Run,
    [switch]$Yes
)

$ErrorActionPreference = "Stop"

function New-Step {
    param(
        [string]$Name,
        [string]$Command,
        [string]$Why
    )

    [ordered]@{
        name = $Name
        command = $Command
        why = $Why
    }
}

function Add-UniqueStep {
    param(
        [System.Collections.Generic.List[object]]$Steps,
        [object]$Step
    )

    foreach ($existing in $Steps) {
        if ($existing.command -eq $Step.command) {
            return
        }
    }

    $Steps.Add($Step)
}

function Confirm-Step {
    param([object]$Step)

    if ($Yes) {
        return $true
    }

    $answer = Read-Host "Run this command? [y/N]"
    return $answer -match "^(y|yes)$"
}

function Invoke-InstallStep {
    param([object]$Step)

    Write-Host ""
    Write-Host $Step.name -ForegroundColor Cyan
    Write-Host "  $($Step.why)"
    Write-Host "  $($Step.command)" -ForegroundColor Yellow

    if (-not $Run) {
        return
    }

    if (-not (Confirm-Step -Step $Step)) {
        Write-Host "  skipped" -ForegroundColor DarkYellow
        return
    }

    Invoke-Expression $Step.command
}

$requested = New-Object System.Collections.Generic.HashSet[string]
foreach ($item in $Group) {
    [void]$requested.Add($item)
}

if ($requested.Contains("all")) {
    [void]$requested.Add("minimal")
    [void]$requested.Add("docker")
}

$steps = New-Object System.Collections.Generic.List[object]

if ($requested.Contains("minimal")) {
    Add-UniqueStep $steps (New-Step "Install or enable WSL" "wsl --install" "Required for Linux-first AI coding workflows on Windows.")
    Add-UniqueStep $steps (New-Step "Install Windows Terminal" "winget install --id Microsoft.WindowsTerminal --exact" "Recommended terminal for WSL profiles.")
    Add-UniqueStep $steps (New-Step "Install PowerShell 7" "winget install --id Microsoft.PowerShell --exact" "Modern PowerShell for setup scripts and troubleshooting.")
    Add-UniqueStep $steps (New-Step "Install Git for Windows" "winget install --id Git.Git --exact" "Useful before WSL is fully configured.")
    Add-UniqueStep $steps (New-Step "Install GitHub CLI" "winget install --id GitHub.cli --exact" "Needed for GitHub auth and publishing repos.")
    Add-UniqueStep $steps (New-Step "Install VS Code" "winget install --id Microsoft.VisualStudioCode --exact" "Recommended editor UI with Remote - WSL.")
}

if ($requested.Contains("docker")) {
    Add-UniqueStep $steps (New-Step "Install Docker Desktop" "winget install --id Docker.DockerDesktop --exact" "Provides Docker Engine with WSL integration.")
}

Write-Host "Windows Vibe Coding Windows Installer" -ForegroundColor Cyan
Write-Host ""

if (-not $Run) {
    Write-Host "Dry run. No system changes will be made." -ForegroundColor Yellow
    Write-Host "Add -Run to execute. Add -Yes to skip per-command prompts." -ForegroundColor Yellow
} else {
    Write-Host "Run mode enabled. Commands may change this Windows installation." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Groups: $($Group -join ', ')" -ForegroundColor Cyan
Write-Host "Planned steps: $($steps.Count)" -ForegroundColor Cyan

if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "[MISS] WinGet is not available. Install App Installer from Microsoft Store first." -ForegroundColor Yellow
}

foreach ($step in $steps) {
    Invoke-InstallStep -Step $step
}

Write-Host ""
Write-Host "After installation, run:" -ForegroundColor Cyan
Write-Host "  .\scripts\doctor.ps1"
Write-Host "Then open WSL and run:"
Write-Host "  ./scripts/doctor.sh"

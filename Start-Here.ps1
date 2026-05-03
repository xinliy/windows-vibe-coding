param(
    [switch]$Json
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Doctor = Join-Path $RepoRoot "scripts\doctor.ps1"

if (-not (Test-Path $Doctor)) {
    throw "Cannot find scripts\doctor.ps1. Run this script from the extracted windows-vibe-coding package."
}

if ($Json) {
    & $Doctor -Json
    exit $LASTEXITCODE
}

Write-Host "Windows Vibe Coding Setup" -ForegroundColor Cyan
Write-Host ""
Write-Host "Step 1: diagnose this Windows machine." -ForegroundColor Cyan
Write-Host ""

& $Doctor

Write-Host ""
Write-Host "Step 2: review the recommended install commands." -ForegroundColor Cyan
Write-Host "Run this when you are ready:"
Write-Host "  .\scripts\install-windows.ps1" -ForegroundColor Yellow
Write-Host ""
Write-Host "Step 3: after Windows setup, open WSL and run:"
Write-Host "  ./scripts/doctor.sh" -ForegroundColor Yellow

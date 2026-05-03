param(
    [switch]$Json
)

$ErrorActionPreference = "SilentlyContinue"
$Results = New-Object System.Collections.Generic.List[object]

function Write-Check {
    param(
        [string]$Category,
        [string]$Name,
        [bool]$Ok,
        [string]$Hint = "",
        [string]$Value = ""
    )

    $Results.Add([ordered]@{
        category = $Category
        name = $Name
        ok = $Ok
        value = $Value
        hint = $Hint
    })

    if ($Json) {
        return
    }

    if ($Ok) {
        $suffix = if ($Value) { " ($Value)" } else { "" }
        Write-Host "[OK]   $Name$suffix" -ForegroundColor Green
    } else {
        Write-Host "[MISS] $Name" -ForegroundColor Yellow
        if ($Hint) {
            Write-Host "       $Hint" -ForegroundColor DarkYellow
        }
    }
}

function Get-CommandVersion {
    param(
        [string]$Command,
        [string[]]$VersionArgs = @("--version")
    )

    $cmd = Get-Command $Command
    if (-not $cmd) {
        return ""
    }

    $output = & $Command @VersionArgs 2>$null | Select-Object -First 1
    if ($output) {
        return ($output -join " ").Trim()
    }

    return ""
}

function Test-Command {
    param(
        [string]$Category,
        [string]$Name,
        [string]$Command,
        [string]$Hint,
        [string[]]$VersionArgs = @("--version")
    )

    $cmd = Get-Command $Command
    $version = ""
    if ($cmd) {
        $version = Get-CommandVersion -Command $Command -VersionArgs $VersionArgs
    }

    Write-Check -Category $Category -Name $Name -Ok ($null -ne $cmd) -Hint $Hint -Value $version
}

function Normalize-WslLine {
    param([string]$Line)

    if (-not $Line) {
        return ""
    }

    return ($Line -replace "`0", "").Trim()
}

function Get-DefaultWslDistro {
    $quietList = & wsl.exe --list --quiet 2>$null
    foreach ($line in $quietList) {
        $clean = Normalize-WslLine $line
        if ($clean) {
            return $clean
        }
    }

    $verboseList = & wsl.exe --list --verbose 2>$null
    foreach ($line in $verboseList) {
        $clean = Normalize-WslLine $line
        if ($clean -match "^\*\s*(\S+)") {
            return $Matches[1]
        }
    }

    return ""
}

if (-not $Json) {
    Write-Host "Windows Vibe Coding Doctor" -ForegroundColor Cyan
    Write-Host ""
}

$os = Get-CimInstance Win32_OperatingSystem
if ($os) {
    $caption = "$($os.Caption) $($os.Version)"
    $isWindows11 = $os.Caption -like "*Windows 11*"
    Write-Check -Category "system" -Name "Windows 11 recommended" -Ok $isWindows11 -Hint "Windows 10 can work, but Windows 11 has the best WSL and WSLg experience." -Value $caption
}

$wsl = Get-Command wsl.exe
Write-Check -Category "wsl" -Name "WSL command" -Ok ($null -ne $wsl) -Hint "Run PowerShell as Administrator, then: wsl --install"

if ($wsl) {
    $wslDistros = & wsl.exe --list --verbose 2>$null
    $defaultDistro = Get-DefaultWslDistro
    $hasDistro = [bool]$defaultDistro
    Write-Check -Category "wsl" -Name "Default WSL distro" -Ok $hasDistro -Hint "Install Ubuntu with: wsl --install -d Ubuntu-24.04" -Value $defaultDistro

    if (-not $Json) {
        Write-Host ""
        Write-Host "WSL distros:" -ForegroundColor Cyan
        $wslDistros | ForEach-Object {
            $line = Normalize-WslLine $_
            if ($line) {
                Write-Host "  $line"
            }
        }
    }
}

$commands = @(
    @{ Name = "Windows Terminal"; Command = "wt.exe"; Hint = "winget install Microsoft.WindowsTerminal"; Args = @("--version") },
    @{ Name = "PowerShell 7"; Command = "pwsh.exe"; Hint = "winget install Microsoft.PowerShell"; Args = @("--version") },
    @{ Name = "Git"; Command = "git.exe"; Hint = "winget install Git.Git"; Args = @("--version") },
    @{ Name = "GitHub CLI"; Command = "gh.exe"; Hint = "winget install GitHub.cli"; Args = @("--version") },
    @{ Name = "VS Code"; Command = "code.cmd"; Hint = "winget install Microsoft.VisualStudioCode"; Args = @("--version") },
    @{ Name = "Docker"; Command = "docker.exe"; Hint = "Install Docker Desktop and enable WSL integration"; Args = @("--version") },
    @{ Name = "WinGet"; Command = "winget.exe"; Hint = "Install App Installer from Microsoft Store"; Args = @("--version") }
)

if (-not $Json) {
    Write-Host ""
    Write-Host "Windows tools:" -ForegroundColor Cyan
}

foreach ($item in $commands) {
    Test-Command -Category "windows-tools" -Name $item.Name -Command $item.Command -Hint $item.Hint -VersionArgs $item.Args
}

$docker = Get-Command docker.exe
if ($docker) {
    $dockerInfo = & docker.exe info 2>$null
    Write-Check -Category "docker" -Name "Docker daemon reachable" -Ok ($LASTEXITCODE -eq 0 -and $dockerInfo) -Hint "Start Docker Desktop, then enable Settings > Resources > WSL Integration."
}

if ($Json) {
    [ordered]@{
        tool = "windows-vibe-coding-doctor"
        platform = "windows"
        generatedAt = (Get-Date).ToString("o")
        results = $Results
    } | ConvertTo-Json -Depth 5
} else {
    $missing = ($Results | Where-Object { -not $_.ok }).Count
    Write-Host ""
    Write-Host "Summary: $missing issue(s) found." -ForegroundColor Cyan
    Write-Host "Next: open WSL and run ./scripts/doctor.sh from this repo." -ForegroundColor Cyan
}

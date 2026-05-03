# Troubleshooting

## WSL Is Not Installed

Run PowerShell as Administrator:

```powershell
wsl --install
```

Restart when prompted.

## Project Is Under /mnt/c

Move active projects into the WSL filesystem:

```bash
mkdir -p ~/code
mv /mnt/c/Users/<you>/code/my-project ~/code/
```

## Node Is Installed On Windows But Not WSL

AI coding CLIs should be installed inside WSL for this setup.

```bash
node --version
npm --version
```

If missing, use the WSL install script or install Node LTS manually.

## VS Code Cannot Open WSL

Install the Remote - WSL extension, then run from WSL:

```bash
code .
```

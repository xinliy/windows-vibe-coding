# Screenshots and Clipboard

The Windows clipboard and WSL filesystem are separate. Here are the recommended
workflows for getting screenshots into your AI coding workflow.

## Capture a Screenshot

Use `Win+Shift+S` to capture a region. Windows saves it to the clipboard and
optionally to `~/Pictures/Screenshots/`.

To paste into a WSL-based AI tool, save the file first:

1. Press `Win+Shift+S`, select the region.
2. Open the Snipping Tool notification and click **Save** (or use Paint to save).
3. The file lands in `C:\Users\<you>\Pictures\Screenshots\`.

## Access the File from WSL

Windows drives are mounted under `/mnt/`:

```bash
ls /mnt/c/Users/<you>/Pictures/Screenshots/
```

Copy it to your WSL project:

```bash
cp "/mnt/c/Users/<you>/Pictures/Screenshots/screenshot.png" ~/code/my-project/
```

## Pass a Screenshot to Claude Code

Once the file is in your WSL filesystem, reference it in a Claude Code session:

```
claude
> What is wrong with this UI? [attach screenshot.png]
```

Or drag the file path into the terminal prompt directly.

## Clipboard Paste Shortcut

For a faster workflow, set up a shell alias that copies the latest screenshot
into the current directory:

```bash
# Add to ~/.bashrc or ~/.zshrc
alias paste-screenshot='cp "$(ls -t /mnt/c/Users/<you>/Pictures/Screenshots/*.png | head -1)" .'
```

Replace `<you>` with your Windows username.

## Windows Terminal Tip

You can drag files from Windows Explorer directly into a Windows Terminal tab.
This pastes the full path, including the `/mnt/c/...` WSL path, into the prompt.

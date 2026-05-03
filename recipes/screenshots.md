# Screenshots Recipe

Windows screenshots and WSL terminals often need glue because the Windows
clipboard and WSL filesystem are separate.

MVP scope:

- Document existing helper tools.
- Add a simple recommended workflow.
- Later, provide an optional helper script.

Recommended manual workflow for now:

1. Capture with `Win+Shift+S`.
2. Save into a known folder.
3. Reference the file from WSL via `/mnt/c/Users/<you>/Pictures/...`.

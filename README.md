# Claude Code starter workflow kit

A small, plain-text starter set for [Claude Code](https://claude.com/claude-code): a `CLAUDE.md` template, 3 rules, 3 slash commands, 5 skills and an example `settings.json`. Nothing here talks to a server or needs a key.

- Rules: honest reporting, protect hand edits, a simple req/reply file workflow
- Commands: `/estimate`, `/session-end`, `/status`
- Skills: acceptance criteria, deploy-verify, skill-writer, web-standards, webapp-testing

## Install

macOS / Linux / Windows Git Bash:

    bash install.sh                 # to ~/.claude (shared by all projects)
    bash install.sh --project       # into the current folder
    bash install.sh --dry-run       # show what would happen, write nothing
    bash install.sh --zip kit.zip   # use a local zip instead of downloading

Windows PowerShell:

    .\install.ps1                   # to $HOME\.claude
    .\install.ps1 -Project
    .\install.ps1 -DryRun

Safety rules baked into both scripts:
- an existing file is never overwritten; the kit version is saved next to it as `<name>.kit-new`
- `settings.json` is never written; only `settings.kit-example.json` is created
- `--target <dir>` / `-Target <dir>` installs into a throw-away folder so you can try it first

## Tested on three operating systems

`.github/workflows/test-install.yml` builds the zip from `kit/` and runs the real install script on Ubuntu, macOS and Windows runners, then checks the file count and that a second run overwrites nothing. See the Actions tab for the latest result.

## More

Walk-through pages in English, Japanese and Chinese: https://workflow.maysuns.uk/en/

License: MIT. Written with the help of AI; no warranty.

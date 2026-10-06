# Starter workflow kit installer (Windows PowerShell 5.1 / PowerShell 7)
# Usage:
#   .\install.ps1                       # install to the user level $HOME\.claude, downloads the lite kit
#   .\install.ps1 -Project              # install into the current directory (.\CLAUDE.md and .\.claude\)
#   .\install.ps1 -ZipPath kit.zip      # use a local zip (for the full kit, sign in in the browser and download the zip first)
#   .\install.ps1 -DryRun               # only show what would be done, write nothing
# Rule: existing files are NEVER overwritten - the kit version is saved as <file name>.kit-new for you to compare and merge.
#       settings.json is never written; only settings.kit-example.json is created for reference.
#   .\install.ps1 -Target D:\x\.claude  # choose the install directory (use it to try an install in a temp folder first)
param([switch]$Project, [string]$ZipPath = "", [switch]$DryRun, [string]$Target = "")
$ErrorActionPreference = "Stop"
$Url = "https://workflow.maysuns.uk/en/kit/workflow-starter-lite.zip"
$Tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("kit_" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $Tmp | Out-Null
try {
  if (-not $ZipPath) {
    Write-Host "Downloading kit: $Url"
    $ZipPath = Join-Path $Tmp "kit.zip"
    Invoke-WebRequest -Uri $Url -OutFile $ZipPath -UseBasicParsing
  }
  Expand-Archive -Path $ZipPath -DestinationPath (Join-Path $Tmp "x") -Force
  $Root = Get-ChildItem (Join-Path $Tmp "x") -Directory | Select-Object -First 1
  if (-not $Root) { throw "No kit folder in the zip" }
  $RootPath = $Root.FullName
  if ($Target) { $Dest = $Target; $ClaudeDir = $Target; $Mode = "target" }
  elseif ($Project) { $Dest = (Get-Location).Path; $ClaudeDir = Join-Path $Dest ".claude"; $Mode = "project" }
  else { $Dest = Join-Path $HOME ".claude"; $ClaudeDir = $Dest; $Mode = "user" }
  $suffix = ""; if ($DryRun) { $suffix = " (dry run, no files written)" }
  Write-Host "Mode: $Mode   Target: $Dest $suffix"
  $script:new = 0; $script:skipped = 0
  function Put([string]$src, [string]$dst) {
    if (Test-Path -LiteralPath $dst) {
      Write-Host "  Skip (exists) $dst -> kit version saved as $dst.kit-new"
      if (-not $DryRun) { Copy-Item -LiteralPath $src -Destination "$dst.kit-new" -Force }
      $script:skipped++
    } else {
      Write-Host "  Create $dst"
      if (-not $DryRun) {
        New-Item -ItemType Directory -Path (Split-Path $dst) -Force | Out-Null
        Copy-Item -LiteralPath $src -Destination $dst
      }
      $script:new++
    }
  }
  $dotClaude = Join-Path $RootPath ".claude"
  Get-ChildItem -LiteralPath $dotClaude -Recurse -File | Sort-Object FullName | ForEach-Object {
    $rel = $_.FullName.Substring($dotClaude.Length).TrimStart('\','/')
    if ($rel -eq "settings.example.json") { Put $_.FullName (Join-Path $ClaudeDir "settings.kit-example.json") }  # never touch settings.json
    else { Put $_.FullName (Join-Path $ClaudeDir $rel) }
  }
  $cm = Join-Path $RootPath "CLAUDE.md"
  if (Test-Path -LiteralPath $cm) {
    if ($Project -and -not $Target) { Put $cm (Join-Path $Dest "CLAUDE.md") } else { Put $cm (Join-Path $Dest "CLAUDE.kit-template.md") }
  }
  Write-Host "Done: created $($script:new), skipped $($script:skipped) (already existed; kit versions saved as .kit-new)."
  Write-Host "Next: open Claude Code and try /status; then replace the [bracketed] parts of the CLAUDE.md template with your own content."
} finally {
  Remove-Item -LiteralPath $Tmp -Recurse -Force -ErrorAction SilentlyContinue
}

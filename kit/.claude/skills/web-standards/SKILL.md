---
name: web-standards
description: "Read before building or changing any website/page: follow common industry practice (accessibility WCAG, responsive layout, forms, performance, settings-page conventions); deviations must be written into the design doc. Use when the user says 'make a web page', 'change the site', 'the UI looks bad', 'the phone display is wrong', 'where do settings go'."
---

# Common web standards (short version)

Use common industry practice by default; when deviating, write "why it is designed this way" in the project `DESIGN.md`.

## Layout and responsive
- `<meta name="viewport" content="width=device-width, initial-scale=1">` is mandatory.
- No fixed pixel widths for containers; give flex children `min-width:0` so they cannot blow out; long text `overflow-wrap:anywhere`.
- Put tables and code blocks in a horizontally scrollable container; the whole page must not get a horizontal scrollbar.
- After changing, measure `scrollWidth <= innerWidth` at two widths (about 390 and 1400).

## Accessibility (common WCAG 2.2 points)
- Body text contrast >= 4.5:1; do not express state by colour alone.
- Every clickable element reachable by keyboard with a visible focus; targets >= 24px (44px recommended on phones).
- Images have alt; form inputs have a label; error messages explain the cause and how to fix it.
- Dialogs: closable with Esc, focus moves in when opened and back to the trigger when closed.

## Forms and interaction
- One main action per page; dangerous actions (delete) need a second confirmation that states the consequence.
- Do not clear what the user already typed; disable the button on submit to prevent double submission.

## Settings page conventions
- Order: common -> appearance/language -> account/data -> about (version and updates).
- Put the version number and the update entry in "About".

## Performance and caching
- Compress images, lazy-load; static resource URLs carry a `?v=` version, bump it when changed.
- After deploying confirm key resources return 200 with `curl`.

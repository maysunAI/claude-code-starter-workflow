---
name: webapp-testing
description: "After changing the web front end/back end, verify that it really works online: two viewports (phone about 390 / PC about 1400) for horizontal overflow, JS errors in the console, click through the key flow, save screenshots in the project folder. Use when the user says 'test it', 'verify', 'the phone display is wrong', 'check it online after the change', 'Playwright', 'screenshot'."
---

# Web verification (online first)

## Method
Use Playwright (`pip install playwright && playwright install chromium`, or the Node version) against the **real URL**:

1. Open it once in each of two viewports: `390x844` (phone) and `1400x900` (PC).
2. Wait for the page to settle (`wait_for_load_state('networkidle')`).
3. Measure horizontal overflow: `document.documentElement.scrollWidth > innerWidth` means overflow.
4. Collect console errors: list the count and the first 5.
5. Click through the key flow (login, submit, switch language, ...); prefer id or text selectors.
6. Take screenshots and save them in **the project's own folder** with a full absolute path.

Minimal example (Python):
```python
from playwright.sync_api import sync_playwright
URL = "https://your-url/"
with sync_playwright() as p:
    b = p.chromium.launch(headless=True)
    for name, w, h in [("phone", 390, 844), ("pc", 1400, 900)]:
        pg = b.new_page(viewport={"width": w, "height": h})
        errs = []
        pg.on("console", lambda m: errs.append(m.text) if m.type == "error" else None)
        pg.goto(URL); pg.wait_for_load_state("networkidle")
        sw = pg.evaluate("document.documentElement.scrollWidth")
        print(name, "scrollWidth", sw, "viewport", w, "overflow" if sw > w else "ok", "errors", len(errs))
        pg.screenshot(path=f"/full/absolute/path/{name}.png")
    b.close()
```

## Must follow
1. Screenshots use a full absolute path in the project folder; never leave them in the root directory.
2. Do not change the user's real data: create test data yourself and delete it yourself; never DELETE a whole table.
3. Local pass != online works: after deploying run it again on the real URL; for new images or other binaries confirm each with `curl` for 200.
4. The feel on a real phone, the microphone, orientation lock cannot be tested by the script; write "not tested: ..." in the report, never "verified".

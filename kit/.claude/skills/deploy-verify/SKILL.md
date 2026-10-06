---
name: deploy-verify
description: "Fixed procedure to deploy website/service changes to your own server and verify them: back up -> syntax check -> upload -> restart -> curl online -> click through in a browser -> write a record. Use when the user says 'deploy', 'go live', 'push to the server', 'roll back', 'restart the service'. If unsure, do not deploy; ask the user first."
---

# Deploy + verify (do every step, do not skip)

First write into the project `CLAUDE.md`: server address, deploy directory, service name, domain. If missing, ask the user; do not guess.

1. **Back up**: `ssh <server> "mkdir -p <dir>/.bak_<date> && cp <files to change> <dir>/.bak_<date>/"`. Rollback = copy back + restart.
2. **Syntax check**: Node `node --check <file>`, Python `python -m py_compile <file>`. If front-end JS changed, add 1 to the `?v=` version where the page references it (avoid cache), and bump the parent file that references it too.
3. **Upload**: `scp` to the directory. Before changing nginx back it up, run `nginx -t`, then `systemctl reload nginx`; only add your own server/location, never touch others'.
4. **Restart** (only if the backend changed): `systemctl restart <service> && systemctl is-active <service>`.
5. **Verify online**: `curl -s -o /dev/null -w "%{http_code}" <url>` for key URLs (home, API, new images and static files; if one is 404, check the other files in the same directory); then really click through with browser automation.
6. **Report**: state what was NOT tested (real phone, concurrency, ...); never write untested things as "verified".
7. **Record**: add 3-5 lines to the project `CLAUDE.md` (what changed, backup directory, what was not tested).

## Red lines
- On live data delete only test records **you created yourself**; never DELETE a whole table or wipe it.
- Do not touch another project's nginx config.
- Never put passwords/tokens in a skill, a reply or git; keep secrets in `secrets/*.env` (in `.gitignore`); at run time the environment variables on the server are the authority.
- Heavy jobs (video transcoding, big downloads) one at a time, check memory with `free -m` first.
- When unsure or suspecting a problem: do not deploy, confirm with the user.

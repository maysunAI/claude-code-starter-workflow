---
description: End-of-session save: what was done, what is unfinished, update RESUME.md for next time
---

When the user types /session-end, do this in order:

1. List every file changed or added in this session (use `git status` or your own list; full paths).
2. Append a section to the end of `SESSION_LOG.md`: date / what was done / what is unfinished / pitfalls met.
3. Update `RESUME.md` so it only contains: where to start next time (3-5 items), decisions the user must make, key file paths.
4. If `reply.md` is over 2000 lines, tell the user to back it up; do not delete anything yourself.
5. Finally tell the user: which files were added/updated (full paths), and the first sentence to say to Claude next time.

Never put keys or passwords in the save notes.

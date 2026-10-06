---
description: Show the workspace state: req/reply line counts, open tasks, next step from last session
---

When the user types /status, output a short status report:

1. Count the total lines of `req.md` and `reply.md` (use `wc -l`, not methods that miscount) and find the line number of the last `══` block in reply.
2. Read `TASKS.md` (if present) and list "in progress" and "pending" items, high priority first.
3. Read `RESUME.md` (if present) and extract the "next step".

Output format:

```
=== Current status ===
📄 req: XX lines   reply: XX lines (last block at line XX)
🔄 In progress: ...
📋 Pending (high priority): ...
📌 Next step from last session: ...
```
If a file does not exist write "(none)"; do not make things up.

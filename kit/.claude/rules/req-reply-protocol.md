# Rule: req / reply communication protocol

Purpose: keep "what the human says" and "what the AI answers" in two files, with line numbers, so they can be looked up later and do not vanish when a session is cleared.

## Files
- `req.md`: I write requests here (casual is fine, one per line).
- `reply.md`: you write answers here. Only APPEND new blocks at the end of the file; never rewrite, merge or delete old blocks.

## Trigger
When I say "req updated" or "after req line N": first read `req.md` and check it has enough lines (if not, say "the file may not be saved"), then answer.

## reply block format
```
══════════════════════════════
❓ [date time]
Original:
1. (paste the req text verbatim)
2. (paste the req text verbatim)

Reorganised questions (mapped to the original)
1. (original [1][2]) the reorganised question
───────────────────────────────
Answers
1. (original [1][2]) title
   Answer (plain text, no tables or Markdown marks, because I read the raw text with line numbers)
Status: [1] ✅  [2] ⏳ waiting for confirmation
📌 req lines X-X → reply line XX ✅
```
- The original must be verbatim; "the gist" is not allowed.
- The reorganised-questions mapping must always be there. If one number has several sub-points, map and answer each one; never merge them and drop one.
- `reply line XX` is the line number of this block's `══` line; check it with a search after writing, never write "here".
- In the terminal output only: one line of confirmation + `✅ req lines X-X → reply line XX`.

---
name: skill-writer
description: "Process for writing a new skill or improving an existing one: decide whether it is worth writing, how to split it (entry SKILL.md + sub-files read on demand), how to write trigger words in the description, how to keep it small. Use when the user says 'write a skill', 'turn this into a skill', 'the skill did not trigger', 'the skill is too big'."
---

# Writing a skill

## 0. First decide if it is worth it
Worth it: the same kind of job done >=2 times with fixed steps; pitfalls that can become a checklist; reusable scripts.
Not worth it: done once; already covered by a rule or command; just a pile of links (links cannot be searched or triggered, so the key points must be in the body).

## 1. Structure
- One skill = one folder, entry `SKILL.md`, starting with `name` (same as the folder) + `description`.
- Simple ones need only one SKILL.md. Complex ones: the entry holds only "routing + key rules", details go to `references/*.md`, fixed actions to `scripts/*.py`, and the body says "when to read which file".
- Treat scripts as black boxes: the body says "run --help first, do not read the source".

## 2. The description decides whether it triggers
- One paragraph: "what it does + what the user would say"; list the words users really use.
- Also say when it should NOT trigger.
- At most about 600 characters.

## 3. Size
Entry SKILL.md target <=5KB, hard limit 12KB; above that, split into references.

## 4. Must do after writing
1. Find a real task that triggers it once and check it behaves as intended.
2. Add one line to the project `CLAUDE.md` with the skill name.
3. Never store keys/passwords in a skill (paths may be written, values not).

## 5. Where to put it
- Personal, for all projects: `~/.claude/skills/<name>/SKILL.md`
- Only for one project: `.claude/skills/<name>/SKILL.md` inside the project

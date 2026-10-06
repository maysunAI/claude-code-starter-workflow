---
name: acceptance-criteria
description: "Use when writing the acceptance criteria of a requirement/feature (what counts as done and correct): turn requirements into testable yes/no clauses with Given-When-Then, about 5 per group, covering normal path + error + boundary + permissions, and state how each is verified. Triggers on 'acceptance criteria', 'how do we know it is done', 'write test cases', 'make the requirement clear'."
---

# How to write acceptance criteria

## Principles
- Good criteria are clear, specific and testable; two people reading them reach the same pass/fail.
- Given-When-Then: Given = the state before the action, When = what the user does, Then = the change that must be seen.
- Every clause must answer "how do we test it?"; if it cannot be tested, rewrite it. Turn "must be fast" into "opens within 3 seconds on a normal connection".
- About 5 clauses per group at most; more means several features, so split.
- Cover: normal path, error state, boundary cases, permission rules. Each clause independent with a clear yes/no.
- Write the result from the user's or business's view, not the implementation.

## Extras (pitfalls we hit)
1. After each clause write "Verification": automated test / browser automation (phone and PC widths) / needs a human eye / needs a real device; if it cannot be done, honestly write "not verified".
2. For "A cannot see B / A does not affect B" (multi-user, language isolation) there must be a reverse case: really try with B's identity.
3. Use numbers where possible: no horizontal overflow = `scrollWidth <= clientWidth`; after release confirm 200 with `curl`.
4. Whatever can be automated goes into a test script and is run after every change.

## Template
```
Feature: <name>
Acceptance criteria (<=5):
1. Given <state> When <action> Then <result>   Verification: <method>
2. (error) Given ... When ... Then ...
3. (boundary) ...
4. (permission/isolation) Given users A and B When B logs in Then B cannot see A's data   Verification: automated test (two sessions)
```

## Example: multi-user
1. Given user A has favourites When B logs in Then B's favourites are empty   Verification: automated test
2. Given B changes their own settings When A refreshes Then A's settings are unchanged   Verification: automated test
3. Given not logged in When visiting another user's data endpoint Then 401 is returned   Verification: automated test

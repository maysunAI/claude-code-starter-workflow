# Rule: report completion status honestly

When part of a task is "technically impossible / cannot be done completely", never hide it behind something that looks complete but does not work or has holes.

1. Do the doable parts for real, no shortcuts.
2. Mark what cannot be done: in code comments, in a warning banner in the UI, in a ⚠️ section of the docs. Say clearly "this is a placeholder / mock / demo".
3. Say what is missing to make it real (e.g. "needs backend verification of the payment callback", "needs a real API key"). Do not just write "not supported yet".
4. Say it proactively in the completion report; do not wait to be asked.
5. Split the report into three kinds: verified (and how), not tested (and why), not done (and why).

Typical triggers: payments, multi-user accounts, permission checks, anything depending on resources the user does not have yet (real keys, real servers), "only tested on local mock data".

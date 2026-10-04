# Verification summary (phase 5, lead)

Four verifiers on the merged draft: claude-opus-5-5, claude-sonnet-5-5,
gpt-6.1-sol, gpt-6-astra (reports alongside). Model IDs, prices, the 272K
billing rule, and Claude effort defaults held across the board. The codex
verifiers were stricter, marking advice ("avoid `max` unattended") UNSUPPORTED
as unproven policy; those were kept as advice where the data motivates them,
rephrased to say why.

Fixed or dropped, by evidence quality:

| claim | verdicts | decision |
| --- | --- | --- |
| all speed and wall-clock claims (Astra fastest, Fable slowest, 6.1 Sol fast, Claude 2-3x slower, "when time matters go codex") | FAILS in all four | dropped; AA throughput and Vals task time contradict each, and the orderings flip with effort and workload |
| Fable edges: recall, competitive coding, fewer tokens than Opus | FAILS/UNSUPPORTED in all four (IOI favors Opus; AA-Omniscience favors Opus) | dropped |
| Fable "doesn't measurably beat Opus on hard problems" | partly FAILS (leads in some classes) | "doesn't beat Opus 5.5 overall (leads only in some problem classes)" |
| Sonnet "Opus-class on most work", "cost at Opus level", "best terminal scores of any model" | FAILS/UNSUPPORTED in all four | "close to Opus at high effort", "among the strongest on terminal-heavy loops", cheaper than Opus below `max` |
| Opus "strongest on software" | FAILS (astra) | "among the strongest" |
| Opus `max` "can run for hours" | UNSUPPORTED (AA 1.1 h average) | "runs long" |
| Astra "strongest on science", "overthinks small tasks" | FAILS / UNSUPPORTED | "top on mechanism problems (Vals), strong on novel math"; overthinking dropped |
| 6.1 Sol "best cost-to-quality", "a fifth to a tenth" | UNSUPPORTED/FAILS (ratios vary beyond both ends) | "excellent", "several times less per task" |
| 6.1 Sol `xhigh` beats `max` "at two-thirds the cost" | number FAILS (about half) | "matches or beats its own `max` at about half the cost" |
| "effort is a bigger lever than model choice" | FAILS (two) | "a lever comparable to model choice" |
| effort spans "5x to 18x" | minor FAILS (Astra 4x) | "roughly 4x to 18x" |
| Claude 5.5 emit "4-7x" Astra's output tokens | FAILS (Sonnet about 9.7x, single source) | "roughly four to ten times", at `max` |
| codex models default to `medium` | UNSUPPORTED (client/account dependent) | dropped |
| previous gen "beaten on both quality and cost" | FAILS for GPT-5.6 Luna (2 points higher on one coding index, 2x the cost) | "better, cheaper, or both" |

Ratings: no verifier made a rating look clearly wrong. Several noted Sonnet's
cost sits below Opus below `max`, consistent with the user-review revision.

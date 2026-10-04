# Open-problem sweep

Decision (Daniel, 2026-10-04): the known results we tried were too short to need a harness, so the project now attempts open problems.
Stage 1 is a sweep: one bounded attempt of about an hour on each of 16 open statements from formal-conjectures.
Stage 2 goes deep on the two or three problems where stage 1 made real progress.
Nothing is claimed or posted from either stage without a second check and Daniel's approval.

## Method

The instructions every sweep session follows are in `SWEEP.md` on the branch `sweep/base`.
They follow Terence Tao's Claude Code workflow: instructions in a file, work in phases, write the argument before any Lean, build a Lean skeleton first, and keep a lessons file.
Each attempt has four phases: understand and red-team the statement, try to break it by computer search, try to prove it, report.
The session commits after every phase, so notes survive a dead session.
Each problem has its own branch `sweep/<id>` and its notes land in `sweep/<id>/NOTES.md` there.
Sessions run as plain cloud sessions on Claude Opus 5.5 at effort xhigh in the environment `erdos-lean`; Fable 5.1 is kept for stage 2.
A result of `solved`, `disproved` or `statement-flaw` gets a frozen challenge in the checker repository and the statement checks before anyone repeats it.

## Candidates

The 16 problems come from a scan of the open statements in formal-conjectures at the pin (candidate list and small-case checks: 2026-10-04).
Four more candidates are playable in the picker page but left out of the sweep because they are old or famous: Kotzig, the curling number conjecture, Chvátal, strong sensitivity.
Picker page for Daniel: https://claude.ai/artifact/JvActjQ4n1QcNZdh6PuDUz

## Sessions

Credit meter before the sweep: 218 USD.
Cap for stage 1: about 80 USD.

| id | problem | session | start (UTC) | result | what the session established | prior work found |
|----|---------|---------|-------------|--------|------------------------------|------------------|
| a076495 | no x with sigma(x) mod x = 5 | session_01LBnzQfRuFdCotsipkQcjRJ | 2026-10-04 about 08:59 | partial | Lean: any solution is a square, twice a square, or odd with σ(x) ≥ 3x+5. Computed: none below 10^21. | open; AI benchmark runs failed |
| txgraffiti3 | i(G) ≤ saturation number, regular graphs | session_01EqkqwWzxQHEaZLRSn5eUdC | 2026-10-04 about 09:01 | partial | Lean: true for r = 1 and for dense graphs (4r ≥ 3n). No counterexample found up to 60 vertices by local search. | disproved elsewhere (cubic graph on 50 vertices) |
| a077408 | reverse and add in base 3 from 103 | session_01Uo1A5phCnLCSea9M9ZnYCw | 2026-10-04 about 09:07 | partial | Lean: no palindrome in the first 1000 terms; an equivalent "carry-free" form. Computed: none in 10^6 steps. | open; AI benchmark runs failed |
| txgraffiti2 | zero forcing ≤ α + 1, subcubic | session_01JHXrsTxR5rVVAgnc52RdL9 | 2026-10-04 about 09:08 | partial | Lean: Z ≤ n-1, K4 exclusion needed, prism is tight. Exhaustive to 17 vertices: no counterexample. | disproved elsewhere (24 vertices, arXiv 2607.23664) |
| catchup | Catch-Up draw when the total is even | session_017GF8mFiJ9Z3JjXMTdSDt7F | 2026-10-04 about 09:08 | partial | Lean: true for N ≤ 8, and the converse for all N. Computed: true for N ≤ 28. New stronger "pairs" statement that would imply it. | partial elsewhere (N = 23, 24 computed) |
| a004290 | 0/1 multiples largest at 10^k - 1 | session_015Tafu7joZkMCMmxsCnsLm8 | 2026-10-04 about 09:09 | partial | Lean: true for k ≤ 3 and a reduction. Computed: k ≤ 7. Found an infinite family with zero margin. | open; about 20 AI benchmark runs failed |
| wowii198a | Graffiti.pc 198a | session_01JLYDv82r94qbGAChXB13uL | 2026-10-04 about 09:10 | partial | Lean: true except possibly for self-centered graphs of eccentricity 2 or 3; paper argument for those. | solved elsewhere (Cohen, Lean, September 2026) |
| wowii40 | Graffiti.pc 40 | session_01DUem6d7jnUEkXAEGCXdx3s | 2026-10-04 about 09:10 | partial | Lean: true for trees and for graphs with a Hamiltonian path. Exhaustive to 11 vertices. | partial elsewhere (same range) |
| wowii61 | Graffiti.pc 61 | session_01AmuUB8918XumjcsLrWAgnY | 2026-10-04 about 09:11 | partial | Lean: conditional cases (diameter ≤ 3, 5, 6, trees), given a classical residue bound. A stronger variant is false. | partial elsewhere |
| wowii19 | Graffiti.pc 19 | session_01RXednorb5oidqgp4JQTbmK | 2026-10-04 about 09:12 | solved | Lean proof, accepted by the checker. | solved elsewhere (July 2026) |
| eq677 | equation 677 versus 255, finite magmas | session_017FZYmEGV9ZMtezeequwDqH | 2026-10-04 about 09:12 | partial | Lean: no affine model with commuting coefficients separates the two laws. | partial elsewhere; a well-known hard problem |
| minmodulus | minimum modulus for valid sets | session_018KDCAoHvtu4cEMNDiW2Qjj | 2026-10-04 about 09:13 | partial | Lean: no valid set below 2^(n-1) for any n, and the conjecture for n ≤ 4. Computed: n ≤ 8. | partial elsewhere (the matching construction) |
| wowii100 | Graffiti.pc 100 | session_01FXhruPF1fSKbuPxkB892Jz | 2026-10-04 about 09:14 | solved | Lean proof, accepted by the checker. | solved elsewhere (August 2026) |
| wowii133 | Graffiti.pc 133 | session_01JcW3GVzAM4MCTeZZaBpJAt | 2026-10-04 about 09:14 | partial | Lean: reduced to C4-free graphs with l(G) > 2. Exhaustive for C4-free graphs to 12 vertices. | partial elsewhere |
| tanarctan | tan-arctan sum never an integer | session_01RrupiiSSGNbR4s8QuhCM3Y | 2026-10-04 about 09:15 | partial | Lean: true for 5 ≤ n ≤ 50000. Computed: no integer value for n ≤ 4·10^9. | partial elsewhere (paper and Lean lemmas) |
| a000224 | squares mod n and odd primes | session_01MPhFhb8LMKhPazoZhNS3nB | 2026-10-04 about 09:16 | partial | Lean: true for even n and for products of two odd primes. Computed: no counterexample below 4·10^9. | open; AI benchmark runs failed |

## Findings so far (2026-10-04)

Two sessions proved their statements in Lean in about 11 minutes each, and the checker accepted both:

- `wowii19` (Written on the Wall II conjecture 19): commit `825dd65`, checker run https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37192840938, verdict "Your solution is okay!".
- `wowii100` (Written on the Wall II conjecture 100): commit `feee002`, checker run https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37192842670, verdict "Your solution is okay!".

Neither is new.
Conjecture 19 has a Lean-verified proof by Chen, Wang and Feng dated 2026-07-02, and conjecture 100 has a proof by Kias Henry dated 2026-08-13 (Zenodo 10.5281/zenodo.21914031) that the list's maintainer confirmed.
Conjecture 198a also has a claimed proof (Ben Cohen, July 2026, Lean-verified September 2026).
formal-conjectures still tags all three as open, so the tag alone does not show that a problem is open.
The candidate scan checked the tag and missed this; a prior-work check on all 20 candidates now runs before stage 2 picks anything.

## Stage 1 result (2026-10-04)

All 16 sessions finished within about 55 minutes of the first launch.
Result: 2 `solved` (both already known elsewhere, both accepted by the checker) and 14 `partial`.
No session reported a false success, and every session ran the statement check.
Cost: the credit meter went from 218 to 135 USD, so the sweep cost 83 USD, about 5 USD per problem.
The prior-work check (2026-10-04, `scratchpad/prior-work.json` in the working session) found that 5 of the 16 were already settled by others: three proved (19, 100, 198a) and two disproved (TxGraffiti 2 and 3).
The four OEIS problems have no resolution anywhere, and the OEIS Open benchmark (arXiv 2608.11941) reports failed language-model attempts on them.
Each session's notes are in `sweep/<id>/NOTES.md` on its branch `sweep/<id>`.

## Stage 2: deep attempts (started 2026-10-04)

Daniel approved two problems: `catchup` and `a000224`.
Each runs as one long cloud session that follows `DEEP.md` on its branch `deep/<id>`.
The session is the manager (Claude Fable 5.1 at effort xhigh); it keeps `deep/<id>/NOTEBOOK.md`, gives single items to fresh Opus workers with a 30-minute box, has every paper proof attacked by a second worker, and commits after each attempt.
It stops at a Lean proof or disproof, after four hours, after ten attempts, or when a file `STOP` appears on the branch.
`LESSONS.md` on these branches collects the lessons of all 16 sweep sessions.
Budget: about 50 USD per problem; the credit meter stood at 135 USD at the start, and 20 USD stay in reserve.

| id | lead from stage 1 | session | start (UTC) | result |
|----|-------------------|---------|-------------|--------|
| catchup | a "pairs" statement that would imply the conjecture, checked on 75,024 cases | session_01BgcwTHbspsRCH9oTH5owpW | 2026-10-04 about 10:05 | partial (10 attempts, done 11:07) |
| a000224 | proved for even n and for products of two odd primes; odd n with three or more prime factors remains | session_014KabgfrVeJMmKfShp1xwzq | 2026-10-04 about 10:08 | partial (10 attempts, done 11:28) |

### Stage 2 result (2026-10-04)

Neither conjecture is proved.
Both sessions used all ten attempts in about 80 minutes, kept their notebooks, and reported `partial`.
Cost: the credit meter went from 135 to 67 USD, so stage 2 cost 68 USD.

`catchup` (branch `deep/catchup`, commit `f0b660a`, notebook `deep/catchup/NOTEBOOK.md`):

- Lean, no sorry: the conjecture for every N ≤ 16, through strategy certificates that the kernel checks (`CatchUpDeep.catchup_draw_le_16`).
- Lean, no sorry: the conjecture follows from four explicit statements about unions of pairs {a, a+1} (`catchup_of_GE_T2_T4_P3`).
  The four statements are checked by computer inside {1..20} and are not proved.
- Where it stopped: the "mover has a good pick" half has no simple pick rule; the exceptions sit on an arithmetic zone.

`a000224` (branch `deep/a000224`, commit `f6dd3a8`, notebook `deep/a000224/NOTEBOOK.md`):

- Lean, no sorry: the conjecture holds for every n that is even, prime, a prime power, pq, p²q or p³q (`A224Deep.conjecture_of_structure''`).
  So a counterexample is odd, has at least two distinct prime factors and at least three prime factors in total, and is not p²q or p³q.
- Computed: no counterexample below 1.6·10^10.
- The session's next step: finish p^e q for every e ≥ 4, which it estimates at three more attempts.

The statements above are the sessions' own reports.
Independent builds in GitHub Actions passed for both branches: `lake build Challenge Solution` from a clean checkout succeeded for `deep/a000224` (run 37198914280, 630 seconds) and for `deep/catchup` (run 37198912579, 3709 seconds).
The last step of that workflow, the axiom report, fails on these branches because it reads a theorem name from the placeholder `Challenge.lean`; it is not a proof failure, and the axioms of the partial theorems were reported by the sessions only.
The partial theorems have not been through the checker, because they are not the frozen conjecture statements.


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

| id | problem | session | start (UTC) | result | notes |
|----|---------|---------|-------------|--------|-------|
| a076495 | no x with sigma(x) mod x = 5 | session_01LBnzQfRuFdCotsipkQcjRJ | 2026-10-04 about 08:59 | running | |
| txgraffiti3 | i(G) ≤ saturation number, regular graphs | session_01EqkqwWzxQHEaZLRSn5eUdC | 2026-10-04 about 09:01 | running | |
| a077408 | reverse and add in base 3 from 103 | session_01Uo1A5phCnLCSea9M9ZnYCw | 2026-10-04 about 09:07 | running | |
| txgraffiti2 | zero forcing ≤ α + 1, subcubic | session_01JHXrsTxR5rVVAgnc52RdL9 | 2026-10-04 about 09:08 | running | |
| catchup | Catch-Up draw when the total is even | session_017GF8mFiJ9Z3JjXMTdSDt7F | 2026-10-04 about 09:08 | running | |
| a004290 | 0/1 multiples largest at 10^k - 1 | session_015Tafu7joZkMCMmxsCnsLm8 | 2026-10-04 about 09:09 | running | |
| wowii198a | Graffiti.pc 198a | session_01JLYDv82r94qbGAChXB13uL | 2026-10-04 about 09:10 | running | |
| wowii40 | Graffiti.pc 40 | session_01DUem6d7jnUEkXAEGCXdx3s | 2026-10-04 about 09:10 | running | |
| wowii61 | Graffiti.pc 61 | session_01AmuUB8918XumjcsLrWAgnY | 2026-10-04 about 09:11 | running | |
| wowii19 | Graffiti.pc 19 | session_01RXednorb5oidqgp4JQTbmK | 2026-10-04 about 09:12 | running | |
| eq677 | equation 677 versus 255, finite magmas | session_017FZYmEGV9ZMtezeequwDqH | 2026-10-04 about 09:12 | running | |
| minmodulus | minimum modulus for valid sets | session_018KDCAoHvtu4cEMNDiW2Qjj | 2026-10-04 about 09:13 | running | |
| wowii100 | Graffiti.pc 100 | session_01FXhruPF1fSKbuPxkB892Jz | 2026-10-04 about 09:14 | running | |
| wowii133 | Graffiti.pc 133 | session_01JcW3GVzAM4MCTeZZaBpJAt | 2026-10-04 about 09:14 | running | |
| tanarctan | tan-arctan sum never an integer | session_01RrupiiSSGNbR4s8QuhCM3Y | 2026-10-04 about 09:15 | running | |
| a000224 | squares mod n and odd primes | session_01MPhFhb8LMKhPazoZhNS3nB | 2026-10-04 about 09:16 | running | |

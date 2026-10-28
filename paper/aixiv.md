# aiXiv submission fields (for the manual form; no agent sessions are attached)

Title: Untrusted Prover, Trusted Referee: 26 Lean Proofs for formal-conjectures from an AI Agent Judged by an External Checker

Authors: Daniel Puri

Primary category: math.CO (also math.NT, math.LO)

AI contribution label: AI-authored (the Lean proofs and the text were written by AI agents under the author's direction)

AI models: Claude Opus 5.5 (Claude Code cloud sessions), Claude Fable 5.1 (Claude Code), Lean 4 v4.33.1 with Mathlib, Comparator

Repository: https://github.com/danielpuri1901/erdos-lean-formalization

Abstract: see paper/main.tex (the abstract environment).

Process summary:
Each known result got one bare Claude Code cloud session with a task file: the exact statement taken with type_of% from formal-conjectures, the published argument in a few lines, and working rules from Terence Tao's Claude Code recipe (argument in prose first, skeleton with sorry, fill one hole at a time, small kernel checks).
The agent pushed a submit commit; a separate checker repository rebuilt the commit, replaced the statement with its frozen copy, ran Comparator in a landrun sandbox, and wrote the verdict as a commit status.
Open problems got one hour each in the same setup, then two of them got a manager session with ten attempts.

Verification notes:
Every accepted proof passed Comparator (leanprover/comparator, commit 3927ad3) against the frozen statement with the axioms propext, Quot.sound and Classical.choice only; native_decide, implemented_by, unsafe and extra axioms are rejected.
The checker's statement tests compare the elaborated type of each frozen challenge with the library statement.
The checker's negative tests include seven cheating proofs, among them one that printed the success line during its build.
Logs: PROOFS.md in the repository links each proof to its checker run.

Negative results:
No open problem was solved: 16 one-hour attempts and two ten-attempt runs gave partial results only (Catch-Up for N <= 16; A000224 for n even, prime, a prime power, or p^e q).
Two known results were not finished in their time box without a proof sketch: Chen and Saito (min degree 3 forces a cycle of length divisible by 3) and the Danzer-Klee snake-in-the-box bound.
Two "solved open problems" from the sweep turned out to be already solved by other people; the library's open tag was out of date.
Several of the filled holes have earlier Lean proofs elsewhere (Erdős 105 n-4, A112970, Giuga implies Carmichael, Graffiti.pc 100, R(4,4)).

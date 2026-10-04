# Task: the cube digraph for m = 2 has no Hamiltonian arc decomposition

## Goal

`Solution.lean` must contain

```lean
theorem cube_no_decomposition_m2 : type_of% @ClaudesCycles.cube_hamiltonian_arc_decomposition_impossible_m2
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

The cube digraph on (Z/2)^3 has no decomposition of its arcs into three directed Hamiltonian cycles (Aubert and Schneider, 1982).
Read `HasHamiltonianArcDecomposition`, `IsDirectedHamiltonianCycle` and `bumpAt` in `FormalConjectures/Paper/ClaudesCycles.lean` first.
For m = 2 there are 8 vertices and 24 arcs, and an arc flips one coordinate.
The statement is finite.
A direct kernel check over all triples of permutations is far too large, so reduce first: each of the three permutations sends v to `bumpAt (f v) v` for a choice f : vertex -> Fin 3, and at every vertex the three choices are distinct.
Then either find a short argument, or enumerate the directed Hamiltonian cycles of the 3-cube with a certificate and check that no three of them are arc-disjoint.

## How to work

- Read `LESSONS.md` first. It holds what earlier sessions learned about this Lean version, kernel checks and memory.
- Write the argument and the plan into `NOTES.md` before any Lean.
- Build a skeleton first: definitions, then every lemma stated with `sorry` and a passing build, then fill the `sorry`s one at a time.
- Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`.
- Commit and push after every step that builds.
- Keep every kernel check small.
  The checker machine has 7.8 GB of memory plus swap and builds 4 modules at the same time.
- Do not search the web for solutions and do not look for existing formalizations.
- Ignore `Solution/Green72`, `data/sources`, `Timing*` and `scripts/witness.py`: they are leftovers from an earlier target.

## Submit

When the proof builds with no `sorry`, commit with a message that starts with `submit(claudecycles2):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/claudecycles2` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 40 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.

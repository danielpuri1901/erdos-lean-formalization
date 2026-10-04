# Task: a Lean proof that TxGraffiti conjecture 2 is false

## Goal

`Solution.lean` must contain

```lean
theorem txgraffiti2_false : ¬ (type_of% @Arxiv.«2507.17780».tx_graffiti_conjecture_2)
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

The conjecture says: a connected graph with maximum degree at most 3, other than K4, has `zeroForcingNumber ≤ indepNum + 1`.
M. Fischer (arXiv 2607.23664) gives a connected graph H on 24 vertices with maximum degree 3, independence number 9 and zero forcing number 11.
`data/txgraffiti2/H24.edgelist` is that graph, and `data/txgraffiti2/SOURCE.md` describes the construction and what was checked.
Credit the paper in a comment in `Solution.lean`.

## What the Lean proof needs

1. The graph as a `SimpleGraph (Fin 24)` with decidable adjacency; it is connected; its maximum degree is at most 3; the K4 hypothesis holds because the graph has 24 vertices.
2. `indepNum ≤ 9`: no independent set has 10 vertices.
   The graph is a triangle, three bridge vertices and six triangles, so a short structural argument or a small certificate is enough.
3. `11 ≤ zeroForcingNumber`: no set of 10 or fewer vertices forces the whole graph.
   A direct check of all 1.96 million sets of size 10 is too heavy for the kernel.
   The paper uses forts: a fort is a nonempty set F such that no vertex outside F has exactly one neighbour in F, and a zero forcing set meets every fort.
   Each of the three branches (a bridge vertex with its two triangles, 7 vertices) contains 12 forts, every set that meets them has at least 3 vertices in the branch, and only 17,712 sets of size at most 10 survive; each of those fails to force.
   Prove the fort lemma for the definition of `zeroForcingNumber` in formal-conjectures (read it first), then check the surviving sets with a `Bool` checker on `Nat` bitmasks and `decide +kernel` in chunks.
   The disproof of TxGraffiti conjecture 3 earlier today used `Nat` bitmasks, a certificate, a soundness lemma and chunked kernel runs; that pattern works.
4. Combine: 11 ≤ Z ≤ α + 1 ≤ 10 is false.

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

When the proof builds with no `sorry`, commit with a message that starts with `submit(txgraffiti2):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/txgraffiti2` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 15 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 90 minutes of work, whichever comes first; waiting for a verdict does not count.
If you stop without success, write in `NOTES.md` exactly what is proved and what is missing, and commit it.
Do not ask questions; decide and write the decision into `NOTES.md`.

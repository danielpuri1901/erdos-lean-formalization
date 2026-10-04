# Task: a Lean proof that TxGraffiti conjecture 3 is false

## Goal

`Solution.lean` must contain

```lean
theorem txgraffiti3_false : ¬ (type_of% @Arxiv.«2507.17780».tx_graffiti_conjecture_3)
```

with no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` or `unsafe`, and only the axioms `propext`, `Quot.sound` and `Classical.choice`.
`Challenge.lean` holds the frozen statement; do not edit it.
A separate checker repository decides success; nothing printed in this session counts.

## The mathematics is known

The conjecture says: every r-regular graph with r ≥ 1 has `indepDominationNumber ≤ saturationNumber`.
`data/txgraffiti3/counterexample.edgelist` is a connected cubic graph on 48 vertices with independent domination number 16 and a maximal matching of size 15.
`data/txgraffiti3/SOURCE.md` says where it comes from and what was checked.
Credit the source in a comment in `Solution.lean`.
The edge list is the only outside input: write your own programs and your own certificate, and do not fetch anything else from the source repository or the web.

## What the Lean proof needs

1. The graph as a `SimpleGraph (Fin 48)` with decidable adjacency, and `∀ v, G.degree v = 3`.
2. `saturationNumber ≤ 15`: the 15 edges {0,1}, {2,3}, ..., {28,29} are a maximal matching.
   Read the definitions `IsEdgeMatching`, `IsMaximalEdgeMatching` and `saturationNumber` in `FormalConjecturesForMathlib` first; a witness plus `Nat.sInf_le` should be enough.
3. `16 ≤ indepDominationNumber`: no independent dominating set has 15 or fewer vertices.
   A direct `decide` over all subsets is far too large.
   Use a certificate: generate a search tree with your own program (branch on an undominated vertex over its closed neighbourhood; a chosen vertex dominates at most 4 vertices), write a `Bool` checker for the tree in Lean, prove the checker sound, and run it with `decide +kernel`.
   About 125 thousand nodes are enough with that bound; split the tree into chunks so that each kernel run stays small.
4. Combine 2 and 3 with the conjecture's inequality to get `False`.

## How to work

- Read `LESSONS.md` first. It holds what earlier sessions learned about this Lean version, kernel checks and memory.
- Write the argument and the plan into `NOTES.md` before any Lean.
- Build a skeleton first: definitions, then every lemma stated with `sorry` and a passing build, then fill the `sorry`s one at a time.
- Build with `export PATH=/opt/lean/bin:$PATH && lake build Solution`.
- Commit and push after every step that builds.
- Keep every kernel check small.
  The checker machine has 7.8 GB of memory plus swap and builds 4 modules at the same time; one `decide +kernel` that needs several GB can kill it.
- Ignore `Solution/Green72`, `data/sources`, `Timing*` and `scripts/witness.py`: they are leftovers from an earlier target.

## Submit

When the proof builds with no `sorry`, commit with a message that starts with `submit(txgraffiti3):` and push.
Then poll `gh api repos/danielpuri1901/erdos-lean-formalization/commits/<sha>/status` until the status `comparator/txgraffiti3` is success or failure.
The checker picks the commit up within a few minutes; a verdict takes 30 to 60 minutes.
On failure, read the status description, fix, and submit again.
Stop at success or after 3 hours.
Do not ask questions; decide and write the decision into `NOTES.md`.

# Preflight record

## Pins

- formal-conjectures: `df3f12d7bd06feb3f71ae37abae0ca7cb798d9b1` (resolved 2026-10-02 from `df3f12d7bd06`).
- Lean toolchain: `leanprover/lean4:v4.33.1` (same as the formal-conjectures pin).
- Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474` (tag `v4.33.1`), inherited from the formal-conjectures manifest.

## Module system

The formal-conjectures problem files are module files (`module`, `public import`, `@[expose] public section`).
A plain, non-module `Challenge.lean` or `Solution.lean` that says `import FormalConjectures.GreensOpenProblems.«72»` builds without changes (build run 37025309583, 2026-10-02, 338 seconds with the Mathlib cache).
Plan Task 1 step 4 (converting the files to modules) was not needed.

## Axioms of the trivial target

`challenge_trivial` depends on `[propext, Classical.choice, Quot.sound]` even with the proof `Iff.rfl`, because the statement itself uses classical definitions (`sSup`, `Collinear`).
Every audit therefore accepts any subset of the permitted axioms, not only the empty set.

## Checker on the trivial target

- Green run: https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37027530432 on agent commit `5e8c05f3daa24784dd608ddfef479fee5f51f0a0`; Comparator printed `Your solution is okay!` and the commit status `comparator/trivial` is `success`.
- Comparator `v4.33.0` with its toolchain set to `v4.33.1` builds, exports, and accepts module-system imports; no lean4export change was needed.

## Freeze test

On a throwaway branch, `Challenge.lean` was edited to `theorem challenge_trivial : True := by sorry` and `Solution.lean` proved `True`.
The checker overwrote the challenge with its frozen copy and rejected the solution: `Challenge and solution theorem statement do not match: 'challenge_trivial'`.
Run: https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37028790977 (agent commit `13b56eb29960d4c30080e202534536bb4d831a54`, branch deleted afterwards).

## Green 72 kernel time

`lake build Timing` checked the N = 60 witness (120 points, about 280 thousand triples) by kernel reduction in 48 seconds (`Built Timing (48s)`, step total 49 seconds), run https://github.com/danielpuri1901/erdos-lean-formalization/actions/runs/37117333636, 2026-10-03.
The check is `decide +kernel` on a Nat-only collinearity test, with no `native_decide` and no extra axiom.
Decision (plan Task 10 step 6): under 600 seconds, so `decide +kernel` is viable for every N.
Scaling by triple count, all N from 3 to 60 (about 4.3 million triples) cost roughly 12 minutes of kernel time in one process, before Comparator's replay doubles it; one file per N lets `lake build` run them in parallel.

## Erdős 105 frozen statement

`challenge/erdos105.lean` in the checker repository elaborates at the pin, together with a `sorry` solution of the same statement (build run https://github.com/danielpuri1901/erdos-lean-formalization/actions/runs/37117378033 on a throwaway branch, since deleted).

## Erdős 105 statement audit

Written by Claude (Opus 5.5) on 2026-10-03 after Daniel delegated the launch ("No feedback needed from me. Just fix it until it works.").
It is not Daniel's own sign-off; spec section 4 item 5 still asks for his reading before any result is published.

- `ℝ²` is `EuclideanSpace ℝ (Fin 2)`, the Euclidean plane: a scoped notation in `FormalConjecturesForMathlib/Geometry/2d.lean`, opened by `open EuclideanGeometry`.
- `line[ℝ, p, q]` is Mathlib's notation for `affineSpan ℝ {p, q}`, the affine line through p and q when p ≠ q.
- The English variant (erdosproblems.com/105, and the docstring of `Erdos105.erdos_105.variants.sub_four`) asks whether, for disjoint finite sets A and B in the plane with |A| = |B| + 4 and A not collinear, some line contains at least two points of A and no point of B.
  The formal variant is `answer(sorry) ↔ ∀ A B, ...`.
  Xichuan's 10 plus 6 configuration answers it negatively, so the frozen challenge states `¬ ∀ A B, ...` with the inner formula copied verbatim from the pin.

## Erdős 105 warm-up

Result: `comparator/erdos105` is `success` on agent commit `fa529c095803742480e35c0441931d8bd238d9da` (checker run https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37128004279), 2026-10-03.
The accepted proof is archived in `solutions/erdos105.lean`; the ledger of the run is in `docs/ledgers/erdos105-warmup.md`.

- Attempts: 1. The worker (a fresh Opus 5.5 subagent at default effort) finished in about 4 minutes with 2 builds.
- Orchestrator: Opus 5.5 at effort xhigh, because Fable 5.1's weekly limit was used up; Fable's 8 minutes before the limit hit did no work.
- Cost: the cloud credit meter went from 247 to 243 USD across the warm-up and one Haiku smoke session, so the warm-up cost about 4 USD.
- Wall clock: launch at about 13:20 UTC, green status at about 14:10 UTC, mostly the orchestrator's preparation and one checker run (about 15 minutes).
- Failure types: none. Guard denials: 0. Cheating attempts caught: 0.
- Daniel's part: approvals (public dependency repository, autonomous launch); he did not touch the proof.
  The executor (Claude Opus 5.5, local session) built the harness, fixed the cloud setup, staged the target, and wrote the statement audit.

## Clark-Suen statement checks

Target `clarksuen`: `VizingConjecture.vizing_conjecture.variants.clark_suen` at the pin, frozen in the checker as `clark_suen`.
Paper: W. E. Clark and S. Suen, "An inequality related to Vizing's conjecture", Electronic Journal of Combinatorics 7 (2000), N4.
Its abstract says: γ(G)γ(H) ≤ 2γ(G□H) for all simple graphs G and H.
Daniel is not a mathematician, so the sign-off rests on three checks he can follow instead of a reading of the Lean code.
Checker run https://github.com/danielpuri1901/erdos-lean-checker/actions/runs/37155044227 (2026-10-03) ran checks 1 and 2 in `tests/statement/clarksuen.lean`:

1. Copy: the frozen statement is identical, symbol for symbol, to the formal-conjectures statement. A self-test shows the comparison tells apart a weaker statement (3 in place of 2).
2. Small examples: Lean proves γ = 0, 1, 2, 1, 1, 2, 2, 3 for the empty graph, one vertex, two vertices with no edge, a triangle, a 3-vertex path, a 4-vertex path, the square (2-path □ 2-path) and the 3 by 3 grid (3-path □ 3-path), the values a person counts by hand. The grid value 3 also shows that `□` is the Cartesian product: the strong product would give 1.
3. Blind back-translation: a separate Claude Sonnet 5.5 agent, given only the Lean code and no paper, wrote "the domination number of G times the domination number of H is at most twice the domination number of G □ H", for every finite simple graph, with `□` adjacent exactly when the pairs agree in one coordinate and are adjacent in the other. It found nothing suspicious.

The only difference from the paper's words: the Lean statement covers finite graphs, and the paper does not say "finite". Domination numbers in that paper are finite counts, so this matches its setting.
The same run rejected a `sorry` proof: `Illegal axiom detected: 'sorryAx'`.
Daniel signed off on 2026-10-03, after the three checks and a visual page where he checked the eight small graphs by hand (https://claude.ai/artifact/NsEoGB13HnaZHG9kvnUKMK).

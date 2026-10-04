# Minimum modulus for valid sets

- id: `minmodulus`
- source: `.lake/packages/formal_conjectures/FormalConjectures/Arxiv/2607.08366/MinModulus.lean`
- theorem: `min_modulus`
- kind: sets

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
**Conjecture 1 (Fonollosa, 2026).** For every $n \geq 2$ and every
$N < 2^n - 2^{\lfloor \log_2 n\rfloor}$, no set of $n$ residues mod $N$ is valid.

Equivalently the super-increasing set $\{2^k - 1 : 0 \leq k \leq n-1\}$ attains the least
valid modulus, which is `minModulus n`.

`0 < N` excludes `N = 0`, where `ZMod 0` is `ℤ` rather than a finite modulus and `{1, 2}` is
valid, which would make the statement false for a reason unrelated to the question.
-/
@[category research open, AMS 11]
theorem min_modulus :
    answer(sorry
```

## Plain statement

Pick n different numbers modulo N. Call the set 'valid' if the only way to choose n of them (repeats allowed) that adds up, mod N, to the sum of the whole set is to choose each one exactly once. The conjecture: valid sets only exist when N is at least 2^n minus the biggest power of 2 not exceeding n, and {1,3,7,15,...} reaches that bound.

## Definitions

A subset A of Z/NZ with |A|=n is valid if: for every way m of choosing n elements of A with repetition (non-negative counts m_a with sum m_a = n) and sum m_a*a = sum of A (mod N), all m_a = 1. Claim: for n>=2 and 0<N<2^n - 2^floor(log2 n), no n-subset of Z/NZ is valid. Valid examples at the bound: {0,1} mod 2, {0,1,3} mod 6, {0,1,3,7} mod 12, {0,1,3,7,15} mod 28, {0,1,3,7,15,31} mod 60 (validity is invariant under adding a constant to every element).

## Checked so far (Python, 2026-10-04, not a proof)

Python, exhaustive with the pairwise-sum pruning and translation symmetry: for n=2..6 the least N admitting a valid n-set is exactly 2, 6, 12, 28, 60 = 2^n - 2^floor(log2 n); no valid set exists below. n=7 not finished. No failure.

## Attack ideas

Exhaustive search for n=7 (N<124) and n=8 (N<248) with symmetry pruning (translations, multiplication by units) in C/WASM, looking for a valid set below the bound; or a proof via a counting/sumset argument.

## Risks and notes

2026 conjecture; the author has a Lean proof of the matching upper bound (public), so the open half is the lower bound. Exhaustive search beyond n=8 grows fast.

# tan of a sum of arctangents is not an integer for n >= 5

- id: `tanarctan`
- source: `.lake/packages/formal_conjectures/FormalConjectures/Arxiv/2607.05739/TanArctanSum.lean`
- theorem: `tan_arctan_sum_not_integer`
- kind: sequence

## Lean statement (copied from the pinned source; the source file is the authority)

```lean
/--
**Conjecture (Amdeberhan-Medina-Moll, 2008).** For every integer $n \geq 5$, the value
$$x_n = \tan(\arctan 1 + \arctan 2 + \cdots + \arctan n)$$
is not an integer.
-/
@[category research open, AMS 11]
theorem tan_arctan_sum_not_integer :
    answer(sorry
```

## Plain statement

Multiply the numbers (1+1i)(1+2i)(1+3i)...(1+ni) with imaginary-unit arithmetic; write the result as A + B i. The claim is that for n at least 5, B divided by A is never a whole number.

## Definitions

Z_n = product over k=1..n of (1 + k*i) in the Gaussian integers, Z_n = A_n + B_n*i (A_n real part, B_n imaginary part). x_n = B_n/A_n = tan(arctan 1 + ... + arctan n). IsIntegerValue(n) means A_n divides B_n. Claim: for n>=5, A_n does not divide B_n. (n=1..4 are integers: x_1=1, x_2=-3, x_3=0, x_4=4; x_5=-9/19, x_6=105/73, x_7=-308/331, x_8=36/43, x_9=-423/281, x_10=2387/4511.)

## Checked so far (Python, 2026-10-04, not a proof)

Python exact: n=5..20000: A_n never divides B_n and A_n never 0. No failure.

## Attack ideas

Search n up to 10^5 or more with exact big integers and a modular filter; the structure is Gaussian-integer factorisation (norm = product of (1+k^2)), and a recent paper bounds how large integer values can be.

## Risks and notes

Open since 2008. A Lean development of related partial results ('integer values are rare') is public (AxiomMath/TanArctan), so partial lemmas may already exist; the full statement is still open.

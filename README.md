# erdos-lean-formalization

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23733028.svg)](https://doi.org/10.5281/zenodo.23733028)

An autonomous Claude Code agent turns published human proofs of known results into Lean 4 proofs of the exact statements in [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures).
The harness around the agent is measured, and every proof is verified outside the agent's reach.

Design: [docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md](docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md).

## Results

`PROOFS.md` lists the 26 Lean proofs that the checker accepted, each with the frozen statement, the accepted commit and the checker's log; the files are copied under `proofs/<id>/`.
`paper/main.pdf` is a short paper on the project (source in `paper/main.tex`).
The plain-language write-up is `docs/writeup/untrusted-prover-trusted-referee.html`, and the run records are in `docs/`.
No open problem was solved; the two partial results on open problems are on the branches `deep/catchup` and `deep/a000224`.

## Verification path

Nothing in this repository is trusted for verdicts, because the agent can edit all of it.
The companion repository `erdos-lean-checker` rebuilds a named commit of this repository in GitHub Actions and runs [Comparator](https://github.com/leanprover/comparator) against frozen statements.
A green check there on commit X is the only definition of success.

## Honesty inventory

The write-up in `docs/writeup/untrusted-prover-trusted-referee.html` says what the agent did, what Daniel did, and what came from published sources.

## Provenance map

Published sources for the harness and proof ideas:

- Worker rule "translate the supplied published proof, do not invent a new one", and the `lean` or `math` classification of failed attempts that routes them to a Lean repair or to a re-plan: Magenta, arXiv 2609.11319, Appendix B.1.

## Decision log

See section 10 of the design document.

## Citation

Daniel Puri, "Untrusted Prover, Trusted Referee: 26 Lean Proofs for formal-conjectures from an AI Agent Judged by an External Checker", 2026. DOI: 10.5281/zenodo.23733028 (release v1.0.0).

## License and credits

The code is MIT licensed, see `LICENSE`.
The problem statements come from [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures) (Apache-2.0).
The Green 72 witness data in `data/green72/` is credited in its README: Thomas Prellberg (MIT) and Achim Flammenkamp's database.

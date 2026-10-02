# erdos-lean-formalization

An autonomous Claude Code agent turns published human proofs of known results into Lean 4 proofs of the exact statements in [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures).
The harness around the agent is measured, and every proof is verified outside the agent's reach.

Design: [docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md](docs/superpowers/specs/2026-10-02-lean-formalization-harness-design.md).

## Verification path

Nothing in this repository is trusted for verdicts, because the agent can edit all of it.
The companion repository `erdos-lean-checker` rebuilds a named commit of this repository in GitHub Actions and runs [Comparator](https://github.com/leanprover/comparator) against frozen statements.
A green check there on commit X is the only definition of success.

## Honesty inventory

To be filled during the run: what the model did, what Daniel did, what was borrowed from published sources.

## Provenance map

To be filled during the run: which published source each harness idea and each proof idea came from.

## Decision log

See section 10 of the design document.

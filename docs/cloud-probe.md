# Cloud probe results

## Probe 1, 2026-10-02 15:02 UTC, environment `erdos-lean`, network Full

```
pwd=/home/user
user=root
home=/root
nproc=4
mem=15G
disk=31G free
lakefile_in_pwd=no
curl 8.5.0 (zstd support present)
head https://github.com/danielpuri1901/erdos-lean-formalization/releases/download/probe-v0/probe.txt -> 404
head https://github.com/leanprover/lean4/releases/download/v4.33.1/lean-4.33.1-linux.tar.zst -> 200
head https://cache.mathlib.org/ -> 404
head https://release.lean-lang.org/ -> 200
env_remote=true
```

## Reading

- The setup script runs as root in `/home/user`, not inside the repository checkout. The checkout path is still unknown; probe 2 lists `/home/user`.
- A release asset of a public repository downloads (Lean 4.33.1 tarball, 200). The earlier fear that all GitHub release assets 403 through the proxy was wrong for public repositories.
- A release asset of this private repository returns 404 on HEAD. Whether GET also fails is untested; probe 2 tests it.
- `cache.mathlib.org` is reachable (404 is its answer for `/`), so `lake exe cache get` should work.
- `release.lean-lang.org` is reachable.

## Consequences for the plan

- Task 5 can install the toolchain straight from the leanprover release instead of re-hosting it.
- The prebuilt formal-conjectures oleans must be hosted where the proxy serves them: a public repository release, or S3, unless probe 2 shows GET works on the private asset.
- The setup script must locate the checkout explicitly (probe 2) instead of assuming it is the working directory.

## Probe 2, 2026-10-02 15:12 UTC, same environment

```
home_user_ls=erdos-lean-checker
find_lakefile=
get private asset -> 404
get private release api -> 403
```
All other lines identical to probe 1.

## Reading of probe 2

- Repositories are cloned into `/home/user/<repo-name>` before the setup script runs.
- This session had only `erdos-lean-checker` attached, not the agent repository, by mistake when the session was started. No agent work ran in it, so nothing was exposed, but real runs must attach only `erdos-lean-formalization`.
- `find_lakefile` is empty because the agent repository has no `lakefile.toml` yet (Task 1 adds it).
- GET on the private asset returned 404 and the release API returned 403, but the agent repository was not attached in this session, so this matches the documented rule (only attached repositories reach the proxy) and does not settle whether an attached private repository works.

## Decision for Task 5

Ruling: do not depend on private release assets.
Use the cheapest path that the probes already proved:

1. Toolchain: download `lean-4.33.1-linux.tar.zst` from the leanprover release (proved 200).
2. Mathlib: `lake exe cache get` from `cache.mathlib.org` (proved reachable).
3. formal-conjectures: build only the import closure of the current target in the setup script.

Task 1's CI run measures that build on the same 4-core shape (`build_seconds`).
If toolchain download plus cache get plus that build fits in about 270 seconds, Task 5 needs no artifact at all.
If it does not fit, publish the built `.lake` as a release asset on a new public repository `erdos-lean-env` that holds only compiled open-source Lean libraries (formal-conjectures and Mathlib are Apache-2.0), because public release assets are proved to download.
Creating that public repository needs Daniel's approval.

## Probe 2 script (as run)

Setup script addition, then a session that prints `/tmp/cloud-probe.log`:

```bash
echo "home_user_ls=$(ls /home/user 2>/dev/null | tr '\n' ' ')"
echo "find_lakefile=$(find / -maxdepth 4 -name lakefile.toml 2>/dev/null | tr '\n' ' ')"
code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 30 https://github.com/danielpuri1901/erdos-lean-formalization/releases/download/probe-v0/probe.txt 2>&1 | tail -c 3)
echo "get private asset -> $code"
code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 30 https://api.github.com/repos/danielpuri1901/erdos-lean-formalization/releases/tags/probe-v0 2>&1 | tail -c 3)
echo "get private release api -> $code"
```

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

## Probe 2 (to run)

Setup script addition, then a session that prints `/tmp/cloud-probe.log`:

```bash
echo "home_user_ls=$(ls /home/user 2>/dev/null | tr '\n' ' ')"
echo "find_lakefile=$(find / -maxdepth 4 -name lakefile.toml 2>/dev/null | tr '\n' ' ')"
code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 30 https://github.com/danielpuri1901/erdos-lean-formalization/releases/download/probe-v0/probe.txt 2>&1 | tail -c 3)
echo "get private asset -> $code"
code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 30 https://api.github.com/repos/danielpuri1901/erdos-lean-formalization/releases/tags/probe-v0 2>&1 | tail -c 3)
echo "get private release api -> $code"
```

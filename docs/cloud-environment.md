# Cloud environment settings

Create one environment at claude.ai/code: environment selector above the message box, then "Add cloud environment".

- Name: `erdos-lean`
- Network access: `Full`.
  Full means any domain, so no allowlist can be wrong.
  GitHub traffic still goes through Anthropic's GitHub proxy whatever the level, so the release-asset question is answered by the probe, not by this setting.
- Environment variables (one per line):
  - `BASH_DEFAULT_TIMEOUT_MS=600000`
  - `BASH_MAX_TIMEOUT_MS=1800000`
- Setup script: paste the current contents of `scripts/setup-cloud.sh`.

Changing the setup script rebuilds the environment cache.
Resuming a session never re-runs the setup script.

## Start a cloud session

From the browser: open claude.ai/code, pick the repository `danielpuri1901/erdos-lean-formalization`, make sure the environment selector shows `erdos-lean`, type the prompt, send.
From the desktop app: start a new session, choose Cloud instead of Local, pick the repository and the environment.
From a terminal inside the repository: `claude --cloud "<prompt>"` after `/remote-env` has selected `erdos-lean` once.

## Smoke session (plan Task 5)

Paste the current `scripts/setup-cloud.sh` into the environment's setup script field first.
Attach only `erdos-lean-formalization`.
Prompt:

```
Print /tmp/cloud-setup.log. Then run: export PATH=/opt/lean/bin:$PATH; time lake build Challenge Solution. Then run these two probes and print their output: gh api -X POST repos/danielpuri1901/erdos-lean-formalization/statuses/$(git rev-parse HEAD) -f state=pending -f context=probe/session-can-write-statuses; gh api repos/danielpuri1901/erdos-lean-checker --jq .full_name. Then stop.
```

The two probes answer a security question: can the agent's GitHub access write a commit status (a fake verdict) or read the checker repository?
Copy the output into `docs/cloud-probe.md`.

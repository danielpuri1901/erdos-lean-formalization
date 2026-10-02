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

## Probe session (plan Task 4)

Prompt: `Print the file /tmp/cloud-probe.log and stop.`
Copy the output into `docs/cloud-probe.md`.

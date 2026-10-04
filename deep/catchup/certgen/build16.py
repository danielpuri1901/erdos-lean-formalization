import subprocess, time, re, sys
from concurrent.futures import ThreadPoolExecutor
REPO = '/home/user/erdos-lean-formalization'
man = open(f'{REPO}/deep/catchup/certgen/out/Cert16/manifest.txt').read()
sizes = {}
for m in re.finditer(r'cert16(ge|le)_(\d+) \| file (\w+)\.lean .*?nodes (\d+)', man):
    sizes[m.group(3)] = int(m.group(4))
skip = {'Le1', 'Le11', 'Le12', 'Le13', 'Le14', 'Le15', 'Le16'}
mods = sorted((n for n in sizes if n not in skip), key=lambda n: -sizes[n])
log = open(f'{REPO}/deep/catchup/certgen/logs/build16q.log', 'a', buffering=1)
def run(n):
    t0 = time.time()
    r = subprocess.run(['lake', 'build', f'Solution.Cert16.{n}'], cwd=REPO, capture_output=True, text=True)
    err = [l for l in r.stdout.splitlines() + r.stderr.splitlines() if 'error' in l.lower()][:5]
    log.write(f'{n} nodes={sizes[n]} rc={r.returncode} secs={time.time()-t0:.0f} end={time.time():.0f} {err}\n')
log.write(f'START {time.time():.0f} {mods}\n')
with ThreadPoolExecutor(int(sys.argv[1]) if len(sys.argv) > 1 else 3) as ex:
    list(ex.map(run, mods))
log.write(f'DONE {time.time():.0f}\n')

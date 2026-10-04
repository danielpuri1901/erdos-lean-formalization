import sys, itertools
n = int(sys.argv[1]); classes = set(); cnt = 0
for line in sys.stdin:
    E = [tuple(map(int, e.split('-'))) for e in line.split()]
    cnt += 1
    canon = min(tuple(sorted(tuple(sorted((p[a], p[b]))) for a, b in E)) for p in itertools.permutations(range(n)))
    classes.add(canon)
print(f"n={n} dumped={cnt} classes={len(classes)}")

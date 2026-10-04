from families import *
import sys
name = sys.argv[1]
fam = dict([("Petersen", petersen), ("HS", hoffman_singleton)])
if name in fam: n, e = fam[name]()
elif name.startswith("ER"): n, e = er_polarity(int(name[2:]))
elif name.startswith("PG"): n, e = pg_incidence(int(name[2:]))
print(n, len(e))
for u, v in e: print(u, v)

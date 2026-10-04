# Properties of a model: medial? right-cancellative? squaring bijective? idempotents?
import sys
for fn in sys.argv[1:]:
    L=open(fn).read().split(); n=int(L[0]); T=[list(map(int,L[1+i*n:1+(i+1)*n])) for i in range(n)]
    e677=all(T[y][T[x][T[T[y][x]][y]]]==x for x in range(n) for y in range(n))
    e255=all(T[T[T[x][x]][x]][x]==x for x in range(n))
    import random; random.seed(1)
    medial=all(T[T[x][y]][T[z][w]]==T[T[x][z]][T[y][w]] for _ in range(20000) for x,y,z,w in [tuple(random.randrange(n) for _ in range(4))])
    rc=all(len(set(T[x][y] for x in range(n)))==n for y in range(n))
    sq=len(set(T[x][x] for x in range(n)))==n
    print(fn,"n=%d 677=%s 255=%s medial(sampled)=%s right-cancellative=%s squaring-bijective=%s"%(n,e677,e255,medial,rc,sq))

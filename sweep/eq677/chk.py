import sys
L=open(sys.argv[1]).read().split(); n=int(L[0]); T=[list(map(int,L[1+i*n:1+(i+1)*n])) for i in range(n)]
e677=all(T[y][T[x][T[T[y][x]][y]]]==x for x in range(n) for y in range(n))
e255=all(T[T[T[x][x]][x]][x]==x for x in range(n))
print(sys.argv[1],"order",n,"677:",e677,"255:",e255)

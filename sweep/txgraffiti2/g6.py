import sys
def g6(n, E):
    bits = []
    S = set(map(lambda e: (min(e), max(e)), E))
    for j in range(1, n):
        for i in range(j):
            bits.append(1 if (i, j) in S else 0)
    while len(bits) % 6: bits.append(0)
    s = chr(n + 63)
    for k in range(0, len(bits), 6):
        v = 0
        for b in bits[k:k+6]: v = 2 * v + b
        s += chr(v + 63)
    return s
def petersen():
    E = [(i, (i+1) % 5) for i in range(5)] + [(i, i+5) for i in range(5)] + [(5+i, 5+(i+2) % 5) for i in range(5)]
    return 10, E
def k33():
    return 6, [(i, j) for i in range(3) for j in range(3, 6)]
def cube():
    return 8, [(a, a ^ (1 << b)) for a in range(8) for b in range(3) if a < a ^ (1 << b)]
def prism():
    return 6, [(0,1),(1,2),(2,0),(3,4),(4,5),(5,3),(0,3),(1,4),(2,5)]
if __name__ == "__main__":
    for f in (petersen, k33, cube, prism):
        print(g6(*f()))

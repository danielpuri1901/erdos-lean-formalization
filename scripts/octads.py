"""Generate the 759 octads of the extended binary Golay code as 24-bit masks and verify S(5,8,24)."""
import itertools, sys

G = 0b110001110101  # x^11+x^10+x^6+x^5+x^4+x^2+1, bit i = coeff of x^i
assert G == (1 << 11) | (1 << 10) | (1 << 6) | (1 << 5) | (1 << 4) | (1 << 2) | 1

def mulpoly(a, b):
    r = 0
    while b:
        if b & 1:
            r ^= a
        a <<= 1
        b >>= 1
    return r

words = []
for m in range(1 << 12):
    c = mulpoly(m, G)
    assert c < (1 << 23)
    if bin(c).count("1") % 2:
        c |= 1 << 23
    words.append(c)
assert len(set(words)) == 4096
octads = sorted(w for w in words if bin(w).count("1") == 8)
assert len(octads) == 759
for a, b in itertools.combinations(octads, 2):
    assert bin(a & b).count("1") <= 4
# brute-force cover check
cover = {}
for o in octads:
    pts = [i for i in range(24) if o >> i & 1]
    for r in itertools.combinations(pts, 5):
        assert r not in cover
        cover[r] = o
assert len(cover) == 42504
print("ok", file=sys.stderr)

if len(sys.argv) > 1 and sys.argv[1] == "lean":
    print("def octads : List Nat := [")
    for i in range(0, 759, 8):
        chunk = octads[i:i + 8]
        sep = "," if i + 8 < 759 else ""
        print("  " + ", ".join(str(x) for x in chunk) + sep)
    print("]")

# Exhaustive check of Lemma P (see NOTES.md): for every x with L base-3 digits,
#   x + rev(x) is a base-3 palindrome  <=>  (N) d_i + d_{L-1-i} <= 2 for all i
#                                        or (O) x is a palindrome with digits in {0,2}.
# Independent of density.c: uses Python big integers and string reversal.
import sys
def t3(n):
    s = ''
    while n:
        s = str(n % 3) + s
        n //= 3
    return s
maxL = int(sys.argv[1])
for L in range(1, maxL + 1):
    bad = 0; cnt = 0
    for x in range(3 ** (L - 1), 3 ** L):
        s = t3(x)
        y = t3(x + int(s[::-1], 3))
        pal = (y == y[::-1])
        N = all(int(s[i]) + int(s[L - 1 - i]) <= 2 for i in range(L))
        O = (s == s[::-1]) and set(s) <= set('02')
        if pal != (N or O):
            bad += 1
            if bad < 5: print('MISMATCH', L, s, y)
        cnt += pal
    print('L', L, 'palindromic sums', cnt, 'mismatches', bad)

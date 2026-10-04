/* Independent, non-rigorous cross-check (no content formula, no modular arithmetic).
 * Integer value at n => x_n = tan(theta_n) is an integer m.
 * theta_n = n*pi/2 - S_n with S_n = sum_{k<=n} arctan(1/k), so x_n = -tan(S_n) for n even
 * and cot(S_n) for n odd.  S_n is summed in long double with Kahan compensation.
 * n is "excluded" if |x_n| < XMAX and x_n is farther than EPS from every integer.
 * Prints the count of n that are not excluded, and the first few of them. */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main(int argc, char **argv) {
  unsigned long long N = strtoull(argv[1], 0, 10);
  const long double XMAX = 1e5L, EPS = 1e-6L;
  long double s = 0, comp = 0;
  unsigned long long left = 0, shown = 0;
  for (unsigned long long k = 1; k <= N; k++) {
    long double y = atanl(1.0L / (long double)k) - comp;
    long double t = s + y; comp = (t - s) - y; s = t;
    if (k < 5) continue;
    long double x = (k & 1) ? 1.0L / tanl(s) : -tanl(s);
    if (argc > 2 && k <= 10) printf("n=%llu x=%.15Lf\n", k, x);
    long double r = x - roundl(x);
    if (!(fabsl(x) < XMAX && fabsl(r) > EPS)) {
      left++;
      if (shown < 10) { shown++; printf("not excluded: n=%llu x~%.6Le\n", k, x); }
    }
  }
  printf("N=%llu S_N=%.18Lf not excluded: %llu (of %llu)\n", N, s, left, N - 4);
  return 0;
}

// Generate all graphs on 1..N vertices up to isomorphism by vertex augmentation + canonical codes.
// For connected graphs with n>=2 compute slack = 2f - b - p; report failures (slack <= 0) and tight
// counts (slack == 1). Writes connected graphs on N vertices with slack <= K to a file.
#include "inv.h"
#define MAXN 11
static int NN;
static u32 cadj[MAXN]; static int cn, corder[MAXN], cused[MAXN]; static u64 ch[MAXN]; static u64 cbest; static int cT;
static u32 twinlow[MAXN]; // twins with smaller index
static void dfs(int j, u64 cur) {
  if (j == cn) { if (cur < cbest) cbest = cur; return; }
  u64 want = ch[corder[j]];
  for (int v = 0; v < cn; v++) {
    if (cused[v] || ch[v] != want) continue;
    int ok = 1; for (u32 T = twinlow[v]; T; T &= T - 1) if (!cused[__builtin_ctz(T)]) { ok = 0; break; }
    if (!ok) continue;
    u64 c = cur; for (int i = 0; i < j; i++) c = (c << 1) | ((cadj[corder[i]] >> v) & 1);
    int L = j * (j + 1) / 2;
    if (L > 0 && c > (cbest >> (cT - L))) continue;
    int save = corder[j]; corder[j] = v; cused[v] = 1;
    dfs(j + 1, c);
    cused[v] = 0; corder[j] = save;
  }
}
static u64 mix(u64 x) { x ^= x >> 33; x *= 0xff51afd7ed558ccdULL; x ^= x >> 33; x *= 0xc4ceb9fe1a85ec53ULL; x ^= x >> 33; return x; }
static u64 canon(const u32 *adj, int n) {
  cn = n; cT = n * (n - 1) / 2; memcpy(cadj, adj, sizeof(u32) * n);
  u64 h2[MAXN];
  for (int v = 0; v < n; v++) ch[v] = POP(adj[v]);
  for (int r = 0; r < 3; r++) {
    for (int v = 0; v < n; v++) { u64 s = 0; for (u32 T = adj[v]; T; T &= T - 1) s += mix(ch[__builtin_ctz(T)]); h2[v] = mix(ch[v] * 1000003ULL + s); }
    memcpy(ch, h2, sizeof(u64) * n);
  }
  for (int v = 0; v < n; v++) { twinlow[v] = 0; for (int u = 0; u < v; u++) if ((adj[u] & ~(1u << v)) == (adj[v] & ~(1u << u))) twinlow[v] |= 1u << u; }
  // sort vertex order by invariant (insertion sort)
  for (int v = 0; v < n; v++) corder[v] = v;
  for (int i = 1; i < n; i++) { int x = corder[i], k = i; while (k > 0 && ch[corder[k - 1]] > ch[x]) { corder[k] = corder[k - 1]; k--; } corder[k] = x; }
  // corder now gives the cell sequence; dfs overwrites positions but reads cell from ch[corder[j]] before overwrite
  int cells[MAXN]; for (int i = 0; i < n; i++) cells[i] = corder[i];
  memset(cused, 0, sizeof cused); cbest = ~0ULL;
  // dfs uses ch[corder[j]] as cell key: restore corder to cells before
  memcpy(corder, cells, sizeof cells);
  dfs(0, 0);
  return cbest;
}
static void decode(u64 code, int n, u32 *adj) {
  int T = n * (n - 1) / 2, k = T - 1; memset(adj, 0, sizeof(u32) * n);
  for (int j = 1; j < n; j++) for (int i = 0; i < j; i++) { if ((code >> k) & 1) { adj[i] |= 1u << j; adj[j] |= 1u << i; } k--; }
}
// hash set
static u64 *tab; static size_t tcap, tcnt;
static int insert(u64 key) { key += 1; size_t m = tcap - 1, i = mix(key) & m; while (tab[i]) { if (tab[i] == key) return 0; i = (i + 1) & m; } tab[i] = key; tcnt++; return 1; }
int main(int argc, char **argv) {
  NN = atoi(argv[1]); int K = atoi(argv[2]); const char *out = argv[3];
  u64 *lev = malloc(sizeof(u64)); lev[0] = 0; size_t levn = 1; // n=1
  long tight_total = 0, conn_total = 0;
  for (int n = 2; n <= NN; n++) {
    tcap = 1; while (tcap < levn * 64 + 1024) tcap <<= 1; tab = calloc(tcap, 8); tcnt = 0;
    u64 *nl = malloc(sizeof(u64) * (levn * 40 + 1024)); size_t nln = 0;
    for (size_t g = 0; g < levn; g++) {
      u32 a[MAXN]; decode(lev[g], n - 1, a);
      for (u32 N = 0; N < (1u << (n - 1)); N++) {
        u32 b2[MAXN]; memcpy(b2, a, sizeof(u32) * (n - 1));
        for (int i = 0; i < n - 1; i++) if (N >> i & 1) b2[i] |= 1u << (n - 1);
        b2[n - 1] = N;
        u64 c = canon(b2, n);
        if (insert(c)) nl[nln++] = c;
      }
    }
    free(tab); free(lev); lev = nl; levn = nln;
    long conn = 0, tight = 0, fail = 0, hist[64] = {0};
    FILE *fo = (n == NN) ? fopen(out, "w") : 0;
    for (size_t g = 0; g < levn; g++) {
      u32 a[MAXN]; decode(lev[g], n, a);
      if (!connected(a, n)) continue;
      conn++;
      int f = calc_f(a, n), b = calc_b(a, n), p = calc_p(a, n), s = 2 * f - b - p;
      hist[s < 0 ? 0 : s]++;
      if (s == 1) tight++;
      if (s <= 0) { fail++; printf("FAIL n=%d code=%llx f=%d b=%d p=%d\n", n, (unsigned long long)lev[g], f, b, p); }
      if (fo && s <= K) fprintf(fo, "%llx %d %d %d\n", (unsigned long long)lev[g], f, b, p);
    }
    if (fo) fclose(fo);
    conn_total += conn; tight_total += tight;
    printf("n=%d graphs=%zu connected=%ld tight=%ld fail=%ld | cum connected=%ld tight=%ld | slack hist:", n, levn, conn, tight, fail, conn_total, tight_total);
    for (int s = 0; s < 12; s++) printf(" %ld", hist[s]); printf("\n"); fflush(stdout);
  }
  return 0;
}

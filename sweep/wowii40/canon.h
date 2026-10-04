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

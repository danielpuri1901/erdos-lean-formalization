# Green 72 witnesses

`N.json` holds one set of 2N points in the N by N grid with no three on a line, for N from 3 to 60.
Fields: `n`, `points` as `[x, y]` pairs with `0 <= x, y < n`, and `source`.

`scripts/witness.py` fetched every file on 2026-10-03 and re-checked each witness with exact integer arithmetic (size 2N, distinct points, inside the grid, no collinear triple) before writing it.

Sources:

- N = 47, 49, 51, and 53 to 60: Thomas Prellberg, `Table 1.txt` in https://github.com/ThomasPrellberg/no-three-in-line---CP-SAT (MIT licence).
- Every other N: Achim Flammenkamp's no-three-in-line database, lookup form at https://wwwhomes.uni-bielefeld.de/achim/no3in/readme.html, first configuration (index 1) for each size, database cut date 2026-08-31.
  The database carries no explicit licence, so only the one witness per N that the proof uses is stored, and each file names its encoding.

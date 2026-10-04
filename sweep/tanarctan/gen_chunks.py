# Writes Solution/TanArctanData/Z*.lean (exact Z_n at chunk boundaries), Solution/TanArctanChunk/K*.lean
# (one `decide +kernel` run of `runFrom` per chunk) and Solution.lean (the chained theorem).
# Usage: python3 gen_chunks.py TOP STEP   (TOP a multiple of STEP)
import sys
sys.set_int_max_str_digits(0)
TOP, STEP = int(sys.argv[1]), int(sys.argv[2])
bounds = [1 + STEP * j for j in range(1, TOP // STEP + 1)]
want = set(bounds)
a, b = 1, 0
st = {}
for n in range(1, TOP + 2):
    a, b = a - n * b, b + n * a
    if n in want: st[n] = (a, b)
def lit(v): return str(v) if v >= 0 else "-" + str(-v)
for n in bounds:
    with open(f'Solution/TanArctanData/Z{n}.lean', 'w') as f:
        f.write(f'/-! `Z_{{{n}}} = A + B i`, written by a Python script. Not trusted: the kernel run of the chunk\n'
                f'    ending at `{n}` proves that these are the values of `zrec {n}`. -/\n\nnamespace TanArctanSweep\n\n')
        f.write(f'/-- `A_{{{n}}}`. -/\ndef z{n}a : Int := {lit(st[n][0])}\n\n/-- `B_{{{n}}}`. -/\ndef z{n}b : Int := {lit(st[n][1])}\n\nend TanArctanSweep\n')
chunks = []
for j, e in enumerate(bounds, 1):
    s = 5 if j == 1 else bounds[j - 2]
    fuel = e - s
    sa, sb = ('190', '(-90)') if j == 1 else (f'z{s}a', f'z{s}b')
    imps = ['import Solution.TanArctanRun'] + ([] if j == 1 else [f'import Solution.TanArctanData.Z{s}']) + [f'import Solution.TanArctanData.Z{e}']
    with open(f'Solution/TanArctanChunk/K{j}.lean', 'w') as f:
        f.write('\n'.join(imps) + f'\n\n/-! Chunk {j}: indices `{s} ≤ n ≤ {e - 1}`. -/\n\nnamespace TanArctanSweep\n\n'
                f'lemma chunk{j} : runFrom {fuel} {s} {sa} {sb} = (true, z{e}a, z{e}b) := by decide +kernel\n\nend TanArctanSweep\n')
    chunks.append((j, s, fuel, sa, sb, e))
L = ['import FormalConjectures.Arxiv.«2607.05739».TanArctanSum', 'import Solution.TanArctanCheck', 'import Solution.TanArctanRun']
for j, *_ in chunks: L.append(f'import Solution.TanArctanChunk.K{j}')
L.append('''
/-! Sweep results for `tanarctan` (see `sweep/tanarctan/NOTES.md`). -/

namespace TanArctanSweep

open Arxiv.«2607.05739»

/-- Reduction: `x_n` is an integer exactly when `|A_n| = gcd(A_n, B_n)`, i.e. when `A_n` is as small
as the content of `Z_n` allows. -/
theorem isIntegerValue_iff_gcd_eq_natAbs (n : Nat) :
    IsIntegerValue n ↔ Int.gcd (A n) (B n) = (A n).natAbs :=
  Int.gcd_eq_natAbs_left_iff_dvd.symm
''')
L.append(f'/-- The conjecture of Amdeberhan-Medina-Moll on the finite range `5 ≤ n ≤ {TOP}`:\n'
         f'{len(chunks)} chained kernel runs of `runFrom`, each over at most {STEP} indices. -/')
L.append(f'theorem tan_arctan_sum_not_integer_of_le_{TOP} :\n    ∀ n : Nat, 5 ≤ n → n ≤ {TOP} → ¬ IsIntegerValue n := by')
L.append('  intro n hlo hN')
for j, s, fuel, sa, sb, e in chunks:
    if j == 1:
        L.append(f'  have h1 := runFrom_sound {fuel} {s} {sa} {sb} _ _ chunk1 (by decide)')
    else:
        L.append(f'  have h{j} := runFrom_sound {fuel} {s} _ _ _ _ chunk{j} h{j-1}.2')
L.append('  have h : ¬ (zrec n).1 ∣ (zrec n).2 := by')
for j, s, fuel, sa, sb, e in chunks:
    lo = 'hlo' if j == 1 else f'hn{j-1}'
    if j < len(chunks):
        L.append(f'    rcases Nat.lt_or_ge n {e} with hc{j} | hn{j}')
        L.append(f'    · exact h{j}.1 n {lo} hc{j}')
    else:
        L.append(f'    exact h{j}.1 n {lo} (by omega)')
L.append('  rw [zrec_eq] at h\n  exact h\n\nend TanArctanSweep\n')
open('Solution.lean', 'w').write('\n'.join(L))
print(len(chunks), "chunks")

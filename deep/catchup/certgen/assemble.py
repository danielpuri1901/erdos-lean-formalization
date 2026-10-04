import os, sys, shutil
REPO = '/home/user/erdos-lean-formalization'
N = int(sys.argv[1])
stage = f'{REPO}/deep/catchup/certgen/out/Cert{N}'
dst = f'{REPO}/Solution/Cert{N}'
os.makedirs(dst, exist_ok=True)
ge_keys = list(range(2, N + 1))
le_keys = list(range(1, N + 1))
def child(side, k):
    src = f'{stage}/{side}{k}.lean'
    out = f'{dst}/{side}{k}.lean'
    if os.path.exists(src):
        body = open(src).read()
    else:
        body = open(out).read()
        assert body.startswith('import Solution.Cert\n') is False or True
        if body.startswith('import Solution.Cert\n'):
            return  # already generated
    name = f'cert{N}{side.lower()}_{k}'
    assert f'def {name} : Cert' in body, (side, k)
    if side == 'Ge':
        stmt = f"chkGe (((List.range' 1 {N}).erase 1).erase {k}) {k - 1} {name} = true"
    else:
        stmt = f"chkGe ((List.range' 1 {N}).erase {k}) {k} {name} = true"
    text = ('import Solution.Cert\n\nnamespace CatchUpDeep\n\n' + body.rstrip('\n') + '\n\n'
            'set_option maxRecDepth 100000 in\n'
            f'theorem {name}_ok : {stmt} := by decide +kernel\n\nend CatchUpDeep\n')
    with open(out + '.tmp', 'w') as f:
        f.write(text)
    os.replace(out + '.tmp', out)
    os.remove(src)
for k in ge_keys: child('Ge', k)
for k in le_keys: child('Le', k)
imports = ''.join(f'import Solution.Cert{N}.Ge{k}\n' for k in ge_keys) + \
          ''.join(f'import Solution.Cert{N}.Le{k}\n' for k in le_keys)
def clist(side, keys):
    s = ''.join(f'(.cons {k} cert{N}{side}_{k} ' for k in keys) + '.nil' + ')' * len(keys)
    return s
ge_def = f'def cert{N}ge : Cert := .pick 1 (.all {clist("ge", ge_keys)})'
le_def = f'def cert{N}le : Cert := .all {clist("le", le_keys)}'
ge_proof = [f"theorem cert{N}ge_ok : chkGe (List.range' 1 {N}) 0 cert{N}ge = true := by",
            f"  unfold cert{N}ge",
            "  refine chkGe_pick_of (by decide) (by decide) (by decide) (d := 1) (by decide)",
            "    (chkLe_all_of (by decide) ?_)"]
for k in ge_keys:
    ge_proof.append(f"  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert{N}ge_{k}_ok ?_")
ge_proof.append("  exact chkLeList_nil_of _ _")
le_proof = [f"theorem cert{N}le_ok : chkLe (List.range' 1 {N}) 0 cert{N}le = true := by",
            f"  unfold cert{N}le",
            "  refine chkLe_all_of (by decide) ?_"]
for k in le_keys:
    le_proof.append(f"  refine chkLeList_cons_ge (by decide) (by decide) (by decide) cert{N}le_{k}_ok ?_")
le_proof.append("  exact chkLeList_nil_of _ _")
root = (imports + 'import Solution.CertRoot\n\n'
        f'/-! Catch-Up on {{1, ..., {N}}} is a draw: the strategy certificates are split into one\n'
        f'child per first-level key (modules `Solution.Cert{N}.Ge*`, `Solution.Cert{N}.Le*`), each\n'
        'checked by `decide +kernel` in its own module; this module assembles them. -/\n\n'
        'namespace CatchUpDeep\n\nopen CatchUp\n\n'
        + ge_def + '\n\n' + le_def + '\n\n' + '\n'.join(ge_proof) + '\n\n' + '\n'.join(le_proof) + '\n\n'
        f'theorem catchup_draw_{N} : value (Finset.Icc 1 {N}) = .draw :=\n'
        f'  value_Icc_eq_draw_of_certs {N} cert{N}ge cert{N}le cert{N}ge_ok cert{N}le_ok\n\n'
        'end CatchUpDeep\n\n'
        f'#print axioms CatchUpDeep.catchup_draw_{N}\n')
open(f'{REPO}/Solution/Cert{N}.lean', 'w').write(root)
print('ok', N)

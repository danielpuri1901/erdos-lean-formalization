import json, subprocess, sys, pathlib
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent.parent / "scripts"))
import witness

def test_decode_flammenkamp():
    # n=10, encoding from the lookup form on 2026-10-02; 20 points, 2 per row
    pts = witness.decode("o09353478172812564609", 10)
    assert len(pts) == 20 and len(set(pts)) == 20
    assert all(0 <= x < 10 and 0 <= y < 10 for x, y in pts)
    assert witness.no_three_collinear(pts)

def test_rejects_collinear():
    assert not witness.no_three_collinear([(0, 0), (1, 1), (2, 2), (0, 1)])

def test_lean_literal():
    s = witness.lean_list([(0, 1), (2, 3)])
    assert s == "[(0, 1), (2, 3)]"

def test_parse_encoding_from_lookup_page():
    # Raw line from the lookup page for size=3 on 2026-10-03
    html = " . o o \n\nEncoding: x010212\n</pre><HR>\n<EM>Cgi-Script lookup V1.3\n"
    assert witness.parse_encoding(html) == "x010212"
    assert witness.parse_encoding("Encoding: <b>x010212</b>") == "x010212"

def test_parse_prellberg_tolerates_leading_space():
    # Table 1.txt indents the N=60 list with one space (checked 2026-10-03)
    txt = "N=59:\n[(0, 1), (2, 3)]\n\nN=60:\n [(4, 5), (6, 7)]\n"
    assert witness.parse_prellberg(txt) == {59: [(0, 1), (2, 3)], 60: [(4, 5), (6, 7)]}

def test_emit_lean_matches_json(tmp_path):
    out = tmp_path / "W.lean"
    root = pathlib.Path(__file__).resolve().parent.parent
    witness.emit_lean(out_file=out, data_dir=root / "data/green72")
    text = out.read_text()
    for n in (3, 17, 60):
        pts = json.load(open(root / f"data/green72/{n}.json"))["points"]
        assert f"def w{n} : List (Nat × Nat) := {witness.lean_list([tuple(p) for p in pts])}" in text
    assert "def noThree" in text and "namespace Green72Data" in text and "end Green72Data" in text

# CADTrim()

CADTrim()

説明​

CAD トリム

構文​

CADTrim(Cursor[] フェースカーソル, Cursor[]  パートーカーソル, double トリムサイズ, double トリム角度)

入力​

1. Cursor[]​

CAD トリム対象のフェース

2. Cursor[]​

CAD トリム対象の パート

3. Double​

トリムサイズ

4. Double​

トリム角度

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

GeometryCADTrim([], [3:8], 0.001, 15)

# GeometryCADTrim()

GeometryCADTrim()

説明​

CADトリム

構文​

GeometryCADTrim(cursor[]リストFace, cursor[]リストPart, double trimSize, double trimAngle)

入力​

1. Cursor[]​

CADトリムの対象フェース -> フェースカーソル([6:Face ID])

2. Cursor[]​

CADトリムの対象パート -> パートカーソル([3:Part ID])

3. Double​

トリムサイズ（m）

4. Double​

トリム角度（ラジアン）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

GeometryGeometryCADTrim([6:26], [3:1], 0.005, 0.261799)

# ImportOptishapeTS()

ImportOptishapeTS()

説明​

Optishape-TS 結果ファイルをインポートします。

構文​

ImportOptishapeTS(str[] strlPaths, int iImportType, double dFaceAngle, double dEdgeAngle)

入力​

1. str[]​

Optishape-TS 結果ファイルのパスを指定する String のリストです。

2. int​

インポートタイプを指定する整数です。Optishape-TS の場合、常に 1 に設定されます。

3. double​

面の分割を決定するための角度許容度を指定する Double です（指定値より小さい角度の隣接要素間にエッジを作成）。

4. double​

エッジの分割を決定するための角度許容度を指定する Double です（指定値より大きい角度の隣接エッジ要素に頂点を作成）。

戻り値​

"1": 関数が実行可能です

"0": 関数が実行不可能です

サンプルコード​

ImportOptishapeTS(["ファイルへのパス"], 1, 60.0, 60.0)

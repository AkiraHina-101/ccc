# ImportMuxWeld()

ImportMuxWeld()

説明​

Mux-Weldの結果ファイルをインポートします。

構文​

ImportMuxWeld(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle)

入力​

1. str​

Mux-Weldの結果ファイルパスを指定する文字列です。

2. int​

インポートタイプを指定する整数です。LS-Dynaの場合、常に1に設定されます。

3. double​

フェースの分割を決定するための角度許容度を指定する倍精度浮動小数点数です（指定値より小さい角度を持つ隣接要素間にエッジを作成することで）。

4. double​

エッジの分割を決定するための角度許容度を指定する倍精度浮動小数点数です（指定値より大きい角度を持つ隣接エッジ要素上に頂点を作成することで）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportMuxWeld("ファイルへのパス", 1, 60.0, 60.0)

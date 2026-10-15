# ImportAnsysResult()

ImportAnsysResult()

説明​

Ansysの結果ファイルをインポートします。

構文​

ImportAnsysResult(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle)

入力​

1. str​

ansys結果ファイルのパスを指定する文字列です。

2. int​

インポートタイプを指定する整数です。

3. double​

フェース分割を決定するための角度許容度を指定する倍精度浮動小数点数です（指定値より小さい角度で隣接要素間にエッジを作成することで）。

4. double​

エッジ分割を決定するための角度許容度を指定する倍精度浮動小数点数です（指定値より大きい角度で隣接エッジ要素上に頂点を作成することで）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportAnsysResult("ファイルへのパス", 1, 60.0, 60.0)

# ImportMarcMesh()

ImportMarcMesh()

説明​

Marcファイル（.t16、.t19）をJupiterデータベース（メッシュ、境界条件など）にインポートします。

構文​

ImportMarcMesh(str strPath, double dFaceAngle, double dEdgeAngle)

入力​

1. str​

インポートに使用されるMarcファイル（.t16、.t19ファイル）を指定する文字列です。

2. double​

面角を指定する倍精度浮動小数点数です。

3. double​

エッジ角を指定する倍精度浮動小数点数です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportMarcMesh("ファイルへのパス", 60.0, 60.0)

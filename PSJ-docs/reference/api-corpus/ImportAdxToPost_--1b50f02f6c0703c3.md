# ImportAdxToPost()

ImportAdxToPost()

説明​

ADVCファイル（*.adx）をJupiterデータベース（メッシュ、境界条件など）にPostドキュメントとしてインポートします。

構文​

ImportAdxToPost(str strPath, double dFaceAngle, double dEdgeAngle)

入力​

1. str​

インポートに使用されるADVCファイル（*.adxファイル）を指定する文字列。

2. double​

フェース分割を決定するための角度許容度を指定する倍精度浮動小数点数（隣接要素間の角度が指定値より小さい場合、エッジを作成）。

3. double​

エッジ分割を決定するための角度許容度を指定する倍精度浮動小数点数（隣接エッジ要素間の角度が指定値より大きい場合、頂点を作成）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportAdxToPost(strPath, dFaceAngle, dEdgeAngle)

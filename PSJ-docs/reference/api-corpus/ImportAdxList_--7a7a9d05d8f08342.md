# ImportAdxList()

ImportAdxList()

説明​

Jupiterデータベース（メッシュ、境界条件など）にADVCファイル（*.adx）をインポートします。

構文​

ImportAdxList(str[] strlPaths, double dFaceAngle, double dEdgeAngle, bool bReadCommentsForJupiter_b)

入力​

1. str[]​

インポートに使用するADVCファイル（*.adxファイル）のリストを指定するStringのリストです。

2. double​

フェース分割を決定するための角度許容度を指定するDoubleです（指定値より小さい角度で隣接要素間にエッジを作成します）。

3. double​

エッジ分割を決定するための角度許容度を指定するDoubleです（指定値より大きな角度で隣接エッジ要素の間に頂点を作成します）。

4. bool​

Jupiterが材料、特性、LBC、接触、ジョブ名、関連グループ名を読み取るかどうかを指定するBoolです。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportAdxList(["ファイルへのパス"], 1.0471975511962746, 1.0471975511962746)

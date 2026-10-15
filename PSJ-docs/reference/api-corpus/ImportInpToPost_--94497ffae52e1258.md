# ImportInpToPost()

ImportInpToPost()

説明​

inpメッシュをPostドキュメントとしてインポートします。

構文​

ImportInpToPost(string FilePath, float faceAngle, float edgeAngle, int ImportType)

入力​

1. string​

ファイルパス

2. float​

フェース角度

3. float​

エッジ角度

4. int​

インポートタイプ

0: 標準Abaqus Inp
1: プロパティによる標準Abaqus Inp

戻り値​

なし。

サンプルコード​

ImportInpToPost(["C:/Temp/Data.inp"], 1.0472, 1.0472, 1)

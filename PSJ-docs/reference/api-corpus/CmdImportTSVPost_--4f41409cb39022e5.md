# CmdImportTSVPost()

CmdImportTSVPost()

説明​

ポストドキュメントに結果またはメッシュファイルをインポートします。

構文​

CmdImportTSVPost(string FilePath, int solverType, int importType, float faceAngle, float edgeAngle)

入力​

1. string​

ファイルパス

2. int​

Solver type.

3. int​

インポートタイプ

4. float​

フェース角度

5. float​

エッジ角度

戻り値​

なし。

サンプルコード​

CmdImportTSVPost("C:/Temp/sample.dat", 9, 1, 1.0472, 1.0472)

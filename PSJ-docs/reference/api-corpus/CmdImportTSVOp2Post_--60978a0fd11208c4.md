# CmdImportTSVOp2Post()

CmdImportTSVOp2Post()

説明​

Nastranの.op2結果ファイルをインポートします。

構文​

CmdImportTSVOp2Post(string FilePath, int importType, float faceAngle, float edgeAngle, bool readLoadAndConst, bool readConnection bool createResultsAtMidNode)

入力​

1. string​

ファイルパス

2. int​

インポートタイプ
0: シンプルトポロジー
1: 標準Nastran Op2プロパティ

3. float​

フェース角度

4. float​

エッジ角度

5. bool​

ロードと拘束を読み込むフラグ

6. bool​

接続を読み込むフラグ

6. bool​

中間節点で結果を作成するフラグ

戻り値​

何もありません。

サンプルコード​

CmdImportTSVOp2Post("C:/temp/data.op2", 1, 1.0472, 1.0472, 0, 0, 0)

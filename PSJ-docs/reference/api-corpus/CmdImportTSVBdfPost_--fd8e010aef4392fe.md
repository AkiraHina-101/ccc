# CmdImportTSVBdfPost()

CmdImportTSVBdfPost()

説明​

Nastran BDFファイルをPost Documentにインポートします。

構文​

CmdImportTSVBdfPost(string FilePath, int importType, float faceAngle, float edgeAngle, int readLoadAndConst, int readConnection)

入力​

1. string ​

ファイルパス

2. int ​

インポートタイプ。0に設定します。

3. float  ​

フェース角度

4. float  ​

エッジ角度

5. bool  ​

ロードと拘束を読み込むフラグ

6. bool  ​

接続を読み込むフラグ

戻り値​

なし。

サンプルコード​

CmdImportTSVBdfPost("C:/temp/sample.bdf", 1, 1.0472, 1.0472, 0, 0)

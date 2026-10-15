# CmdSaveOpenTsdv()

CmdSaveOpenTsdv()

説明​

周波数応答解析（*.tsdv）の結果を保存または読み込みします。

構文​

CmdSaveOpenTsdv(str strFilePath, int iSaveOpenMode, cursor crlTargetItems, bool bBdfMode, int iAnalysisType)

入力​

1. str​

ファイルのパスを指定する文字列です。

2. int​

保存モードの場合は0、読み込みモードの場合は1です。

3. cursor​

保存モードの場合は保存する特定の解析対象を指定する Cursor リスト、読み込みモードの場合は[]です。

4. bool​

BDFモードを使用するかどうかを指定するブール値です。

5. int​

周波応答の場合は0、瞬時応答の場合は1です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CmdSaveOpenTsdv("ファイルへのパス", 0, [0:0], 1, 0)

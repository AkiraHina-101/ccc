# CmdSaveOpenTsdv()

CmdSaveOpenTsdv()

説明​

Post Toolsウィンドウでの計算結果をcsvファイルに保存/読み込みします。

構文​

CmdSaveOpenTsdv(string fileName, bool SaveLoad, cursor[] calculations, bool bdfMode)

入力​

1. string ​

保存/読み込みファイルパス。

2. bool ​

保存または読み込み。0: 保存, 1: 読み込み。

3. cursor[] ​

対象計算。

4. bool ​

bdf形式または通常形式での読み書き条件を指定します。

戻り値​

なし。

サンプルコード​

CmdSaveOpenTsdv("C:/Temp/frequency.tsdv", 0, [195:1, 195:2], 0)

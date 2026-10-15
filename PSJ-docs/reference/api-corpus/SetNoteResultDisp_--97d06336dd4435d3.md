# SetNoteResultDisp()

SetNoteResultDisp()

説明​

節点のノートに表示される変位ラベルを設定します。

構文​

SetNoteResultDisp(bool diplay, bool useDefault, string labelName)

入力​

1. bool​

ノートに変位ラベルを表示するかどうかを指定します。

0：非表示

1：表示

2. bool​

デフォルトのラベル名を使用するかどうかを指定します。

0：デフォルトのラベル名を使用します（Mat ID）

1：ユーザー定義のラベル名を使用します

3. string​

ユーザー定義のラベル名を指定します。ユーザー定義のラベル名を使用する場合に表示されます。

戻り値​

なし。

サンプルコード​

SetNoteResultDisp(1, 0, ")

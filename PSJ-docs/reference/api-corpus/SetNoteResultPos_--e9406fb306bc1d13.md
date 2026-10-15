# SetNoteResultPos()

SetNoteResultPos()

説明​

位置にラベルを設定して、その位置の注記に表示されるようにします。

構文​

SetNoteResultPos(bool diplay, bool useDefault, string labelName)

入力​

1. bool​

注記に位置ラベルを表示するかどうかを指定します。

0：表示しない

1：表示する

2. bool​

デフォルトのラベル名を使用するかどうかを指定します。

0：デフォルトのラベル名（Pos）を使用

1：ユーザー定義のラベル名を使用

3. string​

ユーザー定義のラベル名を指定します。ユーザー定義のラベル名を選択した場合に表示されます。

戻り値​

なし。

サンプルコード​

SetNoteResultPos(0, 0, "")

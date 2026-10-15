# SetNoteElementMatID()

SetNoteElementMatID()

説明​

要素の注釈で表示される要素質材IDラベルを設定します。

構文​

SetNoteElementMatID(bool diplay, bool useDefault, string labelName)

入力​

1. bool​

注釈にタイプラベルを表示するかどうかを指定します。

0：表示しない

1：表示する

2. bool​

デフォルトのラベル名を使用するかどうかを指定します。

0：デフォルトのラベル名を使用する（Mat ID）

1：ユーザー定義のラベル名を使用する

3. string​

ユーザー定義のラベル名を指定します。ユーザー定義のラベル名を選択した場合に表示されます。

戻り値​

なし。

サンプルコード​

SetNoteElementMatID(1, 0, ")

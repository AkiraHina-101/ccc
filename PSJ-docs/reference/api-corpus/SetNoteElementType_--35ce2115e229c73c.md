# SetNoteElementType()

SetNoteElementType()

説明​

要素のメモに表示されるタイプラベルを設定します。

構文​

SetNoteElementType(bool diplay, bool useDefault, string labelName)

入力​

1. bool​

メモにタイプラベルを表示するかどうかを指定します。

0：非表示

1：表示

2. bool​

デフォルトのラベル名を使用するかどうかを指定します。

0：デフォルトのラベル名（タイプ）を使用

1：ユーザー定義のラベル名を使用

3. string​

ユーザー定義のラベル名を指定します。ユーザー定義のラベル名を使用する場合に表示されます。

戻り値​

なし

サンプルコード​

SetNoteElementType(0, 0, "")

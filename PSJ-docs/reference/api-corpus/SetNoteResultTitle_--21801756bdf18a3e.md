# SetNoteResultTitle()

SetNoteResultTitle()

説明​

ノートに表示されるデータラベルを設定します。
また、ノートにラベルを表示するかどうかを設定します。

構文​

SetNoteResultTitle(bool diplay, bool useDefault, string labelName)

入力​

1. bool​

ノートにラベルを表示するかどうかを指定します。

0：非表示

1：表示

2. bool​

データにデフォルトのラベル名を使用するかどうかを指定します。

0：デフォルトのラベル名を使用（Data）

1：ユーザー定義のラベル名を使用

3. string​

データのユーザー定義のラベル名を指定します。ユーザー定義のラベル名を使用する場合に表示されます。

戻り値​

なし。

サンプルコード​

SetNoteResultTitle(1, 0, ")

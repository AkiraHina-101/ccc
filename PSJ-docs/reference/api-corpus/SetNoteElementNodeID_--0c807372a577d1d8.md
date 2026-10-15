# SetNoteElementNodeID()

SetNoteElementNodeID()

説明​

要素の節点IDラベルを、要素のノートに表示するかどうかを設定します。

構文​

SetNoteElementNodeID(bool diplay, bool useDefault, string labelName)

入力​

1. bool​

ノート上にタイプラベルを表示するかどうかを指定します。

0：非表示

1：表示

2. bool​

デフォルトのラベル名を使用するかどうかを指定します。

0：デフォルトのラベル名を使用（Nodes）

1：ユーザー定義のラベル名を使用

3. string​

ユーザー定義のラベル名を指定します。ユーザー定義のラベル名を使用する場合に表示されます。

戻り値​

なし。

サンプルコード​

SetNoteElementNodeID(1, 0, ")

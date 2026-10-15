# SetNoteResultPrnVector()

SetNoteResultPrnVector()

説明​

節点のノートに表示されるベクトルラベルを設定します。

構文​

SetNoteResultPrnVector(bool diplay, bool useDefault, string labelName)

入力​

1. bool​

ノートにベクトルラベルを表示するかどうかを指定します。

0：表示しない

1：表示する

2. bool​

デフォルトのラベル名を使用するかどうかを指定します。

0：デフォルトのラベル名を使用する（Dir.）

1：ユーザーが定義したラベル名を使用する

3. string​

ユーザーが定義したラベル名を指定します。ユーザーが定義したラベル名を使用する場合に表示されます。

戻り値​

なし。

サンプルコード​

SetNoteResultPrnVector(1, 0, ")

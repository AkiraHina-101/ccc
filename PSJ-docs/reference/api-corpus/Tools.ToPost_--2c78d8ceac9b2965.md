# Tools.ToPost()

Tools.ToPost()

説明​

モデルデータを開いているPre文書から新しいPost文書に変換すると、モデルに結果を追加できます。

構文​

Tools.ToPost(...)

マクロ:

リボン: Tools » ToPost

入力​

strName​

_String_型で、変換されるPost文書の名前を指定します。

これは必須の入力です。

ilOptions​

モデルと関連する設定を指定する _Integer_型のリスト:

0: グループ

1: LBC

2: 接続

3: 座標

4: プロパティ

デフォルト値は[]です。

戻り値​

プロセスが正常に実行されたかどうかを示す _Boolean_型:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# Preモデルを準備
Geometry.Part.Cube()

# Postに変換
Tools.ToPost(strName="Jupiter1", ilOptions=[0, 1, 2, 3, 4])

# Assembly.RightClick.ChangeEntityColor()

Assembly.RightClick.ChangeEntityColor()

説明​

特定のエンティティ/エンティティのリストの色を変更します（IDによって）。

構文​

Assembly.RightClick.ChangeEntityColor(...)

リボン: None

入力​

crlEntities​

色を変更するエンティティ/エンティティのリストを指定する Cursor リスト。

これは必須入力です。

iColor​

エンティティの色を指定する Integer 。

デフォルト値は0です。

戻り値​

入力されたエンティティ/エンティティの色が変更されたかどうかを指定する String：

1：入力されたエンティティ/エンティティの色が正常に変更されました。

0：入力されたエンティティ/エンティティの色を変更できません。

サンプルコード​

Geometry.Part.Cube()
changed_color = Assembly.RightClick.ChangeEntityColor(crlEntities=[Face(26, 24, 22)], iColor=16777088)
JPT.Debugger(changed_color)

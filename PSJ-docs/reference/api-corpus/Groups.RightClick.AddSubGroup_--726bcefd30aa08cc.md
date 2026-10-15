# Groups.RightClick.AddSubGroup()

Groups.RightClick.AddSubGroup()

説明​

グループウィンドウ内のグループツリーにサブグループを作成します。

構文​

Groups.RightClick.AddSubGroup(...)

リボン: Groups » RightClick » AddSubGroup

入力​

crSubGroupSelected​

サブグループを追加するグループを指定する Cursor です。

デフォルト値は None です。

戻り値​

作成されたサブグループを指定する Cursor です。

サンプルコード​

# モデルを準備する
Geometry.Part.Cube()

# グループを作成する
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Face(26)])
Tools.Group.CreateGroup(strGroupName="Group2", crlTargets=[Face(24)])

# サブグループを追加する
created_sub_group = Groups.RightClick.AddSubGroup()
Assembly.RightClick.Rename(strNewName="SubGroup - 1", crItem=SubGroup(1))
JPT.Debugger(created_sub_group)

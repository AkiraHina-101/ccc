# Groups.RightClick.Rename()

Groups.RightClick.Rename()

説明​

グループウィンドウのグループツリーで指定されたグループの名前を変更します。

構文​

Groups.RightClick.Rename(...)

リボン：Groups » RightClick » Rename

入力​

strNewName​

グループの新しい名前を指定する String です。

この入力は必須です。

crItem​

変更する現在のグループを指定する Cursor です。

この入力は必須です。

戻り値​

削除処理の状態を指定する Boolean です：

True: 入力されたグループの名前が正常に変更されました。

False: 入力されたグループの名前を変更できません。

サンプルコード​

Geometry.Part.Cube()

Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Part(1)])

rename_status = Groups.RightClick.Rename(strNewName = "new name", crItem = Group(1))

JPT.Debugger(rename_status)

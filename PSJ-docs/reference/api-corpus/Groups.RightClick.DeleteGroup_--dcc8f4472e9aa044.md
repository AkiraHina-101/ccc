# Groups.RightClick.DeleteGroup()

Groups.RightClick.DeleteGroup()

説明​

グループウィンドウ内のグループツリーから指定したグループを削除します。

構文​

Groups.RightClick.DeleteGroup(...)

リボン: Groups » RightClick » DeleteGroup

入力​

crlGroups​

削除するグループアイテムのリストを指定する Cursor のリスト。

これは必須の入力です。

bRemoveAll​

すべてのグループを削除する Boolean 型。

デフォルト値は False です。

戻り値​

削除プロセスのステータスを指定する Boolean 型：

True: 入力したグループが正常に削除されました。

False: 入力したグループは削除できません。

サンプルコード​

Geometry.Part.Cube()

Tools.Group.CreateGroup(strGroupName="Group1",
                        crlTargets=[Face(26)])
Tools.Group.CreateGroup(strGroupName="Group2",
                        crlTargets=[Face(24)])

deleted_groups = Groups.RightClick.DeleteGroup(crlGroups=[Group(1,
                                                                2)])

JPT.Debugger(deleted_groups)

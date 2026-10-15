# Groups.RightClick.CopyGroup()

Groups.RightClick.CopyGroup()

説明​

グループツリーに入力されたグループをコピーし、指定されたサブグループに貼り付けます。

構文​

Groups.RightClick.CopyGroup(...)

リボン: Groups » RightClick » CopyGroup

入力​

crlGroups​

コピーに使用するグループアイテムのリストを指定する Cursor リストです。

この入力は必須です。

strlNames​

コピーしたグループの新しいグループ名のリストを指定する String リストです。

デフォルト値は[]です。

crSubGroup​

存在する場合は、上位グループの宛先を指定する Cursor です。

デフォルト値は None です。

bKeepOriginalGroup​

元のグループを保持するかどうかを有効/無効にする Boolean です。

デフォルト値は False です。

戻り値​

貼り付けられたすべてのグループを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()

Tools.Group.CreateGroup(strGroupName="Group1", 
                        crlTargets=[Face(22)])
Tools.Group.CreateGroup(strGroupName="Group2", 
                        crlTargets=[Face(24)])
Tools.Group.CreateGroup(strGroupName="Group3",
                        crlTargets=[Face(26)])

Groups.RightClick.AddSubGroup()

pasted_groups = Groups.RightClick.CopyGroup(crlGroups=[Group(1, 2, 3)], 
                                            crSubGroup=SubGroup(1))

JPT.Debugger(pasted_groups)

# Groups.RightClick.ChangeMarkerColor()

Groups.RightClick.ChangeMarkerColor()

説明​

グループのマーカー色を変更します。

構文​

Groups.RightClick.ChangeMarkerColor(...)

リボン: Groups » RightClick » Marker

入力​

list​

グループとそのマーカー色を指定する Cursor と color のペアのリスト。

デフォルト値は None です。

戻り値​

関数が成功したかどうかを指定する Boolean。

サンプルコード​

# モデルを準備
Geometry.Part.Cube()

# グループを作成
Tools.Group.CreateGroup(strGroupName="Group1", crlTargets=[Face(26)])
Tools.Group.CreateGroup(strGroupName="Group2", crlTargets=[Face(24)])

# マーカー色を表示
JPT.Exec('ViewShowGroupMarker(1)')
# マーカー色を変更
Groups.RightClick.ChangeMarkerColor(listGroupColors=[[Group(1), 10616736]])
Groups.RightClick.ChangeMarkerColor(listGroupColors=[[Group(2), 16716288]])

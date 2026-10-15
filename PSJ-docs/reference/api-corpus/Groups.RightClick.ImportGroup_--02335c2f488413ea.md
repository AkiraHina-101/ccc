# Groups.RightClick.ImportGroup()

Groups.RightClick.ImportGroup()

説明​

*CSVファイルをインポートして、グループウィンドウのグループツリーにグループを作成します。

構文​

Groups.RightClick.ImportGroup(...)

マクロ:

リボン: Groups » RightClick » ImportGroup

入力​

strlPaths​

CSVファイルへのパスを指定する String のリストです。

この入力は必須です。

crParentGroup​

インポートする親サブグループ（SUP_GROUP）を指定する Cursor です。

デフォルト値は None です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です:

True: グループが正常にインポートされました。

False: グループをインポートできませんでした。

サンプルコード​

import os 

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Tools.Group.CreateGroup(
    strGroupName="グループ1", 
    crlTargets=[Face(26, 24)])
JPT.ViewFitToModel()

Tools.Group.CreateGroup(
    strGroupName="グループ2", 
    crlTargets=[Node(45, 46, 100, 101, 102, 145, 146, 153, 154)])

temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

groups=JPT.GetAllGroups()

max_group_num=len(groups)
for i, group in enumerate(groups):
    # グループのエクスポート
    Groups.RightClick.ExportGroup(
        crlTargets=[Group(group.id)], 
        strlPaths=[os.path.join(temp_path,f"グループ_{i}.csv")],
        iEncode=1,
        bWithBOM=True)
    # グループの削除
    Groups.RightClick.DeleteGroup(crlGroups=[Group(group.id)])

# グループの再インポート
for i in range(max_group_num):
    Groups.RightClick.ImportGroup(
        strlPaths=[os.path.join(temp_path,f"グループ_{i}.csv")])

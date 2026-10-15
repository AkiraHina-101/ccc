# Groups.RightClick.ExportGroup()

Groups.RightClick.ExportGroup()

説明​

指定されたグループをCSVファイルにエクスポートします。

構文​

Groups.RightClick.ExportGroup(...)

マクロ:

リボン: Groups » RightClick » ExportGroup

入力​

crlTargets​

エクスポートするグループを指定する Cursor のリストです。

これは必須の入力です。

strlPaths​

*CSV ファイルのパスを指定する String のリストです。

これは必須の入力です。

iEncode​

エンコーディングタイプを指定する Integer です。

-1: なし

0: UTF-8

1: SHIFT-JIS

デフォルト値は -1 です。

bWithBOM​

UTF-8 形式に BOM を含めるかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

処理が正常に実行されたかどうかを指定する Boolean です:

True: グループを正常にエクスポートします。

False: グループをエクスポートできません。

サンプルコード​

import os 

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Tools.Group.CreateGroup(
    strGroupName="Group1", 
    crlTargets=[Face(26, 24)])
JPT.ViewFitToModel()

Tools.Group.CreateGroup(
    strGroupName="Group2", 
    crlTargets=[Node(45, 46, 100, 101, 102, 145, 146, 153, 154)])

temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

groups=JPT.GetAllGroups()
for group in groups:
    # グループをエクスポート
    Groups.RightClick.ExportGroup(
        crlTargets=[Group(group.id)], 
        strlPaths=[os.path.join(temp_path,f"Group_{group.id}.csv")],
        iEncode=1,
        bWithBOM=True)

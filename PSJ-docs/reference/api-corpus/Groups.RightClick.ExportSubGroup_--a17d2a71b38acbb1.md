# Groups.RightClick.ExportSubGroup()

Groups.RightClick.ExportSubGroup()

説明​

指定したサブグループをフォルダーと *CSV ファイルにエクスポートします。

構文​

Groups.RightClick.ExportSubGroup(...)

マクロ:

リボン: Groups » RightClick » ExportSubGroup

入力​

strFolderPath​

ファイルの保存先フォルダーのパスを指定する String です。

デフォルト値は "" です。

crlSubGroups​

エクスポートするサブグループを指定する Cursor のリストです。

デフォルト値は [] です。

crlGroups​

エクスポートするグループを指定する Cursor のリストです。

デフォルト値は [] です。

iEncode​

エンコーディングの種類を指定する Integer です。

-1: なし

0: UTF-8

1: SHIFT-JIS

デフォルト値は -1 です。

bWithBOM​

UTF-8 形式で BOM を含めるかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

処理が正常に実行されたかどうかを示す Boolean 型です:

True: グループが正常にエクスポートされました。

False: グループをエクスポートできませんでした。

サンプルコード​

# モデルを準備
Geometry.Part.Cube(iPartColor=6409934)

Groups.RightClick.AddSubGroup()

Assembly.RightClick.Rename(strNewName="SubGroup1", crItem=SubGroup(1))

Tools.Group.CreateGroup(
    strGroupName="Group1", 
    crlTargets=[Face(26, 24)])
JPT.ViewFitToModel()

Tools.Group.CreateGroup(
    strGroupName="Group2", 
    crlTargets=[Node(45, 46, 100, 101, 102, 145, 146, 153, 154)])

Groups.RightClick.CopyGroup(crlGroups=[Group(1, 2)], crSubGroup=SubGroup(1))

temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

subgroups=JPT.GetAllSubGroups()
for subgroup in subgroups:
    # サブグループをエクスポート
    Groups.RightClick.ExportSubGroup(
        strFolderPath=temp_path,
        crlSubGroups=[SubGroup(1)],
        iEncode=1,
        bWithBOM=True)

# MeshEdit.FindDuplicatedNodes()

MeshEdit.FindDuplicatedNodes()

説明​

位置が重複している節点を見つけます。

構文​

MeshEdit.FindDuplicatedNodes(...)

マクロ：FindDuplicatedNodes

リボン：MeshEdit » FindDuplicatedNodes » Find

入力​

crlTargets​

位置が重複している節点を検索する対象エンティティを指定する Cursor のリスト。

デフォルト値は[]です。

dTolerance​

節点の重複を検索するための許容差を指定する Double 。

デフォルト値は1e-5です。

bCreateGroup​

検出された節点のグループを作成するフラグを指定する Boolean 。

デフォルト値は False です。

bSelect​

検出された節点を選択するフラグを指定する Boolean 。

デフォルト値は False です。

bPreview​

実行後にプレビューを表示するフラグを指定する Boolean 。

デフォルト値は False です。

戻り値​

検出された節点を指定する CursorStr のリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(
    dlLength=[0.0105, 0.011, 0.01], 
    strName="Cube_2", 
    iPartColor=7961077)

# 重複を検出
dupnodes=MeshEdit.FindDuplicatedNodes(
    crlTargets=[Part(1, 2)], 
    bSelect=True)

print(f"{len(dupnodes)}個の節点が重複しています")
print(f"節点のID:{[i.getID() for i in dupnodes]}")

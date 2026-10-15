# Tools.Coordinates.ImportCoordinate()

Tools.Coordinates.ImportCoordinate()

説明​

ローカル座標を Nastran BDF または ADVIC ADX フォーマットとしてインポートします。

構文​

Tools.Coordinates.ImportCoordinate(...)

マクロ:

リボン: Tools » Coordinates » Import Coordinate

入力​

strlPath​

String のリストで、エクスポートファイルへのパスを指定します。

デフォルト値は "" です。

crlCS​

Cursor のリストで、ローカル座標を指定します。

デフォルト値は None です。

戻り値​

成功したかどうかを指定する Boolean です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube(iPartColor=6409934)

# 座標の準備
lcs1=Tools.Coordinates.ThreeNode(
    strName="CRect_1", 
    crlNodes=[Node(7, 6, 445)])

lcs2=Tools.Coordinates.ThreeNode(
    strName="CRect_2", 
    crlNodes=[Node(310, 317, 336)])

# 座標のエクスポート

import os 
temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

Tools.Coordinates.ExportCoordinate(
    strlPath=os.path.join(temp_path,'exp-lcs.bdf'), 
    crlCS=[lcs1,lcs2])

# 作成した座標の削除

JPT.Exec(f"DeleteItem(0, [{lcs1},{lcs2}], [], [], 1)")

# エクスポートした座標をインポートして座標を再作成

Tools.Coordinates.ImportCoordinate(
    strlPath=os.path.join(temp_path,'exp-lcs.bdf'))

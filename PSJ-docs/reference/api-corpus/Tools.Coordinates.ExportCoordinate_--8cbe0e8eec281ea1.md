# Tools.Coordinates.ExportCoordinate()

Tools.Coordinates.ExportCoordinate()

説明​

ローカル座標をNastran bdf形式でエクスポートします。

構文​

Tools.Coordinates.ExportCoordinate(...)

マクロ:

リボン: Tools » Coordinates » Export Coordinate

入力​

strlPath​

Stringのリスト 、インポートファイルへのパスを指定します。

デフォルト値は "" です。

戻り値​

成功したかどうかを指定する Boolean です。

サンプルコード​

#モデルの準備
Geometry.Part.Cube(iPartColor=6409934)

#座標の準備
lcs1=Tools.Coordinates.ThreeNode(
    strName="CRect_1", 
    crlNodes=[Node(7, 6, 445)])

lcs2=Tools.Coordinates.ThreeNode(
    strName="CRect_2", 
    crlNodes=[Node(310, 317, 336)])

#座標のエクスポート

import os 
temp_path=JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)

Tools.Coordinates.ExportCoordinate(
    strlPath=os.path.join(temp_path,'exp-lcs.bdf'), 
    crlCS=[lcs1,lcs2])

# HexModeling.AutoSweep()

HexModeling.AutoSweep()

説明​

選択したパート(複数可)の形状を認識し、条件に合った形状のヘキサメッシュを作成します。

構文​

HexModeling.AutoSweep(...)

リボン: HexModeling » AutoSweep

入力​

crlParts​

パートを指定する Cursor のリスト。

デフォルト値は [] です。

dMeshSize​

メッシュサイズを指定する Double 。

デフォルト値は 0.0 です。

bLayers​

レイヤーを指定する Boolean 型。

デフォルト値は False です。

iLayers​

レイヤーを指定する Integer 。

デフォルト値は 2 です。

戻り値​

成功した場合は 1 を、失敗した場合は 0 を返します。

サンプルコード​

Geometry.Part.Cube()
HexModeling.AutoSweep(crlParts=[Part(1)], dMeshSize=0.002, iLayers=5)

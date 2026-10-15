# Geometry.FindFeature.Face()

Geometry.FindFeature.Face()

説明​

特徴に応じて特定のフェースを見つけて選択します。

構文​

Geometry.FindFeature.Face(...)

リボン: Geometry » FindFeature » Faces

入力​

crlParts​

特定のフェースを見つけるパートを指定する Cursor のリスト。

これは必須の入力です。

iFaceType​

特定のフェースの種類を指定する Integer 。

もし iFaceType=0 の場合、4つのコーナーによって境界付けられたフェースを見つけて選択します。

もし iFaceType=1 の場合、平面のフェースを見つけて選択します。

もし iFaceType=2 の場合、円柱面のフェースを見つけて選択します。

もし iFaceType=3 の場合、半円柱曲面のフェースを見つけて選択します。

もし iFaceType=4 の場合、円盤状のフェースを見つけて選択します。

もし iFaceType=5 の場合、マップメッシュのフェースを見つけて選択します。

もし iFaceType=6 の場合、円形の面取りフェースを見つけて選択します。

もし iFaceType=7 の場合、フィレットフェースを見つけて選択します。

デフォルト値は0です。

bCylinder​

マップメッシュの円柱状フェースを見つけるかどうかを指定する Boolean 型。この引数は_iOption=5_ の場合に使用されます。

デフォルト値は True です。

bDisc​

マップメッシュの円盤状フェースを見つけるかどうかを指定する Boolean 型。この引数は_iOption=5_ の場合に使用されます。

デフォルト値は False です。

bFourCorners​

マップメッシュの4つのコーナーによって境界付けられたフェースを見つけるかどうかを指定する Boolean 型。この引数は_iFaceType=5_ の場合に使用されます。

デフォルト値は True です。

dMinThickness​

円形の面取り曲面の最小厚みを指定する Double 。この引数は_iFaceType=6_ の場合に使用されます。

デフォルト値は0.1です。

dMaxThickness​

円形の面取り曲面の最大厚みを指定する Double 。この引数は_iFaceType=6_ の場合に使用されます。

デフォルト値は2.0です。

戻り値​

成功した場合はフェースの Cursor リスト、失敗した場合は None です。

サンプルコード​

cube = Geometry.Part.Cube()
faces = Geometry.FindFeature.Face(crlParts=[cube])
JPT.Debugger(faces)

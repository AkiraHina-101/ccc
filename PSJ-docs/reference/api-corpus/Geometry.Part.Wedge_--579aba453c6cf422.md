# Geometry.Part.Wedge()

Geometry.Part.Wedge()

説明​

特定の場所に楔形状の パートを作成します。この相対位置は指定されたローカル座標系に計算されます。

構文​

Geometry.Part.Wedge(...)

マクロ: CreateWedge

リボン: Geometry » Part » Wedge

入力​

dlOrigin​

X、Y、Z座標を表す Double のリストで、楔形の中心を表します。

デフォルト値は[0.0, 0.0, 0.0]です。

dlLength​

X、Y、Z軸方向の長さをメートル単位で指定する Double のリストです。

デフォルト値は[0.01, 0.01, 0.01]です。

ilAxialNodes​

X、Y、Z軸ごとの節点の数を指定する Integer のリストです。

デフォルト値は[10, 10, 10]です。

strName​

新しく作成されたパートの名前を指定する String の値です。

デフォルト値は"Wedge_1"です。

iPartColor​

新しく作成されたパートの色を指定する Integer です。

デフォルト値は7105764です。

crLocalCoordinate​

ローカル座標系を指定する Cursor です。

デフォルト値は None です。

戻り値​

新しい楔形 パートを指定する Cursor です。

サンプルコード​

wedge = Geometry.Part.Wedge(dlOrigin=[0.005, 0.005, 0.005], strName="Wedge", iPartColor=6409934)

JPT.Debugger(wedge)

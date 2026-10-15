# Assemble.AddRibEx.General()

Assemble.AddRibEx.General()

説明​

パートにリブパートを追加します。

構文​

Assemble.AddRibEx.General(...)

マクロ：AddRibGeneralEx

リボン: Assemble » AddRibEx » General

入力​

dlPositions​

リブの最初の端の位置を指定する Double 型のリストです。

これは必須の入力です。

crlFaces​

リブの2番目の端の位置を指定する Cursor のリストです。

これは必須の入力です。

dThickness​

リブの幅を指定する Double 型の値です。

デフォルト値は 0.0005 です。

#dHeight​

参照面からのリブの高さを指定する Double 型の値です。

デフォルト値は 0.001 です。

#crCoordinate​

リブを取り付ける際に参照する座標系を指定する Cursor 型の値です。

デフォルト値は None です。

bDirectByCoord​

リブの方向を指定の座標軸に沿って整列するかどうかを指定する Boolean 型の値です。

デフォルト値は False です。

iPlane​

リブを配置する座標平面を指定する Integer の値です:

0: XY平面方向にリブを配置します。

1: YZ平面方向にリブを配置します。

2: ZX平面方向にリブを配置します。

デフォルト値は 0 です。

dOffsetX​

X方向のオフセット値を指定する Double 型の値です。

デフォルト値は 0.0 です。

dOffsetY​

Y方向のオフセット値を指定する Double 型の値です。

デフォルト値は 0.0 です。

dOffsetZ​

Z方向のオフセット値を指定する Double 型の値です。

デフォルト値は 0.0 です。

bTriangle​

リブを三角形状のリブとして作成するかどうかを指定する Boolean 型の値です。

デフォルト値は False です。

bPlaneTop​

取り付け面が曲面であってもリブのトップを平らにするかどうかを指定する Boolean 型の値です。

デフォルト値は True です。

bCreateNewPart​

リブパートを新しいパートとして作成するかどうかを指定する Boolean 型の値です。

デフォルト値は False です。

bMerge​

リブパートを対象パートに属する対象面に統合するかどうかを指定する Boolean 型の値です。

デフォルト値は True です。

bPreview​

プレビューを表示するかどうかを指定する Boolean 型の値です。

デフォルト値は True です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型の値です。

サンプルコード​

Geometry.Part.Cube()
Assemble.AddRibEx.General(
    dlPositions=[
        [0.007777777777777778, 0.003333333333333333, 0.01], 
        [0.002222222222222222, 0.007777777777777778, 0.01]], 
    crlFaces=[Face(26)], 
    dThickness=0.001, 
    dHeight=0.001)

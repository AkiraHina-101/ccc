# Tools.Measure.Angle.ThreeNodes()

Tools.Measure.Angle.ThreeNodes()

説明​

指定された3つの節点を使用して角度を計測します。

構文​

Tools.Measure.Angle.ThreeNodes(...)

リボン：Tools » Measure » Angle » ThreeNodes

入力​

crNode1​

角度を計測する最初の節点（A）を指定する Cursor です。

この入力は必須です。

crNode2​

角度を計測する2番目の節点（B）を指定する Cursor です。

この入力は必須です。

crNode3​

角度を計測するための3番目の節点（C）を指定する Cursor です。計測される角度は、ベクトルBAとベクトルBCによって形成されます。

この入力は必須です。

strTarget​

対象の投影平面（2D）または3次元空間（3D）を指定する String です。このパラメータは次のいずれかであることができます：

もし strTarget="XY" であれば：Oxy平面に投影される角度を返します。

もし strTarget="YZ" であれば：Oyz平面に投影される角度を返します。

もし strTarget="ZX" であれば：Ozx平面に投影される角度を返します。

もし strTarget="Angle" であれば：3D空間内の角度を返します。

もし strTarget="All" であれば：順番に "Angle"、"XY"、"YZ"、"ZX" の4つの角度値をリストで返します。

デフォルト値は "All" です。

crCoord​

角度を計測する際に参照される座標参照系を指定する Cursor です。

デフォルト値は None です。

iPrecision​

小数点以下の桁数を指定する Integer です。iPrecision が大きいほど、角度の精度が高くなります。

デフォルト値は 6 です。

戻り値​

3つの節点間の角度を指定する Double 型のリストです。

サンプルコード​

Geometry.Part.Cube()

angle = Tools.Measure.Angle.ThreeNodes(crNode1=Node(445), 
                                       crNode2=Node(454),
                                       crNode3=Node(469), 
                                       strTarget="XY")

JPT.Debugger(angle)
print_str = ''
if type(angle) is list:
    for value in angle:
        print_str += str(value) + ", "
else:
    print_str += str(angle)

print(print_str)

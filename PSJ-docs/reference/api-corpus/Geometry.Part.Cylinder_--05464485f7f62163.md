# Geometry.Part.Cylinder()

Geometry.Part.Cylinder()

説明​

特定の位置に円柱の パートを作成します。相対位置は指定されたローカル座標系に基づいて計算されます。

構文​

Geometry.Part.Cylinder(...)

リボン: Geometry » Part » Cylinder

入力​

strName​

新しく作成されたパートの名前を指定する String です。

デフォルト値は「Cylinder_1」です。

crLocalCoordinate​

ローカル座標系を指定する Cursor です。

デフォルト値は None です。

bHollow​

作成された円柱を中空にするかどうかを指定する Boolean です。

True の場合、円柱は中空部（dTopInnerRadius および dBottomInnerRadius で定義される半径）になります。

False の場合、円柱は中空になりません。

デフォルト値は False です。

bTapered​

円柱をテーパー状（両端の半径が異なる）にするかどうかを指定する Boolean です。

True の場合、円柱は dBottomOuterRadius で定義される半径でテーパー状になります。

False の場合、円柱はテーパーになりません。

デフォルト値は False です。

dlOrigin​

円柱の中心の X、Y、Z 座標を表す Double 型のリスト 型です。

デフォルト値は [0.0,0.0,0.0] です。

dTopInnerRadius​

円柱の上端の内側半径をメートル単位で指定する Double です。

デフォルト値は 0.001 です。

dTopOuterRadius​

円柱の上端の外側半径をメートル単位で指定する Double です。

デフォルト値は 0.01 です。

dBottomInnerRadius​

円柱の下端の内側半径をメートル単位で指定する Double です。

デフォルト値は 0.001 です。

dBottomOuterRadius​

円柱の下端の外側半径をメートル単位で指定する Double です。

デフォルト値は 0.01 です。

dHeight​

円柱の高さを指定する Double です。

デフォルト値は 0.01 です。

iCircularNodes​

両端の円周上に生成される節点の数を指定する Integer です。

デフォルト値は 36 です。

iAxialNodes​

円柱の軸方向に生成される節点の数を指定する Integer です。

デフォルト値は 10 です。

iPartColor​

新しく作成されたパートの色を指定する Integer です。

デフォルト値は 7105764 です。

戻り値​

作成されたパートを指定する Cursor です。

サンプルコード​

created_cylinder = Geometry.Part.Cylinder(dlOrigin=[0.005, 0.005, 0.005],
                                          strName="Cylinder_2", 
                                          iPartColor=7463537)

JPT.Debugger(created_cylinder)

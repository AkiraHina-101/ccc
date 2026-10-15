# Geometry.Part.Torus()

Geometry.Part.Torus()

説明​

特定の位置に環状体パートを作成します。相対位置は指定されたローカル座標系に計算されます。

構文​

Geometry.Part.Torus(...)

マクロ: CreateTorus

リボン: Geometry » Part » Torus

入力​

dlOrigin​

Double 型の X、Y、Z 座標を指定する リスト（ドーナツの中心）です。

デフォルト値は [0.0,0.0,0.0] です。

dInnerRadius​

メートル単位でドーナツの内側の円の半径を指定する Double です。

デフォルト値は 0.015 です。

dRingRadius​

メートル単位でドーナツのリングの半径を指定する Double です。

デフォルト値は 0.02 です。

iCircumNodes​

ドーナツのリングの周囲に生成される節点の数を指定する Integer です。

デフォルト値は 20 です。

iRingNodes​

ドーナツのリングの断面に生成される節点の数を指定する Integer です。

デフォルト値は 20 です。

strName​

作成するパートの名前を指定する String です。

デフォルト値は "Torus_1" です。

iPartColor​

作成するパートの色を指定する Integer です。

デフォルト値は 7105764 です。

crLocalCoordinate​

ローカル座標系を指定する Cursor です。

デフォルト値は None です。

戻り値​

作成プロセスのステータスに応じて戻り値が異なります：

Cursor: ドーナツが正常に作成されました。

None: ドーナツを作成できません。

サンプルコード​

torus = Geometry.Part.Torus(dlOrigin=[0.005, 0.005, 0.005], strName="Torus", iPartColor=7697908)
JPT.Debugger(torus)

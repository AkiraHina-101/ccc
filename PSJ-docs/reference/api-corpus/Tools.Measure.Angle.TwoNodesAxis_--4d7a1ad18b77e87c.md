# Tools.Measure.Angle.TwoNodesAxis()

Tools.Measure.Angle.TwoNodesAxis()

説明​

2つの節点と軸によって作成される角度を測定します。

構文​

Tools.Measure.Angle.TwoNodesAxis(...)

リボン: Tools » Measure » Angle » TwoNodesAxis

入力​

crNode1​

節点1を指定する Cursor。

これは必須の入力です。

crNode2​

節点2を指定する Cursor。

これは必須の入力です。

dlAxis​

軸を指定する Double List。

デフォルト値は [1,0,0] です。

strTarget​

対象を指定する String。

デフォルト値は "Angle" です。

iPrecision​

精度を指定する Integer。

デフォルト値は 6 です。

戻り値​

iPrecision で設定された精度で測定された値を String 形式で返します。

サンプルコード​

Geometry.Part.Cube()

angle=Tools.Measure.Angle.TwoNodesAxis(
    crNode1=Node(462), 
    crNode2=Node(466), 
    dlAxis=[0.0, 1.0, 0.0])

JPT.Debugger(angle)

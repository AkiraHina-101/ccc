# BoundaryConditions.ThermalAttributes()

BoundaryConditions.ThermalAttributes()

説明​

熱属性を作成します。

構文​

BoundaryConditions.ThermalAttributes(...)

マクロ：LbcThermalAttributes

リボン：BoundaryConditions » ThermalAttributes

入力​

dStefanBoltzmannConstant​

ステファン・ボルツマン定数を指定する Double 型

デフォルト値は5.670000E-8です。

dAbsoluteZero​

絶対零度を指定する Double 型

デフォルト値は0（摂氏）です。

crEdit​

既存の熱属性を指定する Cursor 型

デフォルト値は_None_（新規作成）です。

戻り値​

作成された熱属性を指定する Cursor 型。

サンプルコード​

BoundaryConditions.ThermalAttributes(dStefanBoltzmannContact=5.67037e-08)

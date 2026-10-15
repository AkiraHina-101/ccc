# BoundaryConditions.Radiation()

BoundaryConditions.Radiation()

説明​

選択したフェースまたは要素またはグループに放射線を作成します。ユーザーは放射線の値を入力し、選択したアイテムに放射線を適用します。

構文​

BoundaryConditions.Radiation(...)

マクロ：

リボン： BoundaryConditions » Radiation

入力​

strName​

放射線の名前を指定する String です。

デフォルト値は「Radiation」です。

radiation​

放射線を指定する LBC_RADIATION_DATA です。

デフォルト値は LBC_RADIATION_DATA() です。

dAmbientTemp​

環境温度の値を指定する Double です。

この入力は必須です。

crTimeDependAm​

テーブル形式の Time Dependence Ambient 情報を指定する FieldData の Cursor です。

デフォルト値は 0:0（参照なし）です。

dEmissivity​

放射率の値を指定する Double です。

この入力は必須です。

crTimeDependEm​

テーブル形式の Time Dependence Emissivity 情報を指定する FieldData の Cursor です。

デフォルト値は 0:0（参照なし）です。

crTempDependEm​

テーブル形式の Temp Dependence Emissivity 情報を指定する FieldData の Cursor です。

デフォルト値は 0:0（参照なし）です。

crlTargets​

放射線を設定する対象を指定する Cursor のリストです。

デフォルト値は [] です。

crEdit​

編集時に既存の放射線を指定する Cursor です。

デフォルト値は None（作成モード）です。

戻り値​

作成/編集された放射線を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
BoundaryConditions.Radiation(
    strName="Radiation_1", 
    radiation=LBC_RADIATION_DATA(
        dAmbientTemp=373.15, 
        crTimeDependAm=None, 
        dEmissivity=0.5, 
        crTimeDependEm=None, 
        crTempDependEm=None), 
    crlTargets=[Face(26), Elem(301, 341)])

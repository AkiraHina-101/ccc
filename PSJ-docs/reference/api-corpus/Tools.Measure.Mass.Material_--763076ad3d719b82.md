# Tools.Measure.Mass.Material()

Tools.Measure.Mass.Material()

説明​

指定された材料の密度を使用して質量を測定します。

構文​

Tools.Measure.Mass.Material(...)

リボン: Tools » Measure » Mass » Material

入力​

crlParts​

質量を測定するパートのリストを指定する Cursor のリストです。この引数はパートタイプおよび/またはバーのタイプであることがあります。このパラメータが [] の場合、crlMassConditions を指定する必要があります。

測定がcrlPartsにのみ適用される場合、crlPartsは必須の入力です。

測定がcrlMassConditionsにのみ適用される場合、crlPartsはデフォルト値[]になります。

crlMassConditions​

Connections.MassElements によって作成された質量条件のリストを指定する Cursor のリストです。これが [] の場合、crlParts を指定する必要があります。

測定がcrlMassConditionsにのみ適用される場合、crlMassConditionsは必須の入力です。

測定がcrlPartsにのみ適用される場合、crlMassConditionsはデフォルト値[]になります。

dMaterialDensity​

材料密度を指定する String です（デフォルト単位: kg/m3）。

これは必須の入力です。

strTarget​

出力する質量情報の目標値を指定する String です。ターゲット情報に応じて、このパラメータは次のいずれかになります：

もし strTarget="Mass" の場合：質量値を返します。

もし strTarget="Gravity Center X" の場合：重心のX位置を返します。

もし strTarget="Gravity Center Y" の場合：重心のY位置を返します。

もし strTarget="Gravity Center Z" の場合：重心のZ位置を返します。

もし strTarget="Moment Inertial XX" の場合：X軸周りの慣性モーメントを返します。

もし strTarget="Moment Inertial YY" の場合：Y軸周りの慣性モーメントを返します。

もし strTarget="Moment Inertial ZZ" の場合：Z軸周りの慣性モーメントを返します。

もし strTarget="Moment Inertial XY" の場合：XYの慣性モーメント積を返します。

もし strTarget="Moment Inertial YZ" の場合：YZの慣性モーメント積を返します。

もし strTarget="Moment Inertial XZ" の場合：XZの慣性モーメント積を返します。

もし strTarget="Principal Moment X" の場合：主軸11周りの慣性モーメントを返します。

もし strTarget="Principal Moment Y" の場合：主軸22周りの慣性モーメントを返します。

もし strTarget="Principal Moment Z" の場合：主軸33周りの慣性モーメントを返します。

もし strTarget="Traits Vector XX" の場合：主軸11のX方向を返します。

もし strTarget="Traits Vector XY" の場合：主軸11のY方向を返します。

もし strTarget="Traits Vector XZ" の場合：主軸11のZ方向を返します。

もし strTarget="Traits Vector YX" の場合：主軸22のX方向を返します。

もし strTarget="Traits Vector YY" の場合：主軸22のY方向を返します。

もし strTarget="Traits Vector YZ" の場合：主軸22のZ方向を返します。

もし strTarget="Traits Vector ZX" の場合：主軸33のX方向を返します。

もし strTarget="Traits Vector ZY" の場合：主軸33のY方向を返します。

もし strTarget="Traits Vector ZZ" の場合：主軸33のZ方向を返します。

もし strTarget="Euler Angle X" の場合：主軸のX軸との回転角を返します。

もし strTarget="Euler Angle Y" の場合：主軸のY軸との回転角を返します。

もし strTarget="Euler Angle Z" の場合：主軸のZ軸との回転角を返します。

デフォルト値は"Mass"です。

bGravityCenter​

質量を測定するために重心座標系を使用するかどうかを指定する Boolean です。

もし True の場合、crCoord は無効になります。すべての情報は重心座標系を参照して出力されます。

もし False の場合、crCoord は定義されます。すべての情報はcrCoord が指定された座標系を参照して出力されます。

デフォルト値は False です。

crCoord​

質量を測定するために使用する座標系を指定する Cursor です。bGravityCenter が True の場合、このパラメータは使用できません。

デフォルト値は None（グローバル座標）です。

iPrecision​

浮動小数点の後の桁数を指定する Integer です。iPrecision が大きいほど、質量値の精度が向上します。

デフォルト値は 6 です。

戻り値​

質量情報の値を指定する Double です。

サンプルコード​

Geometry.Part.Cube()

mass = Tools.Measure.Mass.Material(crlParts=[Part(1)], 
                                   dMaterialDensity=2300.0)

JPT.Debugger(mass)

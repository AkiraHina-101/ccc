# MeasureMassByMaterial()

MeasureMassByMaterial()

説明​

材料による質量の計測です。

構文​

MeasureMassByMaterial. (Cursor[] parts, Cursor[] massConditions, double dMaterialDensity, String strTarget, Bool bGravityCenter, Cursor crRefCoord, int iPrecision)

入力​

1. Cursor[]​

質量を測定するパートのリストを指定する Cursor のリストです。この引数は Part 型および/または Bar 型になります。このパラメータが [] の場合、massConditions を指定する必要があります。

2. Cursor[]​

質量条件のリストを指定する Cursor のリストです。これが [] の場合、parts を指定する必要があります。

3. double[]​

材料密度を指定する Double 型の値です（デフォルト単位: kg/m3）。

4. String​

出力すべき質量情報の目標値を指定する String です。ターゲット情報に応じて、次のいずれかのパラメータになります：

もし strTarget="Mass" の場合: 質量値を返します。

もし strTarget="Gravity Center X" の場合: 重心の X 位置を返します。

もし strTarget="Gravity Center Y" の場合: 重心の Y 位置を返します。

もし strTarget="Gravity Center Z" の場合: 重心の Z 位置を返します。

もし strTarget="Moment Inertial XX" の場合: X 軸周りの慣性モーメントを返します。

もし strTarget="Moment Inertial YY" の場合: Y 軸周りの慣性モーメントを返します。

もし strTarget="Moment Inertial ZZ" の場合: Z 軸周りの慣性モーメントを返します。

もし strTarget="Moment Inertial XY" の場合: XY 軸上の慣性モーメント積を返します。

もし strTarget="Moment Inertial YZ" の場合: YZ 軸上の慣性モーメント積を返します。

もし strTarget="Moment Inertial XZ" の場合: XZ 軸上の慣性モーメント積を返します。

もし strTarget="Principal Moment X" の場合: 主軸 11 周りの慣性モーメントを返します。

もし strTarget="Principal Moment Y" の場合: 主軸 22 周りの慣性モーメントを返します。

もし strTarget="Principal Moment Z" の場合: 主軸 33 周りの慣性モーメントを返します。

もし strTarget="Traits Vector XX" の場合: 主軸 11 のX方向を返します。

もし strTarget="Traits Vector XY": 主軸 11 のY方向を返します。

もし strTarget="Traits Vector XZ": 主軸 11 のZ方向を返します。

もし strTarget="Traits Vector YX": 主軸 22 のX方向を返します。

もし strTarget="Traits Vector YY": 主軸 22 のY方向を返します。

もし strTarget="Traits Vector YZ": 主軸 22 のZ方向を返します。

もし strTarget="Traits Vector ZX": 主軸 33 のX方向を返します。

もし strTarget="Traits Vector ZY": 主軸 33 のY方向を返します。

もし strTarget="Traits Vector ZZ": 主軸 33 のZ方向を返します。

もし strTarget="Euler Angle X": X軸と主軸の回転角を返します。

もし strTarget="Euler Angle Y": Y軸と主軸の回転角を返します。

もし strTarget="Euler Angle Z": Z軸と主軸の回転角を返します。

デフォルト値は "Mass" です。

5. Bool​

質量を測定するために重心座標系の使用を指定する Boolean です。

6. Cursor​

質量を測定する座標系を指定する Cursor です。bGravityCenter が True の場合、このパラメータは使用できません。

デフォルト値は None（グローバル座標）です。

7. int​

浮動小数点の後の桁数を指定する Integer です。iPrecision が大きければ大きいほど、質量値の精度が向上します。

デフォルト値は 6 です。

戻り値​

質量情報の値を指定する Double です。

サンプルコード​

MeasureMassByMaterial([3:1], [], 2300, "Mass", 0, 0:0, 6)

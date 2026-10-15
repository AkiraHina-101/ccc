# Connections.Pretension.SunShine()

Connections.Pretension.SunShine()

説明​

SunShineソルバーのボルトプリテンションを作成します。

構文​

Connections.Pretension.SunShine(...)

リボン: Connections » Pretension » SunShine

入力​

crlTargets​

ターゲットのリストを指定する Cursor のリスト。パート、フェース、またはエッジになります。

これは必須の入力です。

dForceValue​

プリテンション力の値を指定する Double です。

これは必須の入力です。

strName​

プリテンション力の名前を指定する String です。

デフォルト値は "PreTensionSunShine1" です。

iLocalUnit​

ローカルユニットを指定する Integer です。

デフォルト値は 0 です。

crLbcPretensionSunShine​

既存のプリテンション力（SunShine）を指定する Cursor です。

このパラメータを使用すると、指定されたプリテンション力（SunShine）が変更されます。

None の場合、新しいプリテンション力（SunShine）が作成されます。

デフォルト値は None です。

戻り値​

作成されたSunShineプリテンションを指定する Cursor です。

サンプルコード​

Geometry.Part.Cylinder(dTopOuterRadius=0.003, dBottomOuterRadius=0.003, iPartColor=7697908)
Geometry.Part.Cylinder(strName="Cylinder_2", dlOrigin=[0.0, 0.01, 0.0], dTopOuterRadius=0.003, dBottomOuterRadius=0.003, iPartColor=7463537)
Meshing.SetMeshAttribute(crlParts=[Part(1, 2)], surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlParts=[Part(1, 2)], surfaceMesh=SURFACE_MESH(dGeomAngle=0.7853981634, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0))

#Pretension SunShine
Connections.Pretension.SunShine(dForceValue=123.0, crlTargets=[Part(1, 2)])

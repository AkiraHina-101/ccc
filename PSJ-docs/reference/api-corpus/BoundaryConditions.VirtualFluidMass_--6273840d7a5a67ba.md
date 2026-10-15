# BoundaryConditions.VirtualFluidMass()

BoundaryConditions.VirtualFluidMass()

説明​

仮想流体質量を作成します。

構文​

BoundaryConditions.VirtualFluidMass(...)

マクロ:

リボン: BoundaryConditions » VirtualFluidMass

入力​

crEdit​

既存の仮想流体質量を指定する Cursor 。

デフォルト値は None です。

strName​

名前を指定する String 。

デフォルト値は"FluidVolume_1"です。

crlTargetFaces​

対象面を指定する List of Cursor 。

デフォルト値は[]です。

crlTargetElems​

対象要素を指定する List of Cursor 。

デフォルト値は[]です。

crlTargetGroups​

対象グループを指定する List of Cursor 。

デフォルト値は[]です。

iWettedSideType​

濡れ面側を指定する Integer 。

デフォルト値は0です。

crlNegativeSideTargets​

負の側の対象を指定する List of Cursor 。

デフォルト値は[]です。

dFluidDensity​

流体密度を指定する Double 。

デフォルト値は0.0です。

iFluidDensityUnit​

流体密度の単位を指定する Integer 。

デフォルト値は0です。

crCoordinate​

局所座標を指定する Cursor 。

デフォルト値は None です。

dFluidHeight​

流体の座標を指定する Double 。

デフォルト値は0.0です。

iFluidHeightUnit​

流体座標の単位を指定する Integer 。

デフォルト値は0です。

iPlaneOfSymmetry1​

対称面1を指定する Integer 。

デフォルト値は2です。

iPlaneOfSymmetry2​

対称面2を指定する Integer 。

デフォルト値は2です。

戻り値​

この関数は戻り値を持ちません。

サンプルコード​

Geometry.Part.Cube(
    ilAxialNodes=[4, 4, 4], 
    strName="Cube_2", 
    iPartColor=14903267)

Meshing.SolidMeshing(
    crlParts=[Part(1)], 
    bTet10=True, 
    dGradingFactor=1.05, 
    dStretchLimit=0.1, 
    iSpeedVsQual=1, 
    iRegion=1, 
    bSafeMode=False, 
    iParallel=16, 
    bInternalMeshOnly=False, 
    iPartColor=65280)

BoundaryConditions.VirtualFluidMass(
    crlTargetFaces=[Face(26, 24, 22, 23, 21)], 
    crlNegativeSideTargets=[Face(24, 22, 23, 21)],
    dFluidDensity=1000000000000000.0)

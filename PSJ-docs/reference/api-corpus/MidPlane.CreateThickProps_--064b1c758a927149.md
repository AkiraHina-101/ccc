# MidPlane.CreateThickProps()

MidPlane.CreateThickProps()

Description​

Create thickness properties for mid-plane

Syntax​

MidPlane.CreateThickProps(crlParts=[], dThickDiff=0.1, dMaxThick=DFLT_DBL, dMinThick=DFLT_DBL, crMatMembrane=None, crMatBend=None, crMatShear=None, crMatCoupl=None, iMatOrientType=0, dMatOrientX=DFLT_DBL, dMatOrientY=DFLT_DBL, dMatOrientZ=DFLT_DBL, crCoord=None, dThickness=DFLT_DBL, dBendStiff=DFLT_DBL, dThickRatio=1, dNSM=DFLT_DBL, dFiberDist1=DFLT_DBL, dFiberDist2=DFLT_DBL, dPlateOff=DFLT_DBL, iNumInterPts=0, bThickSetting=False, iEntityType=0, bDivideProp=False, crlRefPart=[])

Ribbon: MidPlane » CreateThickProps

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

dThickDiff​

A Double specifying the thickness difference.

The default value is 0.1.

dMaxThick​

A Double specifying the maximum thickness.

The default value is DFLT_DBL.

dMinThick​

A Double specifying the minimum thickness.

The default value is DFLT_DBL.

crMatMembrane​

A Cursor specifying the material membrane.

The default value is None.

crMatBend​

A Cursor specifying the material bend.

The default value is None.

crMatShear​

A Cursor specifying the material shear.

The default value is None.

crMatCoupl​

A Cursor specifying the material couple.

The default value is None.

iMatOrientType​

An Integer specifying the material orient type.

The default value is 0.

dMatOrientX​

A Double specifying the material orient x.

The default value is DFLT_DBL.

dMatOrientY​

A Double specifying the material orient y.

The default value is DFLT_DBL.

dMatOrientZ​

A Double specifying the material orient z.

The default value is DFLT_DBL.

crCoord​

A Cursor specifying the coordinate.

The default value is None.

dThickness​

A Double specifying the thickness.

The default value is DFLT_DBL.

dBendStiff​

A Double specifying the bend stiff.

The default value is DFLT_DBL.

dThickRatio​

A Double specifying the thickness ratio.

The default value is 1.

dNSM​

A Double specifying the n s m.

The default value is DFLT_DBL.

dFiberDist1​

A Double specifying the fiber distance 1.

The default value is DFLT_DBL.

dFiberDist2​

A Double specifying the fiber distance 2.

The default value is DFLT_DBL.

dPlateOff​

A Double specifying the plate off.

The default value is DFLT_DBL.

iNumInterPts​

An Integer specifying the number inter pts.

The default value is 0.

bThickSetting​

A Boolean specifying the thickness setting.

The default value is False.

iEntityType​

An Integer specifying the entity type.

The default value is 0.

bDivideProp​

A Boolean specifying the divide property.

The default value is False.

crlRefPart​

A List of Cursor specifying the reference part.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MidPlane.CreateThickProps(crlParts=[], dThickDiff=0.1, dMaxThick=DFLT_DBL, dMinThick=DFLT_DBL, crMatMembrane=None, crMatBend=None, crMatShear=None, crMatCoupl=None, iMatOrientType=0, dMatOrientX=DFLT_DBL, dMatOrientY=DFLT_DBL, dMatOrientZ=DFLT_DBL, crCoord=None, dThickness=DFLT_DBL, dBendStiff=DFLT_DBL, dThickRatio=1, dNSM=DFLT_DBL, dFiberDist1=DFLT_DBL, dFiberDist2=DFLT_DBL, dPlateOff=DFLT_DBL, iNumInterPts=0, bThickSetting=False, iEntityType=0, bDivideProp=False, crlRefPart=[])

# Geometry.BodyCut.XXYYOnOnePoint()

Geometry.BodyCut.XXYYOnOnePoint()

Description​

Separate a part along the specified coordinate plane with one node as a starting point.

Syntax​

Geometry.BodyCut.XXYYOnOnePoint(...)

Macro: CutBodyByPlane

Ribbon: Geometry » Body Cut » XX-YY On 1 Point

Inputs​

crPart​

A Cursor specifying the part to partition.

This is a required input.

posCutPoint​

A Position specifying a point on the cutting plane. This position can get from node, point on edge or point on face.

The default value is [0.0,0.0,0.0].

iCuttingPlane​

An Integer specifying the cutting plane.

If iType = 0, cutting by plane Oxy.

If iType = 1, cutting by plane Oxz.

If iType = 2, cutting by plane Oyz.

The default value is 0.

dOffsetDistance​

A Double specifying the offset distance from the selected position.

The default value is 0.0.

bSplitOnly​

A Boolean specifying whether or not retain the original part.

If False, the specified part will be divided into two parts separately.

If True, the specified part just split by cutting plane without dividing into two parts.

The default value is False.

bMakeSectionFace​

A Boolean specifying whether to generate a cross-section face at the division section.

The default value is True.

bSharedFace​

A Boolean specifying whether to generate a shared face at the division section. This argument will only affect the functionality when bMakeSectionFace=True and bSplitOnly=False.

The default value is False.

crLocalCoordinate​

A Cursor specifying the local coordinate. When the default value is used, the global coordinate is selected.

The default value is None.

bSeparateFace​

A Boolean specifying whether to prevent the section faces to be coupled (merge) in the enclave. This option will only affect the functionality if bMakeSectionFace=True.

If True, the section faces will be created separately.

If False, only a section face will be created.

The default value is False

Return Code​

A List of Cursor specifying the new bodies.

Sample Code​

Torus = Geometry.Part.Torus(strName="Torus_2", iPartColor=14114775)

separate_status = Geometry.BodyCut.XXYYOnOnePoint(crPart=Torus, 
                                                  posCutPoint=[-0.015,
                                                               -0.005, 
                                                               0.006],
                                                  iCuttingPlane=1, 
                                                  bSharedFace=True, 
                                                  bSeparateFace=True)

JPT.Debugger(separate_status)

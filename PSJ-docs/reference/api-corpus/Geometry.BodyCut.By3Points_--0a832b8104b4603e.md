# Geometry.BodyCut.By3Points()

Geometry.BodyCut.By3Points()

Description​

Separate a part using the given cutting planes defined by three points to partition the target parts.

Syntax​

Geometry.BodyCut.By3Points(...)

Macro: BodyCutBy3PointsS

Ribbon: Geometry » Body Cut » 3 Points

Inputs​

crPart​

A Cursor specifying the part to partition.

This is a required input.

poslPoints​

A List of Position specifying positions to define the cutting plane. Each position can get from node, point on edge or point on face.

The default value is [[0.0,0.0,0.0], [0.0,0.0,0.0], [0.0,0.0,0.0]].

dOffsetDistance​

A Double specifying the offset distance from the selected positions.

The default value is 0.0.

bSplitOnly​

A Boolean specifying whether or not to retain the original part.
If False, the given part will be divided into two parts separately.

If True, the given part just split by cutting plane without dividing into two parts.

The default value is False.

bMakeSectionFace​

A Boolean specifying whether to generate a cross-section face at the division section.

The default value is True.

bSharedFace​

A Boolean specifying whether to generate a shared face at the division section. This argument will only affect the functionality when bMakeSectionFace=True and bSplitOnly=False.

The default value is False.

bSeparateFace​

A Boolean specifying whether to prevent the section faces to be coupled (merge) in the enclave. This option will only affect the functionality if bMakeSectionFace=True.
If True, the section faces will be created separately.

If False, only a section face will be created.

The default value is False

Return Code​

A List of Cursor specifying the new bodies.

Sample Code​

part = Geometry.Part.Torus(strName="Torus_2", iPartColor=14114775)

cutting_status = Geometry.BodyCut.By3Points(crPart=part, 
                                            poslPoints=[[-0.038, -0.019, 0.017],
                                                        [-0.019, -0.010, 0.015], 
                                                        [0.048, 0.022, -0.006]], 
                                            bSharedFace=True, 
                                            bSeparateFace=True)

JPT.Debugger(cutting_status)

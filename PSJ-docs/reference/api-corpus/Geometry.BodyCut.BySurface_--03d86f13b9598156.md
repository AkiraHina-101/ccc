# Geometry.BodyCut.BySurface()

Geometry.BodyCut.BySurface()

Description​

Separate a part using the given cutting planes (By selecting face) to partition the target parts.

Syntax​

Geometry.BodyCut.BySurface(...)

Macro: BodyCutBySurfaceS

Ribbon: Geometry » Body Cut » By Surface

Inputs​

crlParts​

A List of Cursor specifying the parts to partition.

This is a required input.

crCutter​

A Cursor specifying the cutting face.

This is a required input.

bSplitOnly​

A Boolean specifying whether to prevent split the given part into two separate bodies.
If True, the specified part just split by cut plane without dividing into two parts.

If False, the specified part will be divided into two parts separately.

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

Geometry.Part.Cube()
Geometry.Part.Cylinder(dlOrigin=[0.005, -0.002, 0.005], 
                       dTopOuterRadius=0.002,
                       dBottomOuterRadius=0.002, 
                       dHeight=0.014)

Geometry.DeleteEntity.Face(crlFaces=[Face(29, 30)])

separated_bodies = Geometry.BodyCut.BySurface(crlParts=[Part(1)], 
                                              crCutter=Part(2), 
                                              bSharedFace=True)

JPT.Debugger(separated_bodies)

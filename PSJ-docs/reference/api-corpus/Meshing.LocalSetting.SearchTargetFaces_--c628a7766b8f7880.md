# Meshing.LocalSetting.SearchTargetFaces()

Meshing.LocalSetting.SearchTargetFaces()

Description​

Search Target Faces for Local mesh setting

Syntax​

Meshing.LocalSetting.SearchTargetFaces(iPartType=0, dlOrigin=[0, 0, 0], dlLength=[0.1, 0.1, 0.1],
    dlCenterPt=[0.0,0.0,0.0], dlAxisPt1=[0.0,0.0,0.1], dlAxisPt2=[0.0,0.0,0.0], bEnclosed=False)

Macro: SearchTargetFacesInModel

Ribbon: Meshing » LocalSetting » SearchTargetFaces

Inputs​

iPartType​

An Integer specifying the part type.

The default value is 0.

dlOrigin​

A Double List specifying the original.

The default value is [0, 0, 0].

dlLength​

A Double List specifying the length.

The default value is [0.1, 0.1, 0.1].

dlCenterPt​

A Double List specifying the center point.

The default value is [0.0,0.0,0.0].

dlAxisPt1​

A Double List specifying the axis point 1.

The default value is [0.0,0.0,0.1].

dlAxisPt2​

A Double List specifying the axis point 2.

The default value is [0.0,0.0,0.0].

bEnclosed​

A Boolean specifying the enclosed.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Meshing.LocalSetting.SearchTargetFaces(iPartType=0, dlOrigin=[0, 0, 0], dlLength=[0.1, 0.1, 0.1],
    dlCenterPt=[0.0,0.0,0.0], dlAxisPt1=[0.0,0.0,0.1], dlAxisPt2=[0.0,0.0,0.0], bEnclosed=False)

# Geometry.MergeEntities.Parts()

Geometry.MergeEntities.Parts()

Description​

Merge several parts into a single part. The first selected part will be retained, others will be merged into the first part.
Load conditions and material properties, etc., which have been set on faces and edges, will be updated to the merged part automatically.

Syntax​

Geometry.MergeEntities.Parts(...)

Macro: MergePart

Ribbon: Geometry » Merge Entities » Parts

Inputs​

crlParts​

A List of Cursor specifying the parts to be merged.

This is a required input.

dMergeTolerance​

A Double specifying the maximum distance between nodes of the given parts that will be merged.

The default value is 1e-5.

bRemoveSharedFace​

A Boolean specifying whether to remove the shared faces between the given parts after merging.

The default value is True.

Return Code​

A Cursor specifying the merged part.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0],
                   strName="Cube_2")
merged_part = Geometry.MergeEntities.Parts(crlParts=[Part(1, 2)],
                                           dMergeTolerance=1e-05)
JPT.Debugger(merged_part)

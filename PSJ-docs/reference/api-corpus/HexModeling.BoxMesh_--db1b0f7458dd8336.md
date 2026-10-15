# HexModeling.BoxMesh()

HexModeling.BoxMesh()

Description​

Box hex mesh creator for parts

Syntax​

HexModeling.BoxMesh(...)

Ribbon: HexModeling » BoxMesh

Inputs​

ilPartIds​

A List of Integer specifying the part ids.

This is a required input.

dMeshSize​

A Double specifying the mesh size.

This is a required input.

strMaterialName​

A String specifying the material name.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube()
HexModeling.BoxMesh(ilPartIds=[1], dMeshSize=0.002, strMaterialName="")

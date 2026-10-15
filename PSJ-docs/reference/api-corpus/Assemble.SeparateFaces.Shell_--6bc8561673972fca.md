# Assemble.SeparateFaces.Shell()

Assemble.SeparateFaces.Shell()

Description​

Separate shared Nodes for Shell that is shared between the shell parts into double nodes.

Syntax​

Assemble.SeparateFaces.Shell(...)

Ribbon: Assemble » Separate Faces » Shell

Inputs​

iType​

An Integer specifying the type of entity to be selected.

The default value is 0.

crlEntity​

A List of Cursor specifying the list of target item which will be separated.

The default value is [].

bCreateGroup​

A Boolean enable/disable create group option.

The default value is False.

Return Code​

A List Cursor of separated edges if success, or None if fail.

Sample Code​

Geometry.Part.Cube(strName="Cube_1",
                   iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=7463537)
MeshEdit.MergeNodes(crlTargets=[Part(1, 2)])

edges = Assemble.SeparateFaces.Shell(iType=1,
                                    crlEntity=[Part(1, 2)])
JPT.Debugger(edges)

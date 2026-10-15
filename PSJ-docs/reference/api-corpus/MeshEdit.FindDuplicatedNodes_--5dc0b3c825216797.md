# MeshEdit.FindDuplicatedNodes()

MeshEdit.FindDuplicatedNodes()

Description​

Find nodes with overlapping positions.

Syntax​

MeshEdit.FindDuplicatedNodes(...)

Macro: FindDuplicatedNodes

Ribbon: MeshEdit » FindDuplicatedNodes » Find

Inputs​

crlTargets​

A List of Cursor specifying target entities to search duplicate nodes among them.

The default value is [].

dTolerance​

A Double specifying torelance to search nodes duplication.

The default value is 1e-5.

bCreateGroup​

A Bool specifying flag to create group of detected nodes.

The default value is False.

bSelect​

A Bool specifying flag to select detected nodes.

The default value is False.

bPreview​

A Bool specifying flag to display preview after execution.

The default value is False.

Return Code​

A List of CursorStr specifying the detected nodes.

Sample Code​

# Preapre model
Geometry.Part.Cube(iPartColor=6409934)
Geometry.Part.Cube(
    dlLength=[0.0105, 0.011, 0.01], 
    strName="Cube_2", 
    iPartColor=7961077)

# Find duplication
dupnodes=MeshEdit.FindDuplicatedNodes(
    crlTargets=[Part(1, 2)], 
    bSelect=True)

print(f"{len(dupnodes)} nodes are duplicated")
print(f"nodes' id:{[i.getID() for i in dupnodes]}")

# MufflerHA.CopyMeshCount()

MufflerHA.CopyMeshCount()

Description​

Syntax​

MufflerHA.CopyMeshCount(crlMasterEdge, crlSlaveEdge, strBaseName)

Ribbon: MufflerHA » CopyMeshCount

Inputs​

crlMasterEdge​

A List of Cursor specifying the master edge.

This is a required input.

crlSlaveEdge​

A List of Cursor specifying the slave edge.

This is a required input.

strBaseName​

A String specifying the base name.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MufflerHA.CopyMeshCount(crlMasterEdge, crlSlaveEdge, strBaseName)

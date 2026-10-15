# Connections.BoltMeshingNotSplitOnly()

Connections.BoltMeshingNotSplitOnly()

Description​

Unknown Description

Syntax​

Connections.BoltMeshingNotSplitOnly(...)

Ribbon: Connections » BoltMeshingNotSplitOnly

Inputs​

strName​

A String specifying the name.

The default value is "".

iPartcutparamImethod​

An Integer specifying the part cut parameter method.

The default value is 0.

dPartcutparamDoffset​

A Double specifying the part cut parameter offset.

The default value is 0.0.

iPartcutparamBshareface​

An Integer specifying the part cut parameter share face.

The default value is 0.

iPartcutparamBseparateface​

An Integer specifying the part cut parameter separate face.

The default value is 0.

iPartcutparamBsplitonly​

An Integer specifying the part cut parameter split only.

The default value is 0.

iPartcutparamBmakesectionface​

An Integer specifying the part cut parameter make section face.

The default value is 0.

crPartcutparamCoord​

A Cursor specifying the part cut parameter coordinate.

The default value is None.

surfaceMesh​

A SURFACE_MESH specifying the mesh.

The default value is SURFACE_MESH.

iLBCPRETENSIONDATAIdir​

An Integer specifying the load boundary condition pretension data direction.

The default value is 0.

dLBCPRETENSIONDATADvalue​

A Double specifying the load boundary condition pretension data value.

The default value is 0.0.

bLBCPRETENSIONDATABfixlength​

A Boolean specifying the load boundary condition pretension data fixed length.

The default value is False.

crLBCPRETENSIONDATACrtable​

A Cursor specifying the load boundary condition pretension data table.

The default value is None.

crLBCPRETENSIONDATACrcoord​

A Cursor specifying the load boundary condition pretension data coordinate.

The default value is None.

iLBCPRETENSIONDATAIlocalunit​

An Integer specifying the load boundary condition pretension data local unit.

The default value is 0.

crlTargets​

A List of Cursor specifying the target.

The default value is [].

poslCutter​

A Position List specifying the cutter.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.BoltMeshingNotSplitOnly(strName="", iPartcutparamImethod=0, dPartcutparamDoffset=0.0, iPartcutparamBshareface=0, iPartcutparamBseparateface=0, iPartcutparamBsplitonly=0, iPartcutparamBmakesectionface=0, crPartcutparamCoord=None, surfaceMesh=SURFACE_MESH(), iLBCPRETENSIONDATAIdir=0, dLBCPRETENSIONDATADvalue=0.0, bLBCPRETENSIONDATABfixlength=False, crLBCPRETENSIONDATACrtable=None, crLBCPRETENSIONDATACrcoord=None, iLBCPRETENSIONDATAIlocalunit=0, crlTargets=[], poslCutter=[])

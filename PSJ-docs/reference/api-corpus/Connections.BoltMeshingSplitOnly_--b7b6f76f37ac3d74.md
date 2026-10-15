# Connections.BoltMeshingSplitOnly()

Connections.BoltMeshingSplitOnly()

Description​

Unknown Description

Syntax​

Connections.BoltMeshingSplitOnly(...)

Ribbon: Connections » BoltMeshingSplitOnly

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

bLBCPRETENSIONABAQUSDATABfixedlenght​

A Boolean specifying the load boundary condition pretension abaqus data fixed length.

The default value is False.

crLBCPRETENSIONABAQUSDATACrtable​

A Cursor specifying the load boundary condition pretension abaqus data table.

The default value is None.

dLBCPRETENSIONABAQUSDATADvalue​

A Double specifying the load boundary condition pretension abaqus data value.

The default value is 0.0.

iLBCPRETENSIONABAQUSDATAIlocalunit​

An Integer specifying the load boundary condition pretension abaqus data local unit.

The default value is 0.

strLBCPRETENSIONABAQUSDATAStrnormal​

A String specifying the load boundary condition pretension abaqus data normal.

The default value is "".

posLBCPRETENSIONABAQUSDATATvctrolnodepos​

A Position specifying the load boundary condition pretension abaqus data node position.

The default value is [0,0,0].

crlTargets​

A List of Cursor specifying the target.

The default value is [].

poslCutter​

A Position List specifying the cutter.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.BoltMeshingSplitOnly(strName="", iPartcutparamImethod=0, dPartcutparamDoffset=0.0, iPartcutparamBshareface=0, iPartcutparamBseparateface=0, iPartcutparamBsplitonly=0, iPartcutparamBmakesectionface=0, crPartcutparamCoord=None, surfaceMesh=SURFACE_MESH(), bLBCPRETENSIONABAQUSDATABfixedlenght=False, crLBCPRETENSIONABAQUSDATACrtable=None, dLBCPRETENSIONABAQUSDATADvalue=0.0, iLBCPRETENSIONABAQUSDATAIlocalunit=0, strLBCPRETENSIONABAQUSDATAStrnormal="", posLBCPRETENSIONABAQUSDATATvctrolnodepos=[0,0,0], crlTargets=[], poslCutter=[])

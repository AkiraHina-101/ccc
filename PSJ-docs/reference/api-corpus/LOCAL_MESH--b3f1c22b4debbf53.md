# LOCAL_MESH

LOCAL_MESH

Description​

A data type uses to control parameters of Local Mesh

Attributes​

iEntityType​

An Integer specifying the type of the selected entity, which must be one of the following:

1: Part

2: Face

3: Edge

8: Face point

9: Edge point

10: Solid point

The default value is 0 (Unspecified type).

bEnableSizeParams​

A Boolean specifying whether to set local size parameter or not. If this parameter is True, dAvgElemSize, dMaxElemSize and dMinElemSize will be used.

The default value is False.

dAvgElemSize​

A Double specifying the average mesh size of the selected entity. This parameter is used only when bEnableSizeParams is True.

The default value is 0.0.

dMaxElemSize​

A Double specifying the maximum mesh size of the selected entity. This parameter must be greater than dAvgElemSize, at least 1.4*dAvgElemSize. This parameter is used only when bEnableSizeParams is True.

The default value is 0.0.

dMinElemSize​

A Double specifying the minimum mesh size of the selected entity. This parameter must be smaller than dAvgElemSize, at most 0.7*dAvgElemSize. This parameter is used only when bEnableSizeParams is True.

The default value is 0.0.

bEnableTrimAngle​

A Boolean specifying whether to set trim angle parameter or not. If this parameter is True, dTrimAngle will be used. This parameter is mainly used for local mesh setting on Edge type entity.

The default value is False.

dTrimAngle​

A Double specifying the largest control angle allowed when generating mesh on edges. This angle is defined as the angle formed by two consecutive 1D elements. This parameter is used only when bEnableTrimAngle is True.

The default value is 0.0.

bEnableMeshCount​

A Boolean specifying whether to set mesh count parameter or not. If this parameter is True, iNodeCount will be used. This parameter is mainly used for local mesh setting on Edge type entity. 

The default value is False.

iNodeCount​

An Integer specifying number of nodes when generating mesh on edges. This parameter is used only when bEnableMeshCount is True.

The default value is 0.

iBiasNodeId​

An Integer specifying bias node ID. Dense area of bias set up will start from this node. The parameter is used only when bEnableMeshCount is True and iBiasMethod is 1 (Bias).

The default value is 0.

dBiasFactor​

A Double specifying bias factor, which could be the equal ratio r (if iBiasProgression is 0) or the equal difference (if iBiasProgression is 1). This parameter can only be used only when bEnableMeshCount is True and iBiasMethod is 2 or 3.

The default value is 0.0.

iBiasMethod​

An Integer specifying bias method. This parameter is mainly used for local mesh setting on Edge type entity. The number of node to set up is specified in iNodeCount, with bias factor dBiasFactor and progression method iBiasProgression. This parameter and can be one of the following

0: Equal: no bias is set up, nodes are equally distributed.

1: Bias: bias is set up, nodes are distributed so that dense area starts from node with id iBiasNodeId.

2: Bias-sides: bias is set up, nodes are distributed so that dense area starts from both 2 bounding nodes of the edge.

3: Bias-center: bias is set up, nodes are distributed so that dense area is at the middle distance of the edge.

This parameter is used only when bEnableMeshCount is True.

The default value is 0.

iBiasProgression​

An Integer specifying bias progression method, which can be one of the following:

0: Geometric: distance of nodes will increase by an equal ratio r, where r is bias factor dBiasFactor. For example, when r = 2, if distance between first node and second node is 1, distance between second and third node will be 1 * r = 2, and the next distance will be 4.

1: Arithmetic: distance of nodes will increase by an equal difference d, where d is bias factor dBiasFactor. For example, when d = 2, if distance between first node and second node is 1, distance between second and third node will be 1 + d = 3, and the next distance will be 5.

This parameter is used only when bEnableMeshCount is True and iBiasMethod is 2 or 3.

The default value is 0.

bEnableMeshPattern​

A Boolean specifying whether to force a specify mesh pattern on the selected entity or not. If this parameter is True, iMeshPatternType will be used. This parameter is mainly used for local mesh setting on Face entity type.

The default value is False.

iMeshPatternType​

An Integer specifying mesh pattern type, which can be of the following:

0: Unstructured: a mesh pattern with equilateral triangles are formed.

1: Structured: a mesh pattern with right angle triangles are formed (isometric pattern).

2: Imprinting-Iso: a mesh pattern with isometric mesh is imprinted on faces with holes in the middle.

This parameter is used only when bEnableMeshPattern is True.

The default value is 0.

bEnableKeepEntity​

A Boolean specifying whether to keep this entity when meshing or not. For better mesh quality, when meshing, some edges or faces will be merged or deleted. If this parameter is True, the entity is prevented from being merged or deleted.

The default value is False.

dFixedPointX​

A Double specifying fixed point position in x direction.

The default value is 0.0.

dFixedPointY​

A Double specifying fixed point position in y direction.

The default value is 0.0.

dFixedPointZ​

A Double specifying fixed point position in z direction.

The default value is 0.0.

iFixedPointId​

An Integer specifying fixed point ID.

The default value is 0.

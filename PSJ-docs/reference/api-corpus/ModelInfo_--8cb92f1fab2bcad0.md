# ModelInfo()

ModelInfo()

Description​

Get Model Information from Target String

Syntax​

ModelInfo(Target String) or ModelInfo(Target String,Name String)

Inputs​

1. String​

Target String(bodyNum,faceNum,edgeNum,vertexNum, surfaceNodeNum,solidNodeNum,surfaceElemNum,solidElemNum, tri3ElemNum,tri6ElemNum,quad4ElemNum,quad8ElemNum, tet4ElemNum,tet10ElemNum,hex8ElemNum,hex20ElemNum,penta5ElemNum,penta6ElemNum,penta15ElemNum,pyramid13ElemNum or coordinateByName,loadCaseByName,materialByName,bodyByName,LBCByName,AbaqusStepByName,PropertyByName,GroupByName)

2. String​

Name

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ModelInfo("surfaceElemNum")

or

ModelInfo("coordinateByName","aaaa")

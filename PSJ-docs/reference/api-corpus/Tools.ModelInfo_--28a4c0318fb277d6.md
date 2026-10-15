# Tools.ModelInfo()

Tools.ModelInfo()

Description​

Export model info file

Syntax​

Tools.ModelInfo(strPath, strPathName="", listMeshPartInfoTool=[], bPropertyAssignedPart=False, bPropertyAssignedSummary=False, iModelNode=0, iNmodelnodeWithprop=0, ilModelElement=[], ilNmodelelemWithprop=[], ilModelLBC=[], iModelContact=0, ilModelConnection=[], ilModelProperty=[])

Ribbon: Tools » ModelInfo

Inputs​

strPath​

A String specifying the path.

This is a required input.

strPathName​

A String specifying the path name.

The default value is "".

listMeshPartInfoTool​

A MESH_PART_INFO_TOOL List specifying the mesh part info tool.

The default value is [].

bPropertyAssignedPart​

A Boolean specifying the property assigned part.

The default value is False.

bPropertyAssignedSummary​

A Boolean specifying the property assigned summary.

The default value is False.

iModelNode​

An Integer specifying the model node.

The default value is 0.

iNmodelnodeWithprop​

An Integer specifying the nmodelnode withprop.

The default value is 0.

ilModelElement​

A List of Integer specifying the model element.

The default value is [].

ilNmodelelemWithprop​

A List of Integer specifying the nmodelelem withprop.

The default value is [].

ilModelLBC​

A List of Integer specifying the model load boundary condition.

The default value is [].

iModelContact​

An Integer specifying the model contact.

The default value is 0.

ilModelConnection​

A List of Integer specifying the model connection.

The default value is [].

ilModelProperty​

A List of Integer specifying the model property.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Tools.ModelInfo(strPath, strPathName="", listMeshPartInfoTool=[], bPropertyAssignedPart=False, bPropertyAssignedSummary=False, iModelNode=0, iNmodelnodeWithprop=0, ilModelElement=[], ilNmodelelemWithprop=[], ilModelLBC=[], iModelContact=0, ilModelConnection=[], ilModelProperty=[])

# Tools.Renumber()

Tools.Renumber()

Description​

Renumber the IDs of the model such as Face, Edge, Elements(1D,2D,3D) and Nodes.

Syntax​

Tools.Renumber(...)

Ribbon: Tools » Renumber

Inputs​

listRenumberItem​

A List of RENUMBER_ITEM specifying the renumber information.

This is a required input.

bAssignProp​

A Boolean specifying whether to renumber the assigned-property elements or not. This parameter can only be used when elements(1D, 2D, 3D) are the target to renumber. Other entities namely Faces, Edges, Nodes are not able to use by this argument.

If True, only elements to which property is assigned will be renumbered.

If False, all existing elements will be renumbered.

The default value is True.

bSurfCornerFirst​

A Boolean specifying whether Nodes are needed to renumber from the surface corner first. This parameter can only be used when Nodes are the target to renumber. Other entities are not able to use by this argument.

If True, Nodes(vertices) on the corner of Faces would have the first priority to renumber, other Nodes such as mid Nodes, internal Nodes would have lower order when renumber.

If False, Nodes(vertices) on the corner of Faces would have same priority with others Nodes

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

result = Tools.Renumber(listRenumberItem=[RENUMBER_ITEM(crTarget=Part(1), 
                                                        iBeginID=1000, 
                                                        iCount=488, 
                                                        ilOffset=[10000, 100, 1], 
                                                        dlCoordTolerance=[0.1, 0.1, 0.1], 
                                                        bEnable=True)])

JPT.Debugger(result)

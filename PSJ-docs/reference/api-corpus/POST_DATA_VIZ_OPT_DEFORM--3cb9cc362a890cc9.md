# POST_DATA_VIZ_OPT_DEFORM

POST_DATA_VIZ_OPT_DEFORM

Description​

A data type is used to set up the result settings for displaying the deformation.

Attributes​

iScaleMethod​

An Integer specifying the displacement scale method.

0: Percentage of Model Size

1: Percentage of Result

The default value is 0.

dDisplacementRatio​

A Double specifying the overall displacement scale factor.

The default value is 0.07.

bEachDirectionRatio​

A Boolean specifying whether to enable to change the displacement scale ratio in each of the X, Y, and Z directions.

The default value is False.

dlEachDirectionRatio​

A List of Double specifying the deformation scale ratio in each of the X, Y and Z direction.

The default value is [0.07,0.07,0.07].

bShowShade​

A Boolean specifying whether to show/hide the surface of original model before deformation.

The default value is False.

iShadeColor​

An Integer specifying the surface color of original model before deformation.

The default value is 13158600.

bShowMesh​

A Boolean specifying whether to show/hide the mesh line of original model before deformation.

The default value is True.

iMeshColor​

An Integer specifying the mesh line color of original model before deformation.

The default value is 11184810.

bShowEdge​

A Boolean specifying whether to show/hide the edge of original model before deformation.

The default value is True.

iEdgeColor​

An Integer specifying the edge color of original model before deformation.

The default value is 11184810.

dTransparency​

A Double specifying the transparency value in shade mode.

The default value is 0.8.

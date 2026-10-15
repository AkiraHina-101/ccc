# Post.ResultSettings.Vector()

Post.ResultSettings.Vector()

Description​

Set up the result settings for displaying the vector.

Syntax​

Post.ResultSettings.Vector(...)

Macro: CmdPostVectorSettings

Ribbon: Post » ResultSettings » Vector

Inputs​

postDataVizOptVector​

A POST_DATA_VIZ_OPT_VECTOR specifying all settings of the result vector display.

The default value is POST_DATA_VIZ_OPT_VECTOR.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Vector(postDataVizOptVector=PostDataVizOptVector(dRatioModel=0.05, dRatioScreen=0.05))

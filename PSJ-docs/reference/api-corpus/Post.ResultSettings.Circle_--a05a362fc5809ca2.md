# Post.ResultSettings.Circle()

Post.ResultSettings.Circle()

Description​

Set up the result settings for displaying the circle.

Syntax​

Post.ResultSettings.Circle(...)

Macro: CmdPostCircleSettings

Ribbon: Post » ResultSettings » Circle

Inputs​

postDataVizOptCircle​

A POST_DATA_VIZ_OPT_CIRCLE specifying all settings of the circle display.

The default value is POST_DATA_VIZ_OPT_CIRCLE.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Circle(postDataVizOptCircle=PostDataVizOptCircle(dRatioModel=0.05, dRatioScreen=0.05))

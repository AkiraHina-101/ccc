# Post.ResultSettings.Opacity()

Post.ResultSettings.Opacity()

Description​

Set up the result settings for displaying the opacity.

Syntax​

Post.ResultSettings.Opacity(...)

Macro: CmdPostTransparencySettings

Ribbon: Post » ResultSettings » Opacity

Inputs​

postDataVizOptTransparency​

A POST_DATA_VIZ_OPT_TRANSPARENCY specifying all settings of the opacity display.

The default value is POST_DATA_VIZ_OPT_TRANSPARENCY.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Opacity(postDataVizOptTransparency=PostDataVizOptTransparency(dTransparency=0.5))

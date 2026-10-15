# Post.ResultSettings.Title()

Post.ResultSettings.Title()

Description​

Set up the result settings for displaying the title.

Syntax​

Post.ResultSettings.Title(...)

Macro: CmdPostTitleSettings

Ribbon: Post » ResultSettings » Title

Inputs​

postDataVizOptTitle​

A POST_DATA_VIZ_OPT_TITLE specifying all settings of the result title display.

The default value is POST_DATA_VIZ_OPT_TITLE.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Title(postDataVizOptTitle=PostDataVizOptTitle(iBackgroundFillColor=17919, dTransparency=0.6))

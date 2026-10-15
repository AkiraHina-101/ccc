# Post.ResultSettings.Deformation()

Post.ResultSettings.Deformation()

Description​

Set up the result settings for displaying the deformation.

Syntax​

Post.ResultSettings.Deformation(...)

Macro: CmdPostDeformSettings

Ribbon: Post » ResultSettings » Deformation

Inputs​

postDataVizOptDeform​

A POST_DATA_VIZ_OPT_DEFORM specifying all settings of the deformation display.

The default value is POST_DATA_VIZ_OPT_DEFORM.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Deformation(postDataVizOptDeform=PostDataVizOptDeform(bEachDirectionRatio=True))

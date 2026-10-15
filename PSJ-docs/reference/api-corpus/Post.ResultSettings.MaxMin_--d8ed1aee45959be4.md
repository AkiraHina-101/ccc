# Post.ResultSettings.MaxMin()

Post.ResultSettings.MaxMin()

Description​

Set up the result settings for displaying Max/Min value.

Syntax​

Post.ResultSettings.MaxMin(...)

Macro: CmdPostMaxMinSettings

Ribbon: Post » ResultSettings » MaxMin

Inputs​

postDataVizOptMaxMin​

A POST_DATA_VIZ_OPT_MAXMIN specifying all settings to display Max/Min value.

The default value is POST_DATA_VIZ_OPT_MAXMIN.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.MaxMin(postDataVizOptMaxMin=PostDataVizOptMaxMin(iGroupMethod=1))

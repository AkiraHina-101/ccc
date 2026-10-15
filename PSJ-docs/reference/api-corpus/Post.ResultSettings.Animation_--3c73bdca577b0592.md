# Post.ResultSettings.Animation()

Post.ResultSettings.Animation()

Description​

Set up the result settings for displaying the animation.

Syntax​

Post.ResultSettings.Animation(...)

Macro: CmdPostAnimationSettings

Ribbon: Post » ResultSettings » Animation

Inputs​

postDataVizOptAnimation​

A POST_DATA_VIZ_OPT_ANIMATION specifying all settings of the animation display.

The default value is POST_DATA_VIZ_OPT_ANIMATION.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Animation(postDataVizOptAnimation=PostDataVizOptAnimation(iLoopType=2, bFixContour=True))

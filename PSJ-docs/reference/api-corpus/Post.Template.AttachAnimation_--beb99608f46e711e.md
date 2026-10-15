# Post.Template.AttachAnimation()

Post.Template.AttachAnimation()

Description​

Attach the current animation settings to the specified template.

Syntax​

Post.Template.AttachAnimation(...)

Macro: AttachTemplateAnimation

Ribbon: Post » Template » AttachAnimation

Inputs​

strName​

A String specifying the name of template, which will attach the animation settings.

The default value is "NewTemplate".

postDataVizOptAnimation​

A POST_DATA_VIZ_OPT_ANIMATION specifying all settings of the animation display.

The default value is POST_DATA_VIZ_OPT_ANIMATION.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="Animation_Template", strComment="Attach Animation Template")
template = Post.Template.AttachAnimation(strName="Animation_Template", 
                                        postDataVizOptAnimation=POST_DATA_VIZ_OPT_ANIMATION(
                                            iFPS=10, 
                                            iFrameNumber=10, 
                                            iLoopType=0, 
                                            bPhaseAngle=True))
JPT.Debugger(template)

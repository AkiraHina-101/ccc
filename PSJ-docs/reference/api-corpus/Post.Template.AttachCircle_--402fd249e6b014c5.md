# Post.Template.AttachCircle()

Post.Template.AttachCircle()

Description​

Attach the current result circle settings to the specified template.

Syntax​

Post.Template.AttachCircle(...)

Macro: AttachTemplateCircle

Ribbon: Post » Template » AttachCircle

Inputs​

strName​

A String specifying the name of template, which will attach the circle settings.

The default value is "NewTemplate".

postDataVizOptCircle​

A POST_DATA_VIZ_OPT_CIRCLE specifying all settings of the circle display.

The default value is POST_DATA_VIZ_OPT_CIRCLE.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="Circle_Template", strComment="Attach Circle Template")
template = Post.Template.AttachCircle(strName="Circle_Template", 
                                    postDataVizOptCircle=POST_DATA_VIZ_OPT_CIRCLE(
                                        dRatioModel=0.04, 
                                        dRatioScreen=0.04))
JPT.Debugger(template)

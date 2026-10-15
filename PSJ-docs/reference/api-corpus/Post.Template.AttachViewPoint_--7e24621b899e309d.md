# Post.Template.AttachViewPoint()

Post.Template.AttachViewPoint()

Description​

Attach the current view point settings to the specified template

Syntax​

Post.Template.AttachViewPoint(...)

Macro: AttachTemplateViewPoint

Ribbon: Post » Template » AttachViewPoint

Inputs​

strName​

A String specifying specifying the name of template, which will attach the viewpoint settings.

The default value is "NewTemplate".

postDataVizOptViewPoint​

A POST_DATA_VIZ_OPT_VIEWPOINT specifying all settings of a view point.

The default value is POST_DATA_VIZ_OPT_VIEWPOINT.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="ViewPoint_Template", strComment="Attach View Point Template")
template = Post.Template.AttachViewPoint(strName="ViewPoint_Template", 
                                        postDataVizOptViewPoint=POST_DATA_VIZ_OPT_VIEWPOINT(
                                            dlTranslationMatrix=[-0.707107, -0.5, 0.5, 0.0, 0.707107, -0.5, 0.5, 0.0, -4.49147e-08, 0.707107, 0.707107, 0.0, 0.0, 0.0, 0.0, 1.0], 
                                            dlCenter=[0.016, 0.005, 0.0025], 
                                            dScaleFactor=0.0115058))
JPT.Debugger(template)

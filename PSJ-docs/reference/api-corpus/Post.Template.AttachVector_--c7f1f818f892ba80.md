# Post.Template.AttachVector()

Post.Template.AttachVector()

Description​

Attach the current vector settings to the specified template.

Syntax​

Post.Template.AttachVector(...)

Macro: AttachTemplateVector

Ribbon: Post » Template » AttachVector

Inputs​

strName​

A String specifying the name of template, which will attach the vector settings.

The default value is "NewTemplate".

postDataVizOptVector​

A POST_DATA_VIZ_OPT_VECTOR specifying all settings of the result vector display.

The default value is POST_DATA_VIZ_OPT_VECTOR.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="Vector_Template", strComment="Attach Vector Template")
template = Post.Template.AttachVector(strName="Vector_Template", 
                                    postDataVizOptVector=POST_DATA_VIZ_OPT_VECTOR(
                                        dRatioModel=0.05, 
                                        dRatioScreen=0.05))
JPT.Debugger(template)

# Post.Template.AttachDeformation()

Post.Template.AttachDeformation()

Description​

Attach the current deformation settings to the specified template.

Syntax​

Post.Template.AttachDeformation(...)

Macro: AttachTemplateDeformation

Ribbon: Post » Template » AttachDeformation

Inputs​

strName​

A String specifying the name of template, which will attach the deformation settings.

The default value is "NewTemplate".

postDataVizOptDeform​

A POST_DATA_VIZ_OPT_DEFORM specifying all settings of the deformation display.

The default value is POST_DATA_VIZ_OPT_DEFORM.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="Deformation_Template", strComment="Attach Deformation Template")
template = Post.Template.AttachDeformation(strName="Deformation_Template", 
                                        postDataVizOptDeform=POST_DATA_VIZ_OPT_DEFORM(
                                            bEachDirectionRatio=True, 
                                            dlEachDirectionRatio=[0.05, 0.05, 0.05]))
JPT.Debugger(template)

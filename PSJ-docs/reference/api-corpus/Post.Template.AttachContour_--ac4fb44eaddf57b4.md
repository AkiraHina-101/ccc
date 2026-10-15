# Post.Template.AttachContour()

Post.Template.AttachContour()

Description​

Attach the current contour settings to the specified template.

Syntax​

Post.Template.AttachContour(...)

Macro: AttachTemplateContour

Ribbon: Post » Template » AttachContour

Inputs​

strName​

A String specifying the name of Template will attach the contour settings.

The default value is "NewTemplate".

postDataVizOptContour​

A POST_DATA_VIZ_OPT_CONTOUR specifying all settings of the contour display.

The default value is POST_DATA_VIZ_OPT_CONTOUR.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="Contour_Template", strComment="Attach Contour Template")
template = Post.Template.AttachContour(strName="Contour_Template", 
                                    postDataVizOptContour=POST_DATA_VIZ_OPT_CONTOUR(
                                        iColorDivision=20, 
                                        dMaxUser=0, 
                                        dMinUser=0))
JPT.Debugger(template)

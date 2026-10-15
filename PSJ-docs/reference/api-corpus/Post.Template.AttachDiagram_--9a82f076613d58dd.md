# Post.Template.AttachDiagram()

Post.Template.AttachDiagram()

Description​

Attach the current diagram settings to the specified template.

Syntax​

Post.Template.AttachDiagram(...)

Macro: AttachTemplateDiagram

Ribbon: Post » Template » AttachDiagram

Inputs​

strName​

A String specifying the name of template, which will attach the diagram settings.

The default value is "NewTemplate".

postDataVizOptDiagram​

A POST_DATA_VIZ_OPT_DIAGRAM specifying all settings of the diagram display.

The default value is POST_DATA_VIZ_OPT_DIAGRAM.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="Diagram_Template", strComment="Attach Diagram Template")
template = Post.Template.AttachDiagram(strName="Diagram_Template", 
                                    postDataVizOptDiagram=POST_DATA_VIZ_OPT_DIAGRAM(
                                        dRatioModel=0.05, 
                                        dRatioScreen=0.05))
JPT.Debugger(template)

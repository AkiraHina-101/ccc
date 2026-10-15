# Post.Template.AttachCrossSection()

Post.Template.AttachCrossSection()

Description​

Attach the current cross section settings to the specified template.

Syntax​

Post.Template.AttachCrossSection(...)

Macro: AttachTemplateCrossSection

Ribbon: Post » Template » AttachCrossSection

Inputs​

strName​

A String specifying the name of template, which will attach the cross section settings.

The default value is "NewTemplate".

postDataVizOptCrossSection​

A POST_DATA_VIZ_OPT_SECTION specifying all settings of the cross section display.

The default value is POST_DATA_VIZ_OPT_SECTION.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.Template.Create(strName="Cross Section", strComment="Attach Cross Section Template")
template = Post.Template.AttachCrossSection(strName="Cross Section", 
                                        postDataVizOptCrossSection=POST_DATA_VIZ_OPT_CROSS_SECTION(
                                            bCapping=False, 
                                            bCuttingEdge=True, 
                                            bSectionElem=True, 
                                            bMeshLine=True, 
                                            dlTranslationMatrix=[1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.016, 0.005, 0.0025, 1.0], 
                                            dlPosition=[0.016, 0.005, 0.0025]))
JPT.Debugger(template)

# Post.Template.Import()

Post.Template.Import()

Description​

Import the contents of the saved template settings (*.xml) into the template list.

Syntax​

Post.Template.Import(...)

Macro: ImportTemplate

Ribbon: Post » Template » Import

Inputs​

strPath​

A String specifying the path of *.xml file will be imported.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Create new Template
Post.Template.Create(strName="Template_1", strComment="")
Post.Template.AttachViewPoint(strName="Template_1", dlCenter=[0.016, 0.005, 0.0025], dScaleFactor=0.0349344)
Post.Template.Export(strPath="C:/temp/Template_1.xml")
Post.Template.Delete(strName="Template_1")

# Import template
importTemplate = Post.Template.Import(strPath="C:/temp/Template_1.xml")
JPT.Debugger(importTemplate)

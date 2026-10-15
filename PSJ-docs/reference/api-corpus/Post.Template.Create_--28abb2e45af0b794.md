# Post.Template.Create()

Post.Template.Create()

Description​

Create a new template.

Syntax​

Post.Template.Create(...)

Macro: CreateTemplate

Ribbon: Post » Template » Create

Inputs​

strName​

A String specifying the template name.

The default value is "NewTemplate".

strComment​

A String specifying comments for the created template.

The default value is "".

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

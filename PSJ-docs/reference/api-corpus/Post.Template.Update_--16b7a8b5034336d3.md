# Post.Template.Update()

Post.Template.Update()

Description​

Update a specified template.

Syntax​

Post.Template.Update(...)

Macro: UpdateTemplate

Ribbon: Post » Template » Update

Inputs​

strName​

A String specifying the template name to be updated.

This is a required input.

strComment​

A String specifying the comment when updating the template.

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

# Updated the created template
Post.Template.Update(strName="Template_1", strComment="Update View Point ")
Post.Template.AttachViewPoint(strName="Template_1", dlCenter=[0.003, 0.005, 0.001], dScaleFactor=0.00753137)

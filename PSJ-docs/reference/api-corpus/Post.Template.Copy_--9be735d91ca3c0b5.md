# Post.Template.Copy()

Post.Template.Copy()

Description​

Create a copy of the specified template.

Syntax​

Post.Template.Copy(...)

Macro: CopyTemplate

Ribbon: Post » Template » Copy

Inputs​

strCurrentTemplate​

A String specifying the name of the template that will create a copy.

This is a required input.

strNewTemplate​

A String specifying the name of the copied template.

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
Post.Template.Copy(strCurrentTemplate="Template_1", strNewTemplate="Template_2")

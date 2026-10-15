# Post.Template.Load()

Post.Template.Load()

Description​

Load the specified template in the template list to the current screen.

Syntax​

Post.Template.Load(...)

Macro: LoadTemplate

Ribbon: Post » Template » Load

Inputs​

strName​

A String specifying the name of template will be loaded.

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

# Load template
loadTemplate = Post.Template.Load(strName="Template_1")
JPT.Debugger(loadTemplate)

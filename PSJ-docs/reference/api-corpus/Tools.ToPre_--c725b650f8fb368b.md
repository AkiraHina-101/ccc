# Tools.ToPre()

Tools.ToPre()

Description​

Convert the model’s data and the related settings from an opening Post document to a new Pre document. All part names, setting item names and data of setting items in the model are preserved during conversion.

Syntax​

Tools.ToPre(...)

Macro: ToPre

Ribbon: Tools » ToPre

Inputs​

strName​

A String specifying the name of Pre document will be converted.

This is a required input.

ilOptions​

A List of Integer specifying the related settings will be converted with model.

0: Group

1: LBC

2: Connection

3: Coordinate

4: Property

The default value is [].

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\Post\\Static_Renkon.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)
# Convert to Pre
data = Tools.ToPre(strName="Static_Renkon", ilOptions=[0, 1, 2, 3, 4])
JPT.SetActiveDocumentByName("Static_Renkon",1)
JPT.Debugger(data)

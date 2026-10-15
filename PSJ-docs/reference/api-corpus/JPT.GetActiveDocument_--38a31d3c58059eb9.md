# JPT.GetActiveDocument()

JPT.GetActiveDocument()

Description​

Get information of active document.

Syntax​

JPT.GetActiveDocument()

Inputs​

This utility function does not require any input value.

Return Code​

A Document object specifying the information of document.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))
# Get information of active document
doc = GetActiveDocument()
JPT.Debugger(doc)

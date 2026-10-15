# JPT.GetOutputLog()

JPT.GetOutputLog()

Description​

Get the text existing on the Output window.

Syntax​

JPT.GetOutputLog()

Inputs​

This utility function does not require any input value.

Return Code​

A String containing all the text existing on the Output window.

Sample Code​

# Prepare model to write all text on Output log
Geometry.Part.Cube(strName="Cube_5", iPartColor=7463537)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7434735)
Geometry.Part.Cube(strName="Cube_7", iPartColor=14903267)
Geometry.Part.Cube(strName="Cube_8", iPartColor=15658599)
Geometry.Part.Cube(strName="Cube_9", iPartColor=7961077)
Geometry.Part.Cube(strName="Cube_10", iPartColor=7829501)
JPT.ViewFitToModel()

# Get the printed text in Output window
log = JPT.GetOutputLog()
JPT.Debugger(log)

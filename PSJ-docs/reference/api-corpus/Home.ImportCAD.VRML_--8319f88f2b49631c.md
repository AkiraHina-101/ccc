# Home.ImportCAD.VRML()

Home.ImportCAD.VRML()

Description​

Import a Virtual Reality Modeling Language file (*.wrl) to the Jupiter Database.

Syntax​

Home.ImportCAD.VRML(...)

Ribbon: Home » ImportCAD » VRML

Inputs​

strlPaths​

A List of String specifying a list of the Virtual Reality Modeling Language files (*.wrl files) which will be used for importing.

This is a required input.

iVRMLColorGroups​

An Integer specifying the option that using color information:
0: Do not use

1: Use color information

The default value is 0.

dScale​

A Double specifying the unit ratio imported from the file's unit into the document's unit.

The default value is 1.0.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Virtual Reality Modeling Language file (*.wrl file) is imported successfully.

False: The Virtual Reality Modeling Language file (*.wrl file) cannot be imported.

Sample Code​

imported_status = Home.ImportCAD.VRML(strlPaths=[JPT.GetProgramPath() +
                                                 "SampleData/CAD_Model/WRML/GrabCAD 2-SHIP.wrl"],
                                      iVRMLColorGroups=1,
                                      dScale=0.001)
JPT.Debugger(imported_status)

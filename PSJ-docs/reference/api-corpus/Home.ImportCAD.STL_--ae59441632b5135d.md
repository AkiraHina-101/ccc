# Home.ImportCAD.STL()

Home.ImportCAD.STL()

Description​

Import a Standard Tessellation Language file (*.stl) to the Jupiter Database.

Syntax​

Home.ImportCAD.STL(...)

Ribbon: Home » ImportCAD » STL

Inputs​

strlPath​

A List of String specifying a list of the Standard Tessellation Language files (*.stl files) which will be used for importing.

This is the required input.

dScale​

A Double specifying the unit ratio imported from the file's unit into the document's unit.

The default value is 0.001.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Standard Tessellation Language file (*.stl file) is imported successfully.

False: The Standard Tessellation Language file (*.stl file) cannot be imported.

Sample Code​

imported_status = Home.ImportCAD.STL(strlPaths=[JPT.GetProgramPath() +
                                                "SampleData/CAD_Model/STL/Macbook Pro 15.stl"],
                                     dScale=0.001)
JPT.Debugger(imported_status)

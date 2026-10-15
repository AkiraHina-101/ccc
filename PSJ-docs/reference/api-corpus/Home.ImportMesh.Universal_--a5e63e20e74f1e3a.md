# Home.ImportMesh.Universal()

Home.ImportMesh.Universal()

Description​

Import an Universal file (*.unv) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

Home.ImportMesh.Universal(...)

Ribbon: Home » ImportMesh » Universal

Inputs​

strPath​

A String specifying the path of the Universal file (*.unv file) which will be used for importing.

This is a required input.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Universal file (*.unv file) is imported successfully.

False: The Universal file (*.unv file) cannot be imported.

Sample Code​

import_status = Home.ImportMesh.Universal(strPath=JPT.GetProgramPath() + \
                                                  "SampleData/Mesh_Model/Universal/Exported_Universal_File_EXPORT_UNI.unv")
JPT.Debugger(import_status)

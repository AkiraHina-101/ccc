# Home.ImportMesh.Universal()

Home.ImportMesh.Universal()

Description​

Import an Universal file (*.unv) to the Jupiter Database (Mesh, boundary conditions, etc.).

Syntax​

Home.ImportMesh.Universal(...)

Macro: ImportUnv, ImportUniversalMesh

Ribbon: Home » ImportMesh » Universal

Inputs​

strlPaths​

A List of String specifying a list of the Universal files (*.unv file) which will be used for importing.

This is a required input.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Universal file (*.unv file) is imported successfully.

False: The Universal file (*.unv file) cannot be imported.

Sample Code​

from os import environ

unv_file_path = environ["Temp"] + "/TechnoStar/Exported_Universal_File_EXPORT_unv.bdf"

Geometry.Part.Cube(ilAxialNodes=[3, 3, 3])
Meshing.SolidMeshing(crlParts=[Part(1)], bTet10=True, 
                    dGradingFactor=1.0, 
                    dStretchLimit=0.1, 
                    iSpeedVsQual=1, 
                    bSafeMode=False, 
                    iParallel=8, 
                    bInternalMeshOnly=False, 
                    iPartColor=65280)

Home.EXPORT_UNIVERSAL(strFileName=unv_file_path, crlParts=[Part(1)])

JPT.CreateNewDocument()

import_status = Home.ImportMesh.Universal(strlPaths=[unv_file_path])

JPT.Debugger(import_status)

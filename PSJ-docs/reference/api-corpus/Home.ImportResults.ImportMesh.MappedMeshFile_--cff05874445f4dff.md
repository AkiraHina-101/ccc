# Home.ImportResults.ImportMesh.MappedMeshFile()

Home.ImportResults.ImportMesh.MappedMeshFile()

Description​

Import a mapped mesh file (*.dat) to the Jupiter Database as Post document to add result to the mesh.

Syntax​

Home.ImportResults.ImportMesh.MappedMeshFile(...)

Macro: ImportMappedMeshFileDat

Ribbon: Home » ImportResults » ImportMesh » MappedMeshFile

Inputs​

strPath​

A String specifying Mapped Mesh file path.

This is a required input.

iImportType​

An Integer specifying import type. For Mapped Mesh file, it is always set to 1.

The default value is 1.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division (By creating an edge between adjacent elements with an angle smaller than the specified value).

The default value is 60.0 (degree).

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division (By creating a vertex on adjacent edge elements with an angle larger than the specified value).

The default value is 60.0 (degree).

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The Mapped Mesh file is imported successfully.

False: The Mapped Mesh file cannot be imported.

Sample Code​

#Please set path to your sample mapped mesh file.
filepath="C:/Temp/SampleFrontISTR"

Home.ImportResults.ImportMesh.MappedMeshFile(filepath)

# Post.ImportResults.HDF5Mesh()

Post.ImportResults.HDF5Mesh()

Description​

Import Nastran HDF5Mesh file

Syntax​

Post.ImportResults.HDF5Mesh(strlFilePaths, iImportType=2, dFaceAngle=60.0, dEdgeAngle=60.0)

Ribbon: Post » ImportResults » HDF5Mesh

Inputs​

strlFilePaths​

A List of String specifying the list of the paths of the HDF5 files.

This is a required input.

iImportType​

An Integer specifying the import type.

0: Standard Nastran BDF - Import the BDF model geometry only.

1: Standard Nastran BDF by Property with 1D2D3D-Part - Import the BDF model geometry and material property. All material parts are applied to each part.

2: Standard Nastran BDF by Property with 1D-Edge,2D-Face,3D-Part - Import the BDF model geometry and material property. Parts are created for each material property. The 1D, 2D material properties are applied to edges or faces of a single part. 3D material properties are applied to each part. (Hollow 1D material properties are applied to each part.)

The default value is 2.

dFaceAngle​

A Double specifying the angle tolerance in order to determine the face division. Define a face by creating an edge between adjacent elements with an angle smaller than the specified value.

The default value is 60.0.

dEdgeAngle​

A Double specifying the angle tolerance in order to determine the edge division. Divide an edge by creating a vertex on adjacent edge elements with an angle larger than the specified value.

The default value is 60.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Post.ImportResults.HDF5Mesh("C:/Desktop/Hdf5Sample.h5")

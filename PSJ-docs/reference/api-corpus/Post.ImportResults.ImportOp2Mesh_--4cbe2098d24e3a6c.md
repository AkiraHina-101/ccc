# Post.ImportResults.ImportOp2Mesh()

Post.ImportResults.ImportOp2Mesh()

Description​

Import Nastran op2 mesh

Syntax​

Post.ImportResults.ImportOp2Mesh(strlFilePaths, iImportType=0, dFaceAngle=60.0, dEdgeAngle=60.0)

Ribbon: Post » ImportResults » ImportOp2Mesh

Inputs​

strlFilePaths​

A List of String specifying the file paths.

This is a required input.

iImportType​

An Integer specifying the import type.

The default value is 0.

dFaceAngle​

A Double specifying the face angle.

The default value is 60.0.

dEdgeAngle​

A Double specifying the edge angle.

The default value is 60.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Post.ImportResults.ImportOp2Mesh(strlFilePaths, iImportType=0, dFaceAngle=60.0, dEdgeAngle=60.0)

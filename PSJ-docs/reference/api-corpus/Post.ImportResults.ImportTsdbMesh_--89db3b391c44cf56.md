# Post.ImportResults.ImportTsdbMesh()

Post.ImportResults.ImportTsdbMesh()

Description​

Import tsdb mesh

Syntax​

Post.ImportResults.ImportTsdbMesh(strTsdbFilePath, strBtxFilePath, iImportType=1, dFaceAngle=60.0, dEdgeAngle=60.0)

Ribbon: Post » ImportResults » ImportTsdbMesh

Inputs​

strTsdbFilePath​

A String specifying the tsdb file path.

This is a required input.

strBtxFilePath​

A String specifying the btx file path.

This is a required input.

iImportType​

An Integer specifying the import type.

The default value is 1.

dFaceAngle​

A Double specifying the face angle.

The default value is 60.0.

dEdgeAngle​

A Double specifying the edge angle.

The default value is 60.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Post.ImportResults.ImportTsdbMesh(strTsdbFilePath, strBtxFilePath, iImportType=1, dFaceAngle=60.0, dEdgeAngle=60.0)

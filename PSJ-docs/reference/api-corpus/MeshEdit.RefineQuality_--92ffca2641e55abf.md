# MeshEdit.RefineQuality()

MeshEdit.RefineQuality()

Description​

Unknown Description

Syntax​

MeshEdit.RefineQuality(iMetric, crlFaces, crlElems, crlNodes)

Ribbon: MeshEdit » RefineQuality

Inputs​

iMetric​

An Integer specifying the metric.

This is a required input.

crlFaces​

A List of Cursor specifying the face.

This is a required input.

crlElems​

A List of Cursor specifying the element.

This is a required input.

crlNodes​

A List of Cursor specifying the node.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MeshEdit.RefineQuality(iMetric, crlFaces, crlElems, crlNodes)

# MMCCarACTools.ClearanceElement.Connect()

MMCCarACTools.ClearanceElement.Connect()

Description​

MMCCarACTools ClearanceElement Connect

Syntax​

MMCCarACTools.ClearanceElement.Connect(crlFaces, crlElems, iConnectionMethod)

Ribbon: MMCCarACTools » ClearanceElement » Connect

Inputs​

crlFaces​

A List of Cursor specifying the face.

This is a required input.

crlElems​

A List of Cursor specifying the element.

This is a required input.

iConnectionMethod​

An Integer specifying the connection method.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MMCCarACTools.ClearanceElement.Connect(crlFaces, crlElems, iConnectionMethod)

# HexModeling.Circular()

HexModeling.Circular()

Description​

Create Hexa mesh by revolving a surface

Syntax​

HexModeling.Circular(crlFaces=[], dAngle=360, dTol=0.0000001, iLayer=36, vecAxisPt=[0.0,0.0,0.0], vecAxisVect=[1.0,0.0,0.0], bInterfaceElem=False, bExtrusion=False, dTranslationExtrusion=0.0, dBDeleteOriginalParts=0.0)

Ribbon: HexModeling » Circular

Inputs​

crlFaces​

A List of Cursor specifying the face.

The default value is [].

dAngle​

A Double specifying the angle.

The default value is 360.

dTol​

A Double specifying the tolerance.

The default value is 0.0000001.

iLayer​

An Integer specifying the layer.

The default value is 36.

vecAxisPt​

A Vector specifying the axis point.

The default value is [0.0,0.0,0.0].

vecAxisVect​

A Vector specifying the axis vector.

The default value is [1.0,0.0,0.0].

bInterfaceElem​

A Boolean specifying the interface element.

The default value is False.

bExtrusion​

A Boolean specifying the extrusion.

The default value is False.

dTranslationExtrusion​

A Double specifying the translation extrusion.

The default value is 0.0.

dBDeleteOriginalParts​

A Double specifying the delete original parts.

The default value is 0.0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

HexModeling.Circular(crlFaces=[], dAngle=360, dTol=0.0000001, iLayer=36, vecAxisPt=[0.0,0.0,0.0], vecAxisVect=[1.0,0.0,0.0], bInterfaceElem=False, bExtrusion=False, dTranslationExtrusion=0.0, dBDeleteOriginalParts=0.0)

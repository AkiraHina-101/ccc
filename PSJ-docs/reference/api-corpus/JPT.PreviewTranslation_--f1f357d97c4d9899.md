# JPT.PreviewTranslation()

JPT.PreviewTranslation()

Description​

Show preview result of body translation.

Syntax​

JPT.PreviewTranslation(...)

Inputs​

DBodyVector​

A DBodyVector object or List of DBody objects storing the information of parts to be moved.

This is a required input.

dlTranslationVector​

A List of Double specifying the translation vector defining the direction and magnitude of the translation.

This is a required input.

iColor​

An Integer specifying the color of the previewed entity.

The default value is 255.

dTransparency​

A Double specifying the transparency of the previewed entity.

The range of dTransparency = [0.0, 1.0]

The default value is 0.5.

DCoord​

A DCoord object specifying Local Coordinate System.

The default value is None (Global Coordinate System).

Return Code​

This utility function does not have output value.

Sample Code​

# Clear Preview
JPT.ClearPreview()

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], strName="Cube_2", iPartColor=13259210)
Tools.Coordinates.ThreeNode(iOrder=-1, crlNodes=[Node(496, 578, 590)])

# Preview
color = JPT.ConvertRGBToJPTColor(255,255,87) #yellow
parts = JPT.GetAllParts()
coord = JPT.GetAllCoordinates()
JPT.PreviewTranslation(parts,[0.02,0.01,0.01],color,1,coord[0])
JPT.ViewFitToModel()

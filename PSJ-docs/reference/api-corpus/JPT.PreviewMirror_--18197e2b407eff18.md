# JPT.PreviewMirror()

JPT.PreviewMirror()

Description​

Show preview result of body mirror.

Syntax​

JPT.PreviewMirror(...)

Inputs​

DBodyVector​

A DBodyVector object or List of DBody objects storing the information of parts to be mirrored.

This is a required input.

veclPoint​

A List of TVector3D object specifying 3 node’s position to form a mirror plane.

This is a required input.

dOffset​

A Double specifying the offset value.

This is a required input.

iColor​

An Integer specifying the color of the previewed entity.

The default value is 255.

dTransparency​

A Double specifying the transparency of the previewed entity.

The range of dTransparency = [0.0, 1.0]

The default value is 0.5.

Return Code​

This utility function does not have output value.

Sample Code​

# Clear Preview
JPT.ClearPreview()

# Prepare model
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=13259210)

# Preview
color = JPT.ConvertRGBToJPTColor(255,255,87) #yellow
parts = JPT.GetAllParts()
JPT.PreviewMirror(parts,[[0.0055,0.01,0.0055],[0.005,0.01,0.0044],[0.0044,0.01,0.0044]],0,color,0.8)
JPT.ViewFitToModel()

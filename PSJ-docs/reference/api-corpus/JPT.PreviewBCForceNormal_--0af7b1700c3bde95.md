# JPT.PreviewBCForceNormal()

JPT.PreviewBCForceNormal()

Description​

Show preview result of applying normal force on target.

Syntax​

JPT.PreviewBCForceNormal(...)

Inputs​

DElemForNormal​

A DElem object specifying 2D element information.

This element will be used to calculate normal vector for force direction.

This is a required input.

DItemVector​

A DItemVector object or List of DItem objects storing the information of targets for applying force.

This targets can be Face, Edge or Node.

This is a required input.

iArrowDir​

An Integer specifying the display arrow direction.
0: Start at node.

1: End at node.

The default value is 0.

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

# Preview
color = JPT.ConvertRGBToJPTColor(255,255,87) #yellow
selFace = JPT.GetEntitiesByID(JPT.DItemType.FACE, 26)
normalElem = JPT.GetEntitiesByID(JPT.DItemType.ELEM, 1065)
normalElem = JPT.CastDItemToDElem(normalElem[0])
JPT.PreviewBCForceNormal(normalElem,selFace,0,color,0.8)
JPT.ViewFitToModel()

# Assemble.GeneralLayer()

Assemble.GeneralLayer()

Description​

Create a new face inside the part by offsetting a preceding face.

Syntax​

Assemble.GeneralLayer(...)

Ribbon: Assemble » General Layer

Inputs​

crlFaces​

A List of Cursor specifying the list of faces to make layer.

This is the require input.

dWidth​

A Double specifying the offset amount for the surface to be created.

The default value is 1.0.

iLayer​

An Integer specifying the number of layers to be created.

The default value is 1.

bSeparatePart​

A Boolean enable/disable the option that new layer part will be created in a different body. Boundary layer part and original part have a shared surface.

The default value is False.

bForceStitchToSide​

A Boolean enable/disable conform to outside of the model geometry and offset.

The default value is False.

bSmoothingEdge​

A Boolean enabledisable prepare the edge of the offset face.

The default value is False.

bNoImprint​

A Boolean specifying whether or not imprint the adjacent surface after the creation of the offset face..

The default value is False.

bWidthOnSurface​

A Boolean specifying whether or not interpreted as the amount of offsets along the shape of the model plane.

The default value is False.

bMakeHexa​

A Boolean specifying whether or not the make hexa element between layer face and boundary face.

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

creating_status = Assemble.GeneralLayer(crlFaces=[Face(26)])

JPT.Debugger(creating_status)

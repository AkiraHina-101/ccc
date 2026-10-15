# Assemble.FullLayer()

Assemble.FullLayer()

Description​

Create a layer (PRISM6 part) with the entire surface mesh of the part offset inward.

Syntax​

Assemble.FullLayer(...)

Ribbon: Assemble » Full Layer

Inputs​

crPart​

A Cursor specifying the target part for create new layers.

This is a required input.

dLayerWidth​

A Double specifying the layer width.

The default value is 1.0.

iLayer​

An Integer specifying number of layer will be created.

The default value is 1.

bUsePyramid​

A Boolean enable/disable option that create a pyramid element to tie the layer parts and the internal parts .

The default value is False.

Return Code​

A Boolean specifying whether the function is executed correctly or not:

True: The function is executed without any problems.

False: The function cannot be executed.

Sample Code​

cube = Geometry.Part.Cube()
flag = Assemble.FullLayer(crPart=cube)
JPT.Debugger(flag)

# Assembly.RightClick.AddToReference()

Assembly.RightClick.AddToReference()

Description​

Add the current part to its Reference and use the added one as the current reference part.

Syntax​

Assembly.RightClick.AddToReference(...)

Ribbon: Assembly » Right Click » Add To Reference

Inputs​

crSrcPart​

A Cursor specifying the source part which will be become reference for destination part.

This is a required input.

crDestPart​

A Cursor specifying the destination part.

This is a required input.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

adding_status = Assembly.RightClick.AddToReference(crSrcPart=Part(1), 
                                                   crDestPart=Part(1))

JPT.Debugger(adding_status)

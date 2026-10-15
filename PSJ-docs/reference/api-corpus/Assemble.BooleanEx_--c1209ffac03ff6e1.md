# Assemble.BooleanEx()

Assemble.BooleanEx()

Description​

Conduct a Boolean operation on selected bodies.

Syntax​

Assemble.BooleanEx(...)

Ribbon: Assemble » Boolean

Inputs​

crlTargetsParts​

A List of Cursor specifying the target parts for boolean.

This is a required input.

strNameSuffix​

A String specifying the target parts suffix name for after boolean.

This is a required input.

iBooleanType​

An Integer specifying the boolean operation type.

The default value is 0.

bLeaveOriginalPart​

A Boolean enable/disalbe the option that keep original parts.

The default value is False.

bImprintCrossLine​

A Boolean enable/disalbe the option that imprint cross line on original parts.

The default value is False.

iTargetPart​

An Integer specifying the index of keep body.

The default value is 0.

Return Code​

A Cursor of body if success, or None if fail.

Sample Code​

cube1 = Geometry.Part.Cube(iPartColor=4934581)
cube2 = Geometry.Part.Cube(dlOrigin=[0.005, 0.005, 0.005], 
                           strName="Cube_2", 
                           iPartColor=6215639)

boolean_status = Assemble.BooleanEx([cube1, cube2], 
                                    iTargetPart=1)

JPT.Debugger(boolean_status)

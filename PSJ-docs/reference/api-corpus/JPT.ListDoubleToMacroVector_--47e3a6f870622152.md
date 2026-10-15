# JPT.ListDoubleToMacroVector()

JPT.ListDoubleToMacroVector()

Description​

Convert a List of 3 Double values to a Vector3D (Macro string type).

Syntax​

JPT.ListDoubleToMacroVector(doubleValue1, doubleValue2, doubleValue3)

Inputs​

doubleValue1​

A Double specifying the first value which will be used for converting.

This is a required input.

doubleValue2​

A Double specifying the second value which will be used for converting.

This is a required input.

doubleValue3​

A Double specifying the third value which will be used for converting.

This is a required input.

Return Code​

A String specifying the converted Vector3D (Macro string type).

Sample Code​

# Convert a list of 3 double values to a vector3d (Macro string type)
inputValue1 = 0.001
inputValue2 = 2.1
inputValue3 = 5.5
# Return a string object with value = [0.001,2.1,5.5]
JPT.Debugger(JPT.ListDoubleToMacroVector(inputValue1, inputValue2, inputValue3))

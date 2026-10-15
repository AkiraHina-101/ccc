# JPT.SetSelectMethod()

JPT.SetSelectMethod()

Description​

Change the selection method in Jupiter to the specified one.

Syntax​

JPT.SetSelectMethod(selectMethodType)

Inputs​

selectMethodType​

An Enum specifying the SelectMethodType describing the selection method.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Select method to Body selection
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_BODY)

# Select method to Face selection
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_FACE)

# Select method to Edge selection
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_EDGE)

# Select method to Node selection
JPT.SetSelectMethod(JPT.SelectMethodType.SELMTD_NODE)

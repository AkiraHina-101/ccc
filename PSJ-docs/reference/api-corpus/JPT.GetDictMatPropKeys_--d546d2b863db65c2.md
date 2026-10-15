# JPT.GetDictMatPropKeys()

JPT.GetDictMatPropKeys()

Description​

Get list keys from dictMatProps.

Syntax​

JPT.GetDictMatPropKeys(dictMatProps)

Inputs​

dictMatProps​

A Dictionary specifying the dictMatProps.

This is a required input.

Return Code​

A List of String specifying the keys of dictMatProps.

Sample Code​

# Get 1st material in the library materials
mat0 = JPT.GetAllLibraryMaterials()[0]

# Get & print dicMatProps
dict1 = mat0.dictMatProps
pprint(dict1)

# JPT.GetSelectedElemEdges()

JPT.GetSelectedElemEdges()

Description​

Get all information of the selected element edges.

Syntax​

JPT.GetSelectedElemEdges()

Inputs​

This utility function does not require any input value.

Return Code​

A DItemPairVector object or List of DItemPair objects containing information of the selected element edges under DItem format.

Sample Code​

# Get the information of the selected element edges.
# This function returns a list of DItemPair objects or DItemPairVetor object storing
# information of element edges in DItem format
# Element edges are not actual entity but defined by connection of 2 nodes.

listSelElemEdges = JPT.GetSelectedElemEdges()
for i in listSelElemEdges:
    print ('1st Node: {}'.format(i.firstDItem.id))
    print ('2nd Node: {}'.format(i.secondDItem.id))

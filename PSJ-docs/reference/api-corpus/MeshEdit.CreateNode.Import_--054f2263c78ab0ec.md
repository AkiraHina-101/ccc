# MeshEdit.CreateNode.Import()

MeshEdit.CreateNode.Import()

Description​

Create node by importing CSV file.

Syntax​

MeshEdit.CreateNode.Import(...)

Macro: CreateNodeImport

Ribbon: MeshEdit » CreateNode » Import

Inputs​

strFilePath​

A String specifying the path of CSV file.

This is a required input.

Return Code​

A List of Cursor specifying the created floating nodes.

Sample Code​

# Put your sample CSV file
csvFile = "C:/temp/NodeData.csv"

# Import nodes
newNode = MeshEdit.CreateNode.Import(strFilePath = csvFile)
JPT.Debugger(newNode) # for checking the return value

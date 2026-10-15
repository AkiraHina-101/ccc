# JPT.GetAllFieldData()

JPT.GetAllFieldData()

Description​

Get all the field data inside a document.

Syntax​

JPT.GetAllFieldData()

Inputs​

This utility function does not require any input value.

Return Code​

A FieldDataVector object or List of DFieldData objects containing all the information of all the existing field data.

Sample Code​

# Prepare data
BoundaryConditions.FieldData(
    strName="TimeTable",
    iType=2,
    ilSheet=[4, 2, 0, 0, 0.1, 10, 5, 50, 10, 70])

BoundaryConditions.FieldData(
    strName="FreqTable",
    iType=4,
    ilSheet=[3, 2, 1000, 100, 2000, 110, 3000, 120])

BoundaryConditions.FieldData(
    strName="TemparatureTable",
    iType=7,
    ilSheet=[3, 2, 0, 0.1, 100, 0.3, 300, 0.5])

# Get the information of all existing field data
listDFieldData = JPT.GetAllFieldData()
JPT.Debugger(listDFieldData)

# Print all the related information of each existing field data in list
for fieldData in listDFieldData:
    JPT.Debugger(fieldData)

# Get property from part ID

Get property from part ID

🎯 Introduction​

In this tutorial, you'll learn how to get property from part's ID:

Create material for property.

Create 2 Shell properties: first is for first cube part, second is for second and third cube parts.

Get list of all parts and 2D Shell properties in current model.

Define a function to get property from ID of part.

Get property from part ID. Display property ID, property name, part ID, part name corresponding at Python API window.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create 3 cube parts
cube1 = Geometry.Part.Cube(iPartColor=12999622)
cube2 = Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], dlLength=[0.02, 0.01, 0.01], strName="Cube_2", iPartColor=5093709)
cube3 = Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], dlLength=[0.03, 0.01, 0.01], strName="Cube_3", iPartColor=6118877)

# Fit view of model on display view
JPT.ViewFitToModel()

# Create material
Properties.Material.Add("Structural_Steel", [Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])

# Create 2 Shell properties. First is for Cube1 part. Second is for Cube2 and Cube3 parts
Properties.Shell(strName="Shell Property 1 for Cube1", iPropertyId=1, dThickness=0.005, crlTargets=[cube1],
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1) )
Properties.Shell(strName="Shell Property 2 for Cube2-3", iPropertyId=2, dThickness=0.01, crlTargets=[cube2, cube3],
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1) )

# Get list of all parts and 2D Shell properties in current model
listPart = JPT.GetAllParts()
listProp = JPT.GetAllByType(JPT.DItemType.PROPERTY_2D_SHELL)

# Define a function to get property from ID of part
def GetPropertyFromPartID(partID):
    for prop in listProp:
        listAssosicatedPart = prop.targets
        for assoPart in listAssosicatedPart:
            if assoPart.id == partID:
                return prop

# Get property from ID of part by looping through each part of all parts list
# Display part name, property ID, property name for each part at Python API window
for part in listPart:
    foundProperty = GetPropertyFromPartID(part.id)
    print("Property ID: {} | Property Name: {} | Part ID: {} | Part Name: {} "
    .format(foundProperty.id,foundProperty.name,part.id,part.name))

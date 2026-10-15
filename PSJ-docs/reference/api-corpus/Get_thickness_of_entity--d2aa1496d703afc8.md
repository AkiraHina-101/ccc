# Get thickness of entity

Get thickness of entity

🎯 Introduction​

In this tutorial, you'll learn how to get thickness from entity (body/face/element):

Get list of all 2D elements from face ID 52.

Create material for property.

Create 3 Shell properties with different thickness values.

Get thickness from entity's ID.

📖 Tutorial​

# Clear the log message in Python API window
JPT.ClearLog()

# Create 2 cube parts
cube1 = Geometry.Part.Cube(iPartColor=12999622)
cube2 = Geometry.Part.Cube(dlOrigin=[0.015, 0.0, 0.0], strName="Cube_2", iPartColor=5093709)

# Fit view of model on display view.
JPT.ViewFitToModel()

# Get list of all 2D elements from face ID 52
elem_from_FaceID52 = MainWindow.RightClick.AssociatedPick(crlInput=[Face(52)], strTarget="Elem")

# Create material
Properties.Material.Add("Copper_Alloy", [Density([(DENSITY, 8.3e-09)]), Elastic([(YOUNGS_MODULUS, 110000.0),
    (POISSONS_RATIO, 0.34)])])

############ Create 3 Shell properties with different thickness values ############
# First Shell property is for Cube1
Properties.Shell(strName="Shell Property 1 for Cube1", iPropertyId=1, dThickness=0.005,
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), crlTargets=[cube1])

# Second Shell property is for Face ID 47,48,49,50,51
Properties.Shell(strName="Shell Property 2 for Face ID 47-51", iPropertyId=2, dThickness=0.008,
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), crlTargets=[Face(47, 48, 49, 50, 51)])

# Third Shell property is for all 2D elements of Face ID 52
Properties.Shell(strName="Shell Property 3 for all 2D elements of Face ID 52", iPropertyId=3, dThickness=0.012,
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1), crlTargets=elem_from_FaceID52)

######################## Get Thickness from Entity ########################
# Get Thickness from ID of 'Body' Entity
dThicknessBody_ID1 = JPT.GetThicknessOfEntity(JPT.DItemType.BODY, 1)
print("Thickness of 'Body' Entity ID 1: {}".format(dThicknessBody_ID1))

#Get Thickness from ID of 'Face' Entity
dThicknessFace_ID49 = JPT.GetThicknessOfEntity(JPT.DItemType.FACE, 49)
print("Thickness of 'Face' Entity ID 49: {}".format(dThicknessFace_ID49))

#Get Thickness from ID of 'Element' Entity
dThicknessElem_ID1477 = JPT.GetThicknessOfEntity(JPT.DItemType.ELEM, 1477)
print("Thickness of 2D 'Element' Entity ID 1477: {}".format(dThicknessElem_ID1477))

dThicknessElem_ID2114 = JPT.GetThicknessOfEntity(JPT.DItemType.ELEM, 2114)
print("Thickness of 2D 'Element' Entity ID 2114: {}".format(dThicknessElem_ID2114))

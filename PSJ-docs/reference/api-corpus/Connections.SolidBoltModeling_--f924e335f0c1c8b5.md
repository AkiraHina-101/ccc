# Connections.SolidBoltModeling()

Connections.SolidBoltModeling()

Description​

Create a solid bolt composed of hexa elements.

Syntax​

Connections.SolidBoltModeling(...)

Macro:

Ribbon: Connections » SolidBoltModeling

Inputs​

crlTopTargets​

A List of Cursor specifying top side edges or faces.

This is a required input.

crlBottomTargets​

A List of Cursor specifying bottom side edges or faces.

This is a required input.

strName​

A String specifying the name of created bolt connection.

The default value is "Bolt_1".

iBoltType​

An Integer specifying bolt type.

0: Bolt - Nut

1: Bolt

The default value is 0.

dMaxHeight​

A Double specifying the maximum length of bolt hole where a new bolt is created.

The default value is 100.

dMaxDiameter​

A Double specifying the maximum diameter to search bolt hole.

The default value is 36.

dMinDiameter​

A Double specifying the minimum diameter to search bolt hole.

The default value is 3.

bPretension​

A Boolean specifying whether or not create pretension setting.

The default value is False.

iSolverType​

An Integer specifying solver type.

0: All

1: Abaqus

The default value is 0.

iForceUnit​

An Integer specifying unit of pretension force.

0: N

1: mN

2: kN

3: kgf

4: lbf

5: tf

The default value is 0.

dPretensionValue​

A Double specifying the value of pretension force.

The default value is 100.

iDirection​

An Integer specifying force direction.

0: UX

1: UY

2: UZ

The default value is 0.

crCoord​

A Cursor specifying coordinate for force direction.

The default value is None.

bFixLength​

A Boolean specifying whether or not create fixed length setting.

The default value is False.

dDiameter​

A Double specifying nominal thread diameter of the created bolt.

The default value is 4.

dBoltHeadWidthAcrossFlat​

A Double specifying the bolt head diagonal distance.

The default value is 7.

dBoltHeadHeight​

A Double specifying bolt head height.

The default value is 2.8.

dShaftLength​

A Double specifying bolt shaft length.

The default value is 40.

dPitch​

A Double specifying bolt thread length.

The default value is 5.

iTopHeadHeightDivision​

An Integer specifying the number of mesh divisions in the top side of bolt head height direction.

The default value is 1.

iTopHeadRadialDivision​

An Integer specifying the number of mesh divisions in the radial direction of the bolt head circumference.

The default value is 1.

dNutWidthAcrossFlat​

A Double specifying the bolt nut diagonal distance.

The default value is 7.

dNutHeight​

A Double specifying bolt nut height.

The default value is 3.2.

iBotHeadHeightDivision​

An Integer specifying the number of mesh divisions in the bolt head height direction.

The default value is 1.

iBotHeadRadialDivision​

An Integer specifying the number of mesh divisions in the radial direction of the top side of bolt head circumference.

The default value is 1.

Return Code​

A List of Cursor specifying created solid bolt parts.

Sample Code​

##################
# Prepare model
##################

# Create a cube
cube=Geometry.Part.Cube(
    ilAxialNodes=[3, 3, 3], 
    strName="Cube_3", 
    iPartColor=6409934)

# Get top face
maxface=JPT.Exec(f'FindFacesInPart({cube},"MaxZFACE")')

# Imprint circle on the top face.
Geometry.Edge.Circle(
    veclPositions=[[0.005, 0.005, 0.01]], 
    crlTargetFace=maxface, 
    dOutRadius=2.0, 
    iNoOfDiv=8)

# Get newly created edge - > top edge.
edge1=JPT.GetMaxIDEntity(JPT.DItemType.EDGE)

# Delete newly created face.
face=JPT.GetMaxIDEntity(JPT.DItemType.FACE)
JPT.Exec(f'DeleteFace([{face}], 1)')

# Get bottom face
minface=JPT.Exec(f'FindFacesInPart({cube},"MinZFACE")')

# Imprint circle on the bottom face.
Geometry.Edge.Circle(
    veclPositions=[[0.005, 0.005, 0.0]], 
    crlTargetFace=minface, 
    dOutRadius=2.0, 
    iNoOfDiv=8)
# Get newly created edge - > bottom edge.
edge2=JPT.GetMaxIDEntity(JPT.DItemType.EDGE)

# Delete newly created face.
face=JPT.GetMaxIDEntity(JPT.DItemType.FACE)
JPT.Exec(f'DeleteFace([{face}], 1)')

# Create side face of bolt hole.
Geometry.Face.Edges(crlEdges=[Edge(edge1, edge2)])

# Create a solid bolt at the hole.
Connections.SolidBoltModeling(
    crlTopTargets=[Edge(edge1)], 
    crlBottomTargets=[Edge(edge2)], 
    strName="Bolt_1", iBoltType=1, 
    dMaxHeight=10,     
    dDiameter=3, 
    dBoltHeadWidthAcrossFlat=5.5,
    dBoltHeadHeight=2, 
    dShaftLength=10, 
    dPitch=1, 
    iTopHeadHeightDivision=2,
    iTopHeadRadialDivision=2)

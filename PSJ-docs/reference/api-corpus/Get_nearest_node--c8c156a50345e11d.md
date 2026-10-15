# Get nearest node

Get nearest node

🎯 Introduction​

In this tutorial, you'll learn how to get nearest node ID from a floating node in the model:

Define a function to get distance between 2 nodes.

Get node object from floating node by user-defined ID 489.

Get list of all nodes in current model.

Looping through all nodes (except floatingNode) in model, find node has minimum distance with floating node.

Display nearest node's ID with floating node 489 at Python API window.

📖 Tutorial​

# Import 'sys' module of Python
import sys

# Clear the log message in Python API window
JPT.ClearLog()

# Create sample model (a cube and a floating node with ID=489)
Geometry.Part.Cube()
MeshEdit.CreateNode.Absolute(veclNodeCoord=[[0.0101, 0.0055, 0.0055]], ilNewNodeID=[489])

# Fit view of model on display view
JPT.ViewFitToModel()

# Define a function to measure distance between 2 nodes
def distance_between_two_node(one,two) :
    return (((two.x-one.x)**2)+((two.y-one.y)**2)+((two.z-one.z)**2))**(1/2)

# Get node object from floating node object by ID, convert DItem to DNode
idFloatingNode = 489
itemNode = JPT.GetEntitiesByID(JPT.DItemType.NODE, idFloatingNode)
floatingNode = JPT.CastDItemToDNode(itemNode[0])

# Get list of all nodes in current model
all_nodes = JPT.GetAllNodes()

# Looping through all nodes (except floatingNode) in current model
# Check to find node has minimum distance with floating node
min = sys.float_info.max
for node in all_nodes:
    if node.id == floatingNode.id: continue
    dis = distance_between_two_node(node.pos, floatingNode.pos)
    if dis < min:
        min = dis
        nearestNode = node

# Display nearest node's ID at Python API window
print("ID of nearest node with floating node is: {}".format(nearestNode.id))

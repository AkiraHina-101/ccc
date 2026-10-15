# Plot model info using matplotlib

Plot model info using matplotlib

🎯 Introduction​

In this tutorial, you'll learn how to plot models' information (number of nodes, elements, edges, faces, etc.)
using matplotlib library.:

Read part name, number of faces, edges, elements and nodes from all parts.

Plot the above information to a bar chart or line graph for comparison.
This plot can be exported to a picture file and import into MS PowerPoint automatically by PSJ.

📖 Tutorial​

Bar chart

Line graph

# Encoding for Japanese
# coding: cp932

# Clear the log message in Python API window
JPT.ClearLog()

# Make 4 sample models (if you already had a model opened, ignore the below code)
Geometry.Part.Cube(ilAxialNodes=[90, 70, 50])
Geometry.Part.Cylinder(dlOrigin=[0.03, 0.0, 0.0], dTopOuterRadius=0.005, dBottomOuterRadius=0.005, dHeight=0.03,
    iCircularNodes=100, iAxialNodes=300, iPartColor=6409934)
Geometry.Part.Sphere(dlOrigin=[0.06, 0.0, 0.0], iLatitudeDivisions=100, iLongitudeDivisions=400,
    iPartColor=13259210)
Geometry.Part.Torus(dlOrigin=[0.12, 0.0, 0.0], iCircumNodes=100, iRingNodes=300, iPartColor=7697908)

#############################################################################################
#################################### Start the main code ####################################
#############################################################################################

import numpy as np
import matplotlib.pyplot as plt

def auto_label(rects):
    """
    Attach a text label above each bar in *rects*, displaying its height.
    """
    for rect in rects:
        ax.annotate('{}'.format(rect.get_height()), xy = (rect.get_x() + rect.get_width() / 2, rect.get_height()),
                    xytext = (0, 3), textcoords = "offset points", ha = "center", va = "center", size = 8)

# Start plotting with matplotlib
labels = []
part_info = []
for part in JPT.GetAllParts():
    labels.append(part.name)
    part_info.append([part.name, len(part.faces), len(part.edges), len(part.elems), len(part.nodes)])
x = np.arange(len(labels))
fig, ax = plt.subplots(figsize = (8, 6))
ax.set_ylabel("Total values")
ax.set_title("Comparision between parts existing on the model")
ax.set_xticks(x)
ax.set_xticklabels(labels, rotation = 'vertical')
ax.autoscale(axis="both")
for i in range(len(part_info)):
    rect_1 = ax.bar(x[i], part_info[i][3], 0.3, color = "magenta", label = part_info[i][0])
    auto_label(rect_1)
    rect_2 = ax.bar(x[i], part_info[i][4], 0.3, color = "gold", label = part_info[i][0])
    auto_label(rect_2)
ax.legend((rect_1, rect_2),
          ("Number of elements", "Number of nodes"),
          bbox_to_anchor = (1.05, 1),
          loc = "upper left",
          fancybox = True,
          framealpha = 1,
          shadow = True,
          borderpad = 1)
fig.tight_layout()
plt.show()

# Encoding for Japanese
# coding: cp932

# Clear the log message in Python API window
JPT.ClearLog()

# Make 4 sample models (if you already had a model opened, ignore the below code)
Geometry.Part.Cube(ilAxialNodes=[90, 70, 50])
Geometry.Part.Cylinder(dlOrigin=[0.03, 0.0, 0.0], dTopOuterRadius=0.005, dBottomOuterRadius=0.005, dHeight=0.03,
    iCircularNodes=100, iAxialNodes=300, iPartColor=6409934)
Geometry.Part.Sphere(dlOrigin=[0.06, 0.0, 0.0], iLatitudeDivisions=100, iLongitudeDivisions=400,
    iPartColor=13259210)
Geometry.Part.Torus(dlOrigin=[0.12, 0.0, 0.0], iCircumNodes=100, iRingNodes=300, iPartColor=7697908)

#############################################################################################
#################################### Start the main code ####################################
#############################################################################################

import numpy as np
import matplotlib.pyplot as plt

# Start plotting with matplotlib
labels = []
part_info = []
for part in JPT.GetAllParts():
    labels.append(part.name)
    part_info.append([part.name, len(part.faces), len(part.edges), len(part.elems), len(part.nodes)])
x = np.arange(len(labels))
fig, ax = plt.subplots(figsize=[10, 8])
ax.set_ylabel("Total values")
ax.set_title("Comparision between parts existing on the model")
ax.set_xticks(x)
ax.set_xticklabels(labels, rotation = 'vertical')
y_elem = []
y_node = []
for i in range(len(part_info)):
    y_elem.append(part_info[i][3])
    y_node.append(part_info[i][4])
line_1 = ax.plot(x, y_elem, marker='o', color = "magenta", label='Number of elements')
line_2 = ax.plot(x, y_node, marker='x', color = "gold", label='Number of nodes')
for i in range(len(y_elem)):
    ax.annotate(y_elem[i], (x[i], y_elem[i]), size=8)
    ax.annotate(y_node[i], (x[i], y_node[i]), size=8)
ax.legend(['Number of elements', 'Number of nodes'],
          bbox_to_anchor = (1.05, 1),
          loc = "upper left",
          fancybox = True,
          framealpha = 1,
          shadow = True,
          borderaxespad=0.,
          borderpad = 1)
plt.gcf().subplots_adjust(right=0.75)
plt.show()

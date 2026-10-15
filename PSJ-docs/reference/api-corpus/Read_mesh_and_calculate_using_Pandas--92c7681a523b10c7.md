# Read mesh and calculate using Pandas

Read mesh and calculate using Pandas

🎯 Introduction​

In this tutorial, you'll learn how to use Pandas to do calculation with meshed model:

Read mesh information of all parts.

Get area for each element in all parts.

Finally, export the results to MS Excel file using Pandas (each part name in separate sheet).

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

# Clear the log message in Python API window
JPT.ClearLog()

# Make 4 sample models (if you already had a model opened, ignore the below code)
Geometry.Part.Cube(ilAxialNodes=[9, 7, 5])
Geometry.Part.Cylinder(dlOrigin=[0.03, 0.0, 0.0], dTopOuterRadius=0.005, dBottomOuterRadius=0.005, dHeight=0.03,
    iCircularNodes=10, iAxialNodes=300, iPartColor=6409934)
Geometry.Part.Sphere(dlOrigin=[0.06, 0.0, 0.0], iLatitudeDivisions=100, iLongitudeDivisions=40,
    iPartColor=13259210)
Geometry.Part.Torus(dlOrigin=[0.12, 0.0, 0.0], iCircumNodes=100, iRingNodes=30, iPartColor=7697908)

# Change this location to your folder
xlsx_file = "D:/output.xlsx"

#############################################################################################
#################################### Start the main code ####################################
#############################################################################################

import JPT
import pandas as pd
import os

shell_elem_type = ["ELEMTYPE_TRI3",
                   "ELEMTYPE_QUAD4",
                   "ELEMTYPE_QUAD8",
                   "ELEMTYPE_TRI6"]
solid_elem_type = ["ELEMTYPE_HEX8",
                   "ELEMTYPE_HEX20",
                   "ELEMTYPE_PRISM6",
                   "ELEMTYPE_PRISM15",
                   "ELEMTYPE_TET4",
                   "ELEMTYPE_TET10"]

shell_elem_area = {}
solid_elem = []
count = 0
print("Exporting the shell area for each element of shell parts ...")

JPT.DisableOutputMessage()
for part in JPT.GetAllParts():
    df = pd.DataFrame()
    elem_id_list = []
    elem_area_list = []
    check_solid = False
    for elem in part.elems:
        if str(elem.type).strip() in shell_elem_type:
            elem_id_list.append(elem.id)
            elem_area_list.append(float(JPT.Exec('measure_area_elem([11:{}], 10)'.format(elem.id))) * 1000000)
        elif str(elem.type).strip() in solid_elem_type:
            solid_elem.append(part.name)
            check_solid = True
            break
    if check_solid == False:
        df["Elem ID"] = elem_id_list
        df["Elem Area (mm2)"] = elem_area_list
        shell_elem_area.update({part.name: df})
        count += 1
JPT.EnableOutputMessage()

if count > 0:
    writer = pd.ExcelWriter(xlsx_file, engine='xlsxwriter')
    for key in shell_elem_area.keys():
        shell_elem_area[key].to_excel(writer, sheet_name = key, index = False)
    writer.save()
    writer.close()
    print("The exportation process is finished!")
else:
    print("Shell parts are not exist on this model")

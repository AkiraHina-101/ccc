# Solving plane stress problem

Solving plane stress problem

This tutorial demonstrates how to create a model and setting boundary conditions for plan stress problem by using a pre-defined template of PSJ-Command/Jupiter's Macro.
After that, using TS-SunShine to solve the plane stress problem exporting from Jupiter.
It will also integrates the PSJ-Command/Jupiter's Macro to a customized UI dialog by using GUI Command Builder.

In this tutorial, you’ll learn

How to get and make use of the PSJ-Command/Jupiter's Macro.

Implement the PSJ-Command/Jupiter's Macro to a general Python script for the automation process.

Call TS-SunShine to solve the exported file from Jupiter.

Open powerpoint and put the outputted values to powerpoint to create a report.

Creat a dialog by using GUI Command Builder.

Integrate the user script in (2.) to the created dialog in (3.) to make a custom UI function.

Add the created custom UI function in (4.) to Jupiter's ribbon and use it.

0. Overview​

About this dialog: you will make an UI dialog to integrate the customized PSJ-Command/Jupiter's Macro for the automation process.

After inputting values and clicking on the Apply/OK button, user can get the report containing the result of the created model.

In general, below are the steps that you will follow:

Get PSJ-Command or Macro: Executing available functions in Jupiter to get the respective PSJ-Command or Macro.

Create DEF function in Python: Combining PSJ-Command or Macro with Python based script in order to create a full user function.

Create User Interface (UI): Using GUI Command Builder to make an UI dialog connecting to the user function in (2.).

Implement: Registering the created UI dialog in (3.) to Jupiter.

1. Get PSJ-Command/Macro​

In this section, you can learn how to get the PSJ-Command/Macro from the executed function.

Within this example, you also can know how to implement the PSJ-Command/Macro of the following functions:

Geometry » Create Entity » Part » Cube function.

Geometry » Create Entity » Part » Cylinder function.

Assemble » Combination » Boolean function.

Geometry » Delete Entity » Face function.

Meshing » Surface Meshing function.

Properties » Material function.

Properties » Shell function.

Boundary Conditions » Constraints » Fixed Constraints function.

Boundary Conditions » Force » General function.

Analysis » TSSS function.

Undo command by using Ctrl + Z

Renaming part on the Assembly window.

1.1. Creating a cube​

Using Geometry » Create Entity » Part » Cube function to make a cube using as the base model of the plane stress model.

Then, you can see the created cube on the Jupiter's display window:

The process will be shown as below:

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

Geometry.Part.Cube(dlLength=[0.02, 0.001, 0.015], strName="planestress_model1", iPartColor=7531634)

CreateCube([0, 0, 0], [0.02, 0.001, 0.015], [10, 10, 10], "planestress_model1", 7531634, 0:0)

1.2. Creating a cylinder​

Using Geometry » Create Entity » Part » Cylinder function to make a cylinder for making a hole in the center of the plan stress model.

Then, you can see the created cylinder and the created cube on 1.1. on the Jupiter's display window:

The process will be shown as below:

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

Geometry.Part.Cylinder(dlOrigin=[0.01, -0.001, 0.0075], dTopRadius=0.001, dBottomRadius=0.001, dHeight=0.003, iPartColor=7697908)

CreateCylinderFrustum([0.01, -0.001, 0.0075], 0.001, 0.001, 0.003, 36, 10, "Cylinder_1", 7697908, 0:0)

1.3. Making a hole by using boolean​

Using Assemble » Combination » Boolean function and select Subtract option to make a hole in the center of the plane stress model.

This function will use the created cylinder (Step 1.1.) and the created cube (Step 1.2.).

After using this function, the creating model will be the same as below:

The process will be shown as below:

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

Assemble.BooleanEx([Part(1, 2)], strNameSuffix="", iBooleanType=1)

BooleanEx([3:1, 3:2], "", 1, 0, 0, 0)

1.4. Renaming the subtracted part​

On the Assembly window, Right Click on the subtracted part and select Rename option to change the name of the part after subtracting.

Then, you can see the new name of the subtracted part:

The process will be shown as below:

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

Assembly.RightClick.Rename(strNewName="planstress_model1", crItem=Part(1))

RenameItem("planstress_model1", 3:1)

1.5. Deleting all the unnecessary faces​

Using Geometry » Delete Entity » Delete Entity » Face function to create plane stress model by deleting all the unnecessary faces.

Then, you can see the model after deleling faces:

The process will be shown as below:

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

Geometry.DeleteEntity.Face([Face(31, 22, 25, 23, 26, 24)])

DeleteFaceCr([6:31, 6:22, 6:25, 6:23, 6:26, 6:24], 1)

1.6. Generating meshing for the plane stress part​

ヒント

Before executing Surface Meshing function, you should enable Show mesh line option. This operation will let you see the mesh line.

Using Meshing » Meshing » Surface Meshing function and select Tri3 option to create plane stress model by deleting all the unnecessary faces.

Then, you can see the model after meshing:

The process will be shown as below:

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

Meshing.SetMeshAttribute(crlPart=[Part(1)], surfaceMesh=SURFACE_MESH(dAvgElemSize=0.002, dMaxElemSize=0.003, dMinElemSize=0.0001, dGeomAngle=0.7853981634, dGeomMinSize=0.0001, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0))
Meshing.SurfaceMeshing(crlPart=[Part(1)], surfaceMesh=SURFACE_MESH(dAvgElemSize=0.002, dMaxElemSize=0.003, dMinElemSize=0.0001, dGeomAngle=0.7853981634, dGeomMinSize=0.0001, iPerformanceMode=1, dAutoMergeTinyFacesAngle=0.5235987756, bGeomApprox=True, iNextEntityOffsetId=0), iThreadNum=4)

MeshEditAdjustVertex([3:1])
SetMeshAttrib([3:1], {0.002, 0.003, 0.0001, 1, 0.7853981634, 0.0001, 1.25, 0.1, 0.1, 0.7, 0.5, 1, 3, 0, 0, 0, 0.5235987756, 1, 0, 0, 0, 0, 1, 0, 0, 10000000, 0, 0})
SurfaceMeshing2D([3:1], {0.002, 0.003, 0.0001, 1, 0.7853981634, 0.0001, 1.25, 0.1, 0.1, 0.7, 0.5, 1, 3, 0, 0, 0, 0.5235987756, 1, 0, 0, 0, 0, 1, 0, 0, 10000000, 0, 0}, 1, 0, 4, 1, 0, 65280)

注記

After executing Surface Meshing function, you need to convert the meshed model to first/second order.

First order

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

ElementConv_Surface([3:1], 0)

MeshEdit.SurfaceMesh(crlPart=[Part(1)], iType=0)

Second order

A corresponded PSJ-Command in the Python API window and Macro in the Macro window will be generated as below:

PSJ-Command

Macro

ElementConv_Surface([3:1], 1)

MeshEdit.SurfaceMesh(crlPart=[Part(1)])

1.7. Creating a material for applying​

1.8. Applying shell material on the created part​

1.9. Applying boundary conditions​

1.10. Exporting TS-SunShine file for solving​

2. Create DEF function in Python​

2.1. Step 1: Importing the important libraries​

2.2. Step 2: Preparing initial parameters​

2.3. Step 3: Preparing standard bolt sizes​

2.4. Step 4: Preparing def function for changing preview​

2.5. Step 5: Preparing a function to modify the output value of Assemble Faces function​

2.6. Step 6: Preparing the execution function​

3. Create User Interface (UI)​

3.1. Opening GUI Command Builder​

3.2. Creating a dialog with title and execution buttons​

3.3. Add components​

3.4. Exporting the created UI to python file​

3.5. Binding the created def from 2. to the create UI from 3.4​

4. Full code​

PSJ-Command

Macro

# coding: cp932
#*******************************************************************************
# COPYRIGHT NOTES
# ---------------
# This is a part of the PSJ Library
# Copyright (C) 2002-2020 Technostar Ltd.
# All rights reserved.
#
# This source code can be used, distributed or modified
# only under terms and conditions
# of the accompanying license agreement.
#*******************************************************************************
# PSJ GUI EXAMPLES
# ---------------------
# This example demonstrades how to apply PSJ on a simple problem
# such as plane stress problem
# Required: Sunshine license
#*******************************************************************************

import JPT
import re
import os
from pyjdg import *
import random
import ctypes
import subprocess

def cnvt_str_to_list(in_str: str) -> list:
    err_chars = r"/¥|^[]()"
    split_char = ","
    in_str = in_str.strip(err_chars)
    in_str = in_str.split(split_char)
    return in_str

def convert_to_dbody(macro_tcursor: str):
    return JPT.CastDItemToDBody(JPT.MacroTCursorToDItem(str(macro_tcursor)))

def create_geometry(part_name, get_width, get_height, get_radius):
    JPT.ClearLog()
    try:
        type_tobe_deleted = [3, 22]
        for type_id in type_tobe_deleted:
            for item in JPT.GetAllByTypeID(type_id):
                JPT.Exec('DeleteItem(0, [{0}:{1}], [], [], 1)'.format(type_id, item.id))
        if part_name == "":
            part_name = "Plane_Stress_1"
        cube_size_x = float(get_width) * 0.001
        cube_size_z = float(get_height) * 0.001
        cube_size_h = 1e-3
        hole_rad = float(get_radius) * 0.001
        if cube_size_x > 0 and cube_size_z > 0 and hole_rad > 0:
            color = random.randint(10000, 60000000)
            create_cube = convert_to_dbody(Geometry.Part.Cube(dlLength=[cube_size_x,
                                                                        cube_size_h,
                                                                        cube_size_z],
                                                              strName=part_name,
                                                              iPartColor=color))
            part_pos_x = 0 + cube_size_x / 2
            part_pos_z = 0 + cube_size_z / 2
            cylinder_height = cube_size_h + 2e-3
            create_cylinder = Geometry.Part.Cylinder(dlOrigin=[part_pos_x,
                                                               -0.001,
                                                               part_pos_z],
                                                     dTopRadius=hole_rad,
                                                     dBottomRadius=hole_rad,
                                                     dHeight=cylinder_height,
                                                     iPartColor=color)
            # Get part ID
            Assemble.BooleanEx([Part(create_cube.id, max([_.id for _ in JPT.GetAllParts()]))], strNameSuffix="", iBooleanType=1)
            create_cube.name = part_name

            # Get ID of face
            all_face_id = [(str(_.typeID)) + ":" + (str(_.id)) for _ in JPT.GetAllFaces()]
            target_face = []
            for cursor in all_face_id:
                str_command = 'EntityInfo({0},"CENTER")'.format(cursor)
                coordinate = cnvt_str_to_list(JPT.Exec(str_command))[1] # Select the coordinate value according to Y direction
                if float(coordinate) > 0:
                    target_face.append(cursor)

            # Delete the unnecessary face
            res = [int(_.split(":")[-1]) for _ in target_face] # Change from list [6:1, 6:2, ...] --> list [1, 2]
            JPT.Exec('DeleteFace({}, 1)'.format(res))
            JPT.ViewFitToModel()
            JPT.ClearLog()
            print("==================================================================")
            print("Created model information: ")
            print("--- Part name: %s" %str(part_name))
            print("--- Width: %s mm" %str(get_width))
            print("--- Height: %s mm" %str(get_height))
            print("--- Hole radius: %s mm" %str(get_radius))
            print("==================================================================")
        else:
            print("==================================================================")
            print("** [ERROR OCCURED] **")
            print("Inputted values are wrong, please check again!")
            print("The inputted values should follow the following rules:!")
            print("--- First: Model size should not be blanked. Its means you need to input float numbers")
            print("--- Second: The inputted values must be bigger than 0")
            print("==================================================================")
    except ValueError:
        print("==================================================================")
        print("** [ERROR OCCURED] **")
        print("Inputted values are wrong, please check again!")
        print("The inputted values should follow the following rules:!")
        print("--- First: Model size should not be blanked. Its means you need to input float numbers")
        print("--- Second: The inputted values must be bigger than 0")
        print("==================================================================")

def clear_geometry():
    JPT.ClearLog()
    for part in JPT.GetAllByTypeID(3):
        JPT.Exec('DeleteItem(0, [3:{}], [], [], 1)'.format(part.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the created parts!")
    print("==================================================================")

def generate_meshing(avg_size, min_size, max_size, second_element):
    try:
        JPT.ClearLog()
        JPT.Exec('ViewShowMesh(1)')
        avg_size_mm = float(avg_size) * 0.001
        min_size_mm = float(min_size) * 0.001
        max_size_mm = float(max_size) * 0.001
        if min_size_mm < 0.7*avg_size_mm and min_size_mm > 0 and \
            max_size_mm > 1.4*avg_size_mm and max_size_mm > 0 and \
                avg_size_mm > 0:
            for part in JPT.GetAllParts():
                Meshing.SurfaceMeshing(crlPart=[Part(part.id)],
                                       surfaceMesh=SURFACE_MESH(dAvgElemSize=avg_size_mm,
                                                                dMaxElemSize=max_size_mm,
                                                                dMinElemSize=min_size_mm,
                                                                dGeomAngle=0.7853981634,
                                                                dGeomMinSize=0.0001,
                                                                dMinStretchVal=0.01,
                                                                iPerformanceMode=1,
                                                                dAutoMergeTinyFacesAngle=0.5235987756,
                                                                bGeomApprox=True,
                                                                iNextEntityOffsetId=0),
                                       iThreadNum=12)
                if second_element == True:
                    MeshEdit.SurfaceMesh(crlPart=[Part(part.id)])
            element_type = "Tri3 (First order)" if second_element == False else "Tri6 (Second order)"
            JPT.ClearLog()
            print("==================================================================")
            print("Meshed model information: ")
            print("--- Average size: %s mm" %str(avg_size))
            print("--- Minimum size: %s mm" %str(min_size))
            print("--- Maximum size: %s mm" %str(max_size))
            print("--- Element type: %s" %str(element_type))
            print("==================================================================")
        else:
            print("==================================================================")
            print("** [ERROR OCCURED] **")
            print("Inputted values are wrong, please check again!")
            print("The inputted values should follow the following rules:!")
            print("--- First: All the inputted values must be bigger than 0")
            print("--- Second: Minimum size is less than or equal to 0.7*[Average size]")
            print("--- Third: Maximum size is more than or equal to 1.4*[Average size]")
            print("==================================================================")
    except ValueError:
        print("==================================================================")
        print("** [ERROR OCCURED] **")
        print("Inputted values are wrong, please check again!")
        print("The inputted values should follow the following rules:!")
        print("--- First: All the inputted values must be bigger than 0")
        print("--- Second: Minimum size is less than or equal to 0.7*[Average size]")
        print("--- Third: Maximum size is more than or equal to 1.4*[Average size]")
        print("==================================================================")

def undo_meshing():
    JPT.ClearLog()
    Toolbar.Undo(iCntUndo=3)
    JPT.ClearLog()
    print("==================================================================")
    print("Removed surface meshing successfully!")
    print("==================================================================")

def apply_property(dlg):
    JPT.ClearLog()
    check = False
    for prop in JPT.GetAllByTypeID(87):
        for entities in prop.targets:
            if entities.typeID == 3:
                check = True
                print("The current plane stress model is having material property")
                print("Please click Clear button before applying the new one")
                break
        if check == True:
            break
    if check == False:
        sel_mat = dlg.get_combobox_sel('list_material')
        thickness = 1e-6
        part_id = [_.id for _ in JPT.GetAllParts()][0]
        mat_name = ""
        if sel_mat == 0: # Copper Alloy
            mat_name = "Copper Alloy"
            Properties.Material.Add("Copper_Alloy",
                                    [Density([(DENSITY, 8.3e-09)]),
                                     Elastic([(YOUNGS_MODULUS, 110000.0),
                                              (POISSONS_RATIO, 0.34)])])
        if sel_mat == 1: # Manesium Alloy
            mat_name = "Manesium Alloy"
            Properties.Material.Add("Magnesium_Alloy",
                                    [Density([(DENSITY, 1.8e-09)]),
                                     Elastic([(YOUNGS_MODULUS, 45000.0),
                                              (POISSONS_RATIO, 0.35)])])
        if sel_mat == 2: # Concrete
            mat_name = "Concrete"
            Properties.Material.Add("Concrete",
                                    [Density([(DENSITY, 2.3e-09)]),
                                     Elastic([(YOUNGS_MODULUS, 30000.0),
                                              (POISSONS_RATIO, 0.18)])])
        if sel_mat == 3: # Structure Steel
            mat_name = "Structure Steel"
            Properties.Material.Add("Structural_Steel",
                                    [Density([(DENSITY, 7.85e-09)]),
                                     Elastic([(YOUNGS_MODULUS, 200000.0),
                                              (POISSONS_RATIO, 0.3)])])
        if sel_mat == 4: # Stainless Steel
            mat_name = "Stainless Steel"
            Properties.Material.Add("Stainless_Steel",
                                    [Density([(DENSITY, 7.75e-09)]),
                                     Elastic([(YOUNGS_MODULUS, 193000.0),
                                              (POISSONS_RATIO, 0.31)])])
        command2='Property2DShell("Plane_Stress_Example", 1, 22:{0}, 22:{0}, 22:{0}, 0:0, \
1.79769e+308, 1.79769e+308, 1.79769e+308, {1}, 1.79769e+308, \
1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, 0, 0:0, [3:{2}], 0:0, 0)'.\
                  format((sel_mat + 1), thickness, part_id)
        JPT.Exec(command2)
        JPT.ClearLog()
        print("==================================================================")
        print("Applied material: %s" %str(mat_name))
        print("==================================================================")

def clear_property():
    JPT.ClearLog()
    for prop in JPT.GetAllByTypeID(87):
        JPT.Exec('DeleteItem(0, [87:{}], [], [], 1)'.format(prop.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the applied material properties!")
    print("==================================================================")

def apply_fixed_constraint(constraint_name, x_direction, z_direction):
    JPT.ClearLog()
    constraint_dir = ""
    selected_edges = ""
    for edge in JPT.GetSelectedEdges():
        if x_direction == True:
            constraint_dir = "X"
            contraint_type = 59
        if z_direction == True:
            constraint_dir = "Z"
            contraint_type = 62
        if x_direction == True and z_direction == True:
            constraint_dir = "X and Z"
            contraint_type = 63
        BoundaryConditions.FixedConstraint(strName=constraint_name,
                                           iDwDof=contraint_type,
                                           crlTargets=[Edge(edge.id)])
        selected_edges += str(edge.id) + ", "
    JPT.ClearLog()
    selected_edges = selected_edges[:-2]
    print("==================================================================")
    print("Constraint information: ")
    print("--- Selected edges (ID): %s" %str(selected_edges))
    print("--- Fixed direction: %s" %str(constraint_dir))
    print("==================================================================")

def clear_fixed_constraint():
    JPT.ClearLog()
    for fixed_constrains in JPT.GetAllByTypeID(37):
        JPT.Exec('DeleteItem(0, [37:{}], [], [], 1)'.format(fixed_constrains.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the applied constraints!")
    print("==================================================================")

def apply_force(force_name, force_x, force_z):
    JPT.ClearLog()
    selected_edges = ""
    for edge in JPT.GetSelectedEdges():
        if force_x == "":
            force_x = 0
        else:
            force_x = float(force_x)
        if force_z == "":
            force_z = 0
        else:
            force_z = float(force_z)
        BoundaryConditions.Force.General(force_name,
                                         forceLBC=FORCE_LBC(vecForce=[force_x,
                                                                      DFLT_DBL,
                                                                      force_z]),
                                         crlTargets=[Edge(edge.id)])
        selected_edges += str(edge.id) + ", "
    JPT.ClearLog()
    selected_edges = selected_edges[:-2]
    print("==================================================================")
    print("Force information: ")
    print("--- Selected edges (ID): %s" %str(selected_edges))
    print("--- Fixed direction:")
    print("------- X direction: %s" %str(float(force_x)))
    print("------- Z direction: %s" %str(float(force_z)))
    print("==================================================================")

def clear_force():
    JPT.ClearLog()
    for force in JPT.GetAllByTypeID(29):
        JPT.Exec('DeleteItem(0, [29:{}], [], [], 1)'.format(force.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the applied forces!")
    print("==================================================================")

def export_and_run_calculation(dlg):
    JPT.ClearLog()
    file_name = dlg.get_item_text("part_name")
    output_folder = dlg.get_item_text("open_folder_for_saving")
    if output_folder != "":
        if os.path.isdir(output_folder) == False:
            print("[Warning]: Inputted folder is not exist!")
            print("--- Creating {0} folder".format(output_folder))
            os.mkdir(output_folder)
            print("--- Created {0} folder".format(output_folder))
        if file_name == "":
            message = "The part name is blanked. The exported file will use the inputted part's name. \
If part's name is blanked, 'Test.bdf' will be used. \
Do you want to continue?"
            title = "Warning!"
            result = ctypes.windll.user32.MessageBoxW(0, message, title, 0x04)
            if result == 6:
                file_name = 'Test'
                full_path_to_saved_folder = re.sub("//", "/", re.sub(re.escape("\\"), "/", output_folder))
                full_path_bdf_file = full_path_to_saved_folder + "/" + file_name + ".bdf"
                Analysis.TSSolver.LinearStatic(strName=file_name,
                                               nastranAnalysis=NASTRAN_ANALYSIS(iSolverType=3,
                                                                                iGridFormatType=1,
                                                                                bUseCASI=True,
                                                                                dEpsilon=DFLT_DBL,
                                                                                iMaxNumOfIter=DFLT_INT,
                                                                                iMemory=1024,
                                                                                iSolNo=101,
                                                                                nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStrain=0),
                                                                                nastranNonlinear=NASTRAN_NONLINEAR(iMAXITER=DFLT_INT,
                                                                                                                    bUseEPSW=True,
                                                                                                                    dEPSU=DFLT_DBL,
                                                                                                                    dEPSP=DFLT_DBL)),
                                               strPath=full_path_bdf_file)
                bat_file_contents = 'setlocal\n\nset filename=%%1\nset ss_working_dir=%%2\n\nif %%filename%%=="" \
goto nofile\ncall:get_path %%ss_working_dir%% cwd\n\nset cwd=%%3\n\nif %%cwd%%=="" \
goto nocwd\n\ncall :get_drive %%cwd%% drive\ncd %%cwd%%\n%%drive%%\n\n%%ss_working_dir%% %%filename%%\n\
goto eof\n\n:nofile\necho ERROR : Input file not selected\ngoto :eof\n\n:nocwd\n\
echo ERROR : Working directory not selected\ngoto :eof\n\n:eof\nendlocal\n\
goto :eof\n\n:get_drive \nset "%%~2=%%~d1"\ngoto :eof\n\n:get_path \nset "%%~2=%%~dp1"\ngoto :eof'
                bat_file_contents = re.sub(re.escape("%%"), r"%", bat_file_contents)
                bat_file = output_folder + "\\start_ts_ss.bat"
                jupiter_installation_folder = JPT.GetAppPathInfo(0)
                bat_file_param_1 = re.sub("/", re.escape("\\"), full_path_bdf_file)
                bat_file_param_2 = jupiter_installation_folder + r"SunShine\sunshine.exe"
                bat_file_param_3 = re.sub("/", re.escape("\\"), full_path_to_saved_folder)
                with open (bat_file, "w") as f:
                    f.writelines(bat_file_contents)
                run_sunshine = subprocess.Popen([bat_file,
                                                bat_file_param_1,
                                                bat_file_param_2,
                                                bat_file_param_3],
                                                stdout=subprocess.PIPE)
                run_sunshine.wait()
                rc = run_sunshine.returncode
                check_result = False
                if str(rc).strip() == "0":
                    for root, dirs, files in os.walk(bat_file_param_3):
                        for file in files:
                            if file.lower().find(".op2") != -1:
                                check_result = True
                                op2_file = re.sub(re.escape("\\"), "/", root + "\\" + file)
                                break
                        if check_result == True:
                            break
                else:
                    JPT.ClearLog()
                    print("[Error]: Calculation process is stopped without exporting op2 file")
                if check_result == True:
                    JPT.ClearLog()
                    ctypes.windll.user32.MessageBoxW(0, "Calculation step is done!", "FINISHED", 0x0 | 0x40)
                    print(" FINISHED ".center("+", 30))
                    print("The result file is saved at:")
                    print("--- %s" %str(op2_file))
                    print("+"*30)
                else:
                    JPT.ClearLog()
                    ctypes.windll.user32.MessageBoxW(0, "Calculation is stopped with an error", "Error", 0x0 | 0x10)
                    print(" Error ".center(30, "+"))
                    print("An error has occurred while calculating")
                    print("+"*30)
            else:
                JPT.ClearLog()
                print("Please input the part's name in the Geometry tab")
        else:
            JPT.ClearLog()
            full_path_to_saved_folder = re.sub("//", "/", re.sub(re.escape("\\"), "/", output_folder))
            full_path_bdf_file = full_path_to_saved_folder + "/" + file_name + ".bdf"
            Analysis.TSSolver.LinearStatic(strName=file_name,
                                           nastranAnalysis=NASTRAN_ANALYSIS(iSolverType=3,
                                                                            iGridFormatType=1,
                                                                            bUseCASI=True,
                                                                            dEpsilon=DFLT_DBL,
                                                                            iMaxNumOfIter=DFLT_INT,
                                                                            iMemory=1024,
                                                                            iSolNo=101,
                                                                            nastranOutputRequest=NASTRAN_OUTPUT_REQUEST(iTypeStrain=0),
                                                                            nastranNonlinear=NASTRAN_NONLINEAR(iMAXITER=DFLT_INT,
                                                                                                               bUseEPSW=True,
                                                                                                               dEPSU=DFLT_DBL,
                                                                                                               dEPSP=DFLT_DBL)),
                                           strPath=full_path_bdf_file)
            bat_file_contents = 'setlocal\n\nset filename=%%1\nset ss_working_dir=%%2\n\nif %%filename%%=="" \
goto nofile\ncall:get_path %%ss_working_dir%% cwd\n\nset cwd=%%3\n\nif %%cwd%%=="" \
goto nocwd\n\ncall :get_drive %%cwd%% drive\ncd %%cwd%%\n%%drive%%\n\n%%ss_working_dir%% %%filename%%\n\
goto eof\n\n:nofile\necho ERROR : Input file not selected\ngoto :eof\n\n:nocwd\n\
echo ERROR : Working directory not selected\ngoto :eof\n\n:eof\nendlocal\ngoto :eof\n\n:get_drive \nset "%%~2=%%~d1"\n\
goto :eof\n\n:get_path \nset "%%~2=%%~dp1"\ngoto :eof'
            bat_file_contents = re.sub(re.escape("%%"), r"%", bat_file_contents)
            bat_file = output_folder + "\\start_ts_ss.bat"
            jupiter_installation_folder = JPT.GetAppPathInfo(0)
            bat_file_param_1 = re.sub("/", re.escape("\\"), full_path_bdf_file)
            bat_file_param_2 = jupiter_installation_folder + r"SunShine\sunshine.exe"
            bat_file_param_3 = re.sub("/", re.escape("\\"), full_path_to_saved_folder)
            with open (bat_file, "w") as f:
                f.writelines(bat_file_contents)
            run_sunshine = subprocess.Popen([bat_file,
                                                bat_file_param_1,
                                                bat_file_param_2,
                                                bat_file_param_3],
                                                stdout=subprocess.PIPE)
            run_sunshine.wait()
            rc = run_sunshine.returncode
            check_result = False
            if str(rc).strip() == "0":
                for root, dirs, files in os.walk(bat_file_param_3):
                    for file in files:
                        if file.lower().find(".op2") != -1:
                            check_result = True
                            op2_file = re.sub(re.escape("\\"), "/", root + "\\" + file)
                            break
                    if check_result == True:
                        break
            else:
                JPT.ClearLog()
                print("[Error]: Calculation process is stopped without exporting op2 file")
            if check_result == True:
                JPT.ClearLog()
                ctypes.windll.user32.MessageBoxW(0, "Calculation step is done!", "FINISHED", 0x0 | 0x40)
                print(" FINISHED ".center(30, "+"))
                print("The result file is saved at:")
                print("--- %s" %str(op2_file))
                print("+"*30)
            else:
                JPT.ClearLog()
                ctypes.windll.user32.MessageBoxW(0, "Calculation is stopped with an error", "Error", 0x0 | 0x10)
                print(" Error ".center("+", 30))
                print("An error has occurred while calculating")
                print("+"*30)
    else:
        JPT.ClearLog()
        ctypes.windll.user32.MessageBoxW(0, "Please input output folder!", "Error", 0x0 | 0x10)

def main():
    dlg=JDGCreator(title="Plane Stress",resizable=True,validation=True)
    #
    dlg.add_layout(name="Layout2",orientation=orientation.vertical,layout="Window")
    #
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Layout2")
    sample_folder = re.sub(re.escape("\\"), "/", (JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH) + \
                                                  r'SampleData\PSJ\PSJ-GUI\PlaneStress\PlaneStress_Pics'))
    picture_file = sample_folder + "/PlaneStress_2D_pic.PNG"
    dlg.add_imagectrl(name="ImageCtrl",image_file=picture_file,layout="Layout1")
    #
    dlg.add_tabwnd(name="TabCtrl2",width=400,height=270,layout="Layout2")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem7",page_text="Geometry")
    #
    dlg.add_layout(name="Layout7",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="get_name",text="Part name",width=80,layout="Layout7")
    dlg.add_textbox(name="part_name",text="planestress_model1",type="string",layout="Layout7")
    dlg.add_separator(name="Separator1",layout="Layout7")
    #
    dlg.add_layout(name="Layout16",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="Label17",text="Coordinate ",width=80,layout="Layout16")
    dlg.add_combobox(name="ComboBox27",options=["Global"],layout="Layout16")
    dlg.add_separator(name="Separator2",layout="Layout16")
    #
    dlg.add_layout(name="Layout19",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="width",text="Width",width=80,layout="Layout19")
    dlg.add_textbox(name="get_width",text="20.0",type="double",layout="Layout19")
    dlg.add_separator(name="Separator3",layout="Layout19")
    #
    dlg.add_layout(name="Layout22",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="Label23",text="Heigth",width=80,layout="Layout22")
    dlg.add_textbox(name="get_height",text="10.0",type="double",layout="Layout22")
    dlg.add_separator(name="Separator4",layout="Layout22")
    #
    dlg.add_layout(name="Layout25",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="Label26",text="Hole Rad",width=80,layout="Layout25")
    dlg.add_textbox(name="get_radius",text="1.0",type="double",layout="Layout25")
    dlg.add_separator(name="Separator5",layout="Layout25")
    #
    dlg.add_layout(name="Layout44",margin=[10,10,0,0],orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_button(name="apply_geometry",text="Apply",width=80,height=30,layout="Layout44")
    dlg.add_button(name="clear_geometry",text="Clear",width=80,height=30,layout="Layout44")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem26",page_text="Meshing")
    #
    dlg.add_layout(name="Layout29",orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_label(name="Label30",text="Average Size",width=100,layout="Layout29")
    dlg.add_textbox(name="avg_size",text="0.5",type="double",layout="Layout29")
    #
    dlg.add_layout(name="Layout30",orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_label(name="Label31",text="Minimum Size",width=100,layout="Layout30")
    dlg.add_textbox(name="min_size",text="0.1",type="double",layout="Layout30")
    #
    dlg.add_layout(name="Layout31",orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_label(name="Label32",text="Maximum Size",width=100,layout="Layout31")
    dlg.add_textbox(name="max_size",text="1.0",type="double",layout="Layout31")
    #
    dlg.add_layout(name="Layout38",margin=[0,10,0,0],orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_checkbox(name="second_element",text="Second Order Element",checked=True,layout="Layout38")
    #
    dlg.add_layout(name="Layout37",margin=[10,10,0,0],orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_button(name="generate_meshing",text="Apply",width=80,height=30,layout="Layout37")
    dlg.add_button(name="undo_meshing",text="Undo meshing",width=80,height=30,layout="Layout37")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem41",page_text="Properties")
    #
    dlg.add_layout(name="Layout41",orientation=orientation.horizontal,layout="TabItem41")
    dlg.add_label(name="Label44",text="Material",layout="Layout41")
    dlg.add_combobox(name="list_material",options=["Copper Alloy","Manesium Alloy","Concrete","Structural Steel","Stainless Steel"],layout="Layout41")
    #
    dlg.add_layout(name="Layout42",margin=[0,10,0,0],orientation=orientation.horizontal,layout="TabItem41")
    dlg.add_button(name="apply_property",text="Apply",width=60,height=30,layout="Layout42")
    dlg.add_button(name="clear_property",text="Clear",width=60,height=30,layout="Layout42")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem48",page_text="LBCs")
    #
    dlg.add_layout(name="Layout55",margin=[0,0,0,5],orientation=orientation.horizontal,layout="TabItem48")
    dlg.add_groupbox(name="group_fixed_constraint",text="Fixed Condition",layout="Layout55")
    #
    dlg.add_layout(name="Layout52",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_fixed_constraint")
    dlg.add_label(name="Label49",text="Name",width=80,layout="Layout52")
    dlg.add_textbox(name="constraint_name",text="FixedConstraint_1",type="string",layout="Layout52")
    #
    dlg.add_layout(name="Layout51",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_fixed_constraint")
    dlg.add_label(name="Label52",text="Direction",layout="Layout51")
    dlg.add_checkbox(name="x_direction",text="X direction",checked=True,layout="Layout51")
    dlg.add_checkbox(name="z_direction",text="Z direction",width=70,checked=True,layout="Layout51")
    #
    dlg.add_layout(name="Layout68",margin=[30,0,0,0],orientation=orientation.horizontal,layout="group_fixed_constraint")
    dlg.add_button(name="apply_fixed_constraint",text="Apply",width=60,height=30,layout="Layout68")
    dlg.add_button(name="clear_fixed_constraint",text="Clear",width=60,height=30,layout="Layout68")
    #
    dlg.add_layout(name="Layout58",margin=[0,0,0,2],orientation=orientation.horizontal,layout="TabItem48")
    dlg.add_groupbox(name="group_force_condition",text="Force Condition",layout="Layout58")
    #
    dlg.add_layout(name="Layout61",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_label(name="Label62",text="Name",width=80,layout="Layout61")
    dlg.add_textbox(name="force_name",text="ForceConstraint_1",type="string",layout="Layout61")
    #
    dlg.add_layout(name="Layout63",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_label(name="force_x_label",text="X direction",width=80,layout="Layout63")
    dlg.add_textbox(name="force_x",text="-10.0",type="double",layout="Layout63")
    #
    dlg.add_layout(name="Layout70",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_label(name="force_z_label",text="Z direction",width=80,layout="Layout70")
    dlg.add_textbox(name="force_z",text="0.0",type="double",layout="Layout70")
    #
    dlg.add_layout(name="Layout72",margin=[30,0,0,0],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_button(name="apply_force",text="Apply",width=60,height=30,layout="Layout72")
    dlg.add_button(name="clear_force",text="Clear",width=60,height=30,layout="Layout72")
    dlg.add_edge_selector()
    #
    dlg.add_groupbox(name="GroupBox1",text="Select folder",layout="Window")
    dlg.add_label(name="Label111",width=200,text="Select folder to export the result",layout="GroupBox1")
    dlg.add_browser(name="open_folder_for_saving",mode="folder",file_filter="All Files(*.*)",layout="GroupBox1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Export and run the calculation",width=200,height=30,layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",width=100,height=30,layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    #
    dlg.on_command("apply_geometry", create_geometry)
    dlg.on_command("clear_geometry", clear_geometry)
    dlg.on_command("generate_meshing", generate_meshing)
    dlg.on_command("undo_meshing", undo_meshing)
    dlg.on_command("apply_property", apply_property)
    dlg.on_command("clear_property", clear_property)
    dlg.on_command("apply_fixed_constraint", apply_fixed_constraint)
    dlg.on_command("clear_fixed_constraint", clear_fixed_constraint)
    dlg.on_command("apply_force", apply_force)
    dlg.on_command("clear_force", clear_force)
    dlg.on_command("ButtonApply", export_and_run_calculation)
    #
    dlg.generate_window()

if __name__=='__main__':
    main()

# coding: cp932
#*******************************************************************************
# COPYRIGHT NOTES
# ---------------
# This is a part of the PSJ Library
# Copyright (C) 2002-2020 Technostar Ltd.
# All rights reserved.
#
# This source code can be used, distributed or modified
# only under terms and conditions
# of the accompanying license agreement.
#*******************************************************************************
# PSJ GUI EXAMPLES
# ---------------------
# This example demonstrades how to apply PSJ on a simple problem
# such as plane stress problem
# Required: Sunshine license
#*******************************************************************************

import JPT
import re
import os
from pyjdg import *
import random
import ctypes
import subprocess

def cnvt_str_to_list(in_str: str) -> list:
    err_chars = r"/¥|^[]()"
    split_char = ","
    in_str = in_str.strip(err_chars)
    in_str = in_str.split(split_char)
    return in_str

def convert_to_dbody(macro_tcursor: str):
    return JPT.CastDItemToDBody(JPT.MacroTCursorToDItem(macro_tcursor))

def create_geometry(part_name, get_width, get_height, get_radius):
    JPT.ClearLog()
    try:
        type_tobe_deleted = [3, 22]
        for type_id in type_tobe_deleted:
            for item in JPT.GetAllByTypeID(type_id):
                JPT.Exec('DeleteItem(0, [{0}:{1}], [], [], 1)'.format(type_id, item.id))
        if part_name == "":
            part_name = "Plane_Stress_1"
        cube_size_x = float(get_width) * 0.001
        cube_size_z = float(get_height) * 0.001
        cube_size_h = 1e-3
        hole_rad = float(get_radius) * 0.001
        if cube_size_x > 0 and cube_size_z > 0 and hole_rad > 0:
            color = random.randint(10000, 60000000)
            create_cube = convert_to_dbody(JPT.Exec('CreateCube([0, 0, 0], [{0}, {1}, {2}], [10, 10, 10], "{3}", {4}, 0:0)'.
                                                    format(cube_size_x,
                                                           cube_size_h,
                                                           cube_size_z,
                                                           part_name,
                                                           color)))
            part_pos_x = 0 + cube_size_x / 2
            part_pos_z = 0 + cube_size_z / 2
            cylinder_height = cube_size_h + 2e-3
            create_cylinder = JPT.Exec('CreateCylinderFrustum([{0}, {1}, {2}], {3}, {3}, {4}, 36, 10, "Cylinder_1", {5}, 0:0)'.
                                       format(part_pos_x,
                                              -0.001,
                                              part_pos_z,
                                              hole_rad,
                                              cylinder_height,
                                              color))
            # Get part ID
            JPT.Exec('BooleanEx([3:{0}, 3:{1}], "", 1, 0, 0, 0)'.
                     format(create_cube.id,
                            max([_.id for _ in JPT.GetAllParts()])))
            create_cube.name = part_name

            # Get ID of face
            all_face_id = [(str(_.typeID)) + ":" + (str(_.id)) for _ in JPT.GetAllFaces()]
            target_face = []
            for cursor in all_face_id:
                str_command = 'EntityInfo({0},"CENTER")'.format(cursor)
                coordinate = cnvt_str_to_list(JPT.Exec(str_command))[1] # Select the coordinate value according to Y direction
                if float(coordinate) > 0:
                    target_face.append(cursor)

            # Delete the unnecessary face
            res = [int(_.split(":")[-1]) for _ in target_face] # Change from list [6:1, 6:2, ...] --> list [1, 2]
            JPT.Exec('DeleteFace({}, 1)'.format(res))
            JPT.ViewFitToModel()
            JPT.ClearLog()
            print("==================================================================")
            print("Created model information: ")
            print("--- Part name: %s" %str(part_name))
            print("--- Width: %s mm" %str(get_width))
            print("--- Height: %s mm" %str(get_height))
            print("--- Hole radius: %s mm" %str(get_radius))
            print("==================================================================")
        else:
            print("==================================================================")
            print("** [ERROR OCCURED] **")
            print("Inputted values are wrong, please check again!")
            print("The inputted values should follow the following rules:!")
            print("--- First: Model size should not be blanked. Its means you need to input float numbers")
            print("--- Second: The inputted values must be bigger than 0")
            print("==================================================================")
    except ValueError:
        print("==================================================================")
        print("** [ERROR OCCURED] **")
        print("Inputted values are wrong, please check again!")
        print("The inputted values should follow the following rules:!")
        print("--- First: Model size should not be blanked. Its means you need to input float numbers")
        print("--- Second: The inputted values must be bigger than 0")
        print("==================================================================")

def clear_geometry():
    JPT.ClearLog()
    for part in JPT.GetAllByTypeID(3):
        JPT.Exec('DeleteItem(0, [3:{}], [], [], 1)'.format(part.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the created parts!")
    print("==================================================================")

def generate_meshing(avg_size, min_size, max_size, second_element):
    try:
        JPT.ClearLog()
        JPT.Exec('ViewShowMesh(1)')
        avg_size_mm = float(avg_size) * 0.001
        min_size_mm = float(min_size) * 0.001
        max_size_mm = float(max_size) * 0.001
        if min_size_mm < 0.7*avg_size_mm and min_size_mm > 0 and \
            max_size_mm > 1.4*avg_size_mm and max_size_mm > 0 and \
                avg_size_mm > 0:
            for part in JPT.GetAllParts():
                JPT.Exec('MeshEditAdjustVertex([3:{0}])'.format(part.id))
                command1='SetMeshAttrib([3:%s], {%s, %s, %s, 1, 0.7853981634, 0.001, 1.25, 0.1, \
                                                 0.1, 0.7, 0.5, 1, 3, 0, 0, 0, 0.5235987756, 0, 0, \
                                                 0, 0, 0, 0, 0, 0, 10000000, 0, 0})' \
                          %(str(part.id), str(avg_size_mm), str(max_size_mm), str(min_size_mm))
                JPT.Exec(command1)
                command2='SurfaceMeshing2D([3:%s], {%s, %s, %s, 1, 0.7853981634, 0.001, 1.25, 0.1, \
                                                    0.1, 0.7, 0.5, 1, 3, 0, 0, 0, 0.5235987756, 0, 0, \
                                                    0, 0, 0, 0, 0, 0, 10000000, 0, 0}, 1, 0, 24, 1, 0, 65280)' \
                                           %(str(part.id), str(avg_size_mm), str(max_size_mm), str(min_size_mm))
                JPT.Exec(command2)
                if second_element == True:
                    JPT.Exec('ElementConv_Surface([3:{0}], 1)'.format(part.id))
            element_type = "Tri3 (First order)" if second_element == False else "Tri6 (Second order)"
            JPT.ClearLog()
            print("==================================================================")
            print("Meshed model information: ")
            print("--- Average size: %s mm" %str(avg_size))
            print("--- Minimum size: %s mm" %str(min_size))
            print("--- Maximum size: %s mm" %str(max_size))
            print("--- Element type: %s" %str(element_type))
            print("==================================================================")
        else:
            print("==================================================================")
            print("** [ERROR OCCURED] **")
            print("Inputted values are wrong, please check again!")
            print("The inputted values should follow the following rules:!")
            print("--- First: All the inputted values must be bigger than 0")
            print("--- Second: Minimum size is less than or equal to 0.7*[Average size]")
            print("--- Third: Maximum size is more than or equal to 1.4*[Average size]")
            print("==================================================================")
    except ValueError:
        print("==================================================================")
        print("** [ERROR OCCURED] **")
        print("Inputted values are wrong, please check again!")
        print("The inputted values should follow the following rules:!")
        print("--- First: All the inputted values must be bigger than 0")
        print("--- Second: Minimum size is less than or equal to 0.7*[Average size]")
        print("--- Third: Maximum size is more than or equal to 1.4*[Average size]")
        print("==================================================================")

def undo_meshing():
    JPT.ClearLog()
    JPT.Exec('Undo(3)')
    JPT.ClearLog()
    print("==================================================================")
    print("Removed surface meshing successfully!")
    print("==================================================================")

def apply_property(dlg):
    JPT.ClearLog()
    check = False
    for prop in JPT.GetAllByTypeID(87):
        for entities in prop.targets:
            if entities.typeID == 3:
                check = True
                print("The current plane stress model is having material property")
                print("Please click Clear button before applying the new one")
                break
        if check == True:
            break
    if check == False:
        sel_mat = dlg.get_combobox_sel('list_material')
        thickness = 1e-6
        part_id = [_.id for _ in JPT.GetAllParts()][0]
        mat_name = ""
        if sel_mat == 0: # Copper Alloy
            mat_name = "Copper Alloy"
            command1='CreateMaterial([[1095, "<?xml version=#1.0#?>\
<JPT-MATERIAL-LIBRARY Version=#3#><Material Name=#Copper_Alloy# Description=## \
Id=#1# NasId=#1# DBId=#0# IsCompositeMaterial=#false# CId=#0#><Layer Thick=# # \
Angle=# # Id=#0#><Density temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#>\
<Data>8.300000000000000e+03</Data></Table></Density><Elastic Type=#0# temperatureDependency=#0# \
dependencies=#0# Moduli=#LONG_TERM# SubOption=#Fail_Strain# noCompression=#0# noTension=#0#><Table \
Row=#1# Col=#3#><Data>1.100000000000000e+11, ,3.400000000000000e-01</Data></Table><Table Row=#0# Col=#0#>\
<Data></Data></Table></Elastic><Expansion Type=#0# userSubroutine=#0# zero=#0# temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>1.800000000000000e-05</Data></Table></Expansion><Conductivity \
Type=#0# temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#><Data>3.850000000000000e+02</Data>\
</Table></Conductivity><SpecificHeat temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#>\
<Data>4.190000000000000e+02</Data></Table></SpecificHeat></Layer></Material></JPT-MATERIAL-LIBRARY>"]], 1)'
            JPT.Exec(command1)
        if sel_mat == 1: # Manesium Alloy
            mat_name = "Manesium Alloy"
            command1='CreateMaterial([[1098, "<?xml version=#1.0#?>\
<JPT-MATERIAL-LIBRARY Version=#3#><Material Name=#Magnesium_Alloy# Description=## Id=#1# NasId=#2# \
DBId=#0# IsCompositeMaterial=#false# CId=#0#><Layer Thick=# # Angle=# # Id=#0#><Density temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>1.800000000000000e+03</Data></Table></Density><Elastic Type=#0# \
temperatureDependency=#0# dependencies=#0# Moduli=#LONG_TERM# SubOption=#Fail_Strain# noCompression=#0# noTension=#0#>\
<Table Row=#1# Col=#3#><Data>4.500000000000000e+10, ,3.500000000000000e-01</Data></Table><Table Row=#0# Col=#0#>\
<Data></Data></Table></Elastic><Expansion Type=#0# userSubroutine=#0# zero=#0# temperatureDependency=#0# dependencies=#0#>\
<Table Row=#1# Col=#1#><Data>2.600000000000000e-05</Data></Table></Expansion><Conductivity Type=#0# \
temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#><Data>1.560000000000000e+02</Data></Table></Conductivity>\
<SpecificHeat temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#><Data>1.038000000000000e+03</Data></Table>\
</SpecificHeat></Layer></Material></JPT-MATERIAL-LIBRARY>"]], 1)'
            JPT.Exec(command1)
        if sel_mat == 2: # Concrete
            mat_name = "Concrete"
            command1='CreateMaterial([[1091, "<?xml version=#1.0#?>\
<JPT-MATERIAL-LIBRARY Version=#3#><Material Name=#Concrete# Description=## Id=#1# NasId=#3# \
DBId=#0# IsCompositeMaterial=#false# CId=#0#><Layer Thick=# # Angle=# # Id=#0#><Density temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>2.300000000000000e+03</Data></Table></Density><Elastic Type=#0# \
temperatureDependency=#0# dependencies=#0# Moduli=#LONG_TERM# SubOption=#Fail_Strain# noCompression=#0# noTension=#0#>\
<Table Row=#1# Col=#3#><Data>3.000000000000000e+10, ,1.800000000000000e-01</Data></Table><Table Row=#0# Col=#0#><Data>\
</Data></Table></Elastic><Expansion Type=#0# userSubroutine=#0# zero=#0# temperatureDependency=#0# dependencies=#0#>\
<Table Row=#1# Col=#1#><Data>1.400000000000000e-05</Data></Table></Expansion><Conductivity Type=#0# temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>1.600000000000000e+00</Data></Table></Conductivity><SpecificHeat \
temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#><Data>1.050000000000000e+03</Data></Table></SpecificHeat>\
</Layer></Material></JPT-MATERIAL-LIBRARY>"]], 1)'
            JPT.Exec(command1)
        if sel_mat == 3: # Structure Steel
            mat_name = "Structure Steel"
            command1='CreateMaterial([[1099, "<?xml version=#1.0#?>\
<JPT-MATERIAL-LIBRARY Version=#3#><Material Name=#Structural_Steel# Description=## Id=#1# NasId=#4# DBId=#0# \
IsCompositeMaterial=#false# CId=#0#><Layer Thick=# # Angle=# # Id=#0#><Density temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>7.850000000000000e+03</Data></Table></Density><Elastic Type=#0# \
temperatureDependency=#0# dependencies=#0# Moduli=#LONG_TERM# SubOption=#Fail_Strain# noCompression=#0# noTension=#0#>\
<Table Row=#1# Col=#3#><Data>2.000000000000000e+11, ,3.000000000000000e-01</Data></Table><Table Row=#0# Col=#0#><Data></Data>\
</Table></Elastic><Expansion Type=#0# userSubroutine=#0# zero=#0# temperatureDependency=#0# dependencies=#0#>\
<Table Row=#1# Col=#1#><Data>1.200000000000000e-05</Data></Table></Expansion><Conductivity Type=#0# temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>5.900000000000000e+01</Data></Table></Conductivity><SpecificHeat \
temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#><Data>4.610000000000000e+02</Data></Table></SpecificHeat>\
</Layer></Material></JPT-MATERIAL-LIBRARY>"]], 1)'
            JPT.Exec(command1)
        if sel_mat == 4: # Stainless Steel
            mat_name = "Stainless Steel"
            command1='CreateMaterial([[1098, "<?xml version=#1.0#?>\
<JPT-MATERIAL-LIBRARY Version=#3#><Material Name=#Stainless_Steel# Description=## Id=#1# NasId=#5# \
DBId=#0# IsCompositeMaterial=#false# CId=#0#><Layer Thick=# # Angle=# # Id=#0#><Density temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>7.750000000000000e+03</Data></Table></Density><Elastic Type=#0# \
temperatureDependency=#0# dependencies=#0# Moduli=#LONG_TERM# SubOption=#Fail_Strain# noCompression=#0# noTension=#0#>\
<Table Row=#1# Col=#3#><Data>1.930000000000000e+11, ,3.100000000000000e-01</Data></Table><Table Row=#0# Col=#0#>\
<Data></Data></Table></Elastic><Expansion Type=#0# userSubroutine=#0# zero=#0# temperatureDependency=#0# dependencies=#0#>\
<Table Row=#1# Col=#1#><Data>1.700000000000000e-05</Data></Table></Expansion><Conductivity Type=#0# temperatureDependency=#0# \
dependencies=#0#><Table Row=#1# Col=#1#><Data>1.600000000000000e+01</Data></Table></Conductivity><SpecificHeat \
temperatureDependency=#0# dependencies=#0#><Table Row=#1# Col=#1#><Data>5.020000000000000e+02</Data></Table></SpecificHeat>\
</Layer></Material></JPT-MATERIAL-LIBRARY>"]], 1)'
            JPT.Exec(command1)
        command2='Property2DShell("Plane_Stress_Example", 1, 22:{0}, 22:{0}, 22:{0}, 0:0, 1.79769e+308, 1.79769e+308, \
1.79769e+308, {1}, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647, \
0, 0:0, [3:{2}], 0:0, 0)'.\
                  format((sel_mat + 1), thickness, part_id)
        JPT.Exec(command2)
        JPT.ClearLog()
        print("==================================================================")
        print("Applied material: %s" %str(mat_name))
        print("==================================================================")

def clear_property():
    JPT.ClearLog()
    for prop in JPT.GetAllByTypeID(87):
        JPT.Exec('DeleteItem(0, [87:{}], [], [], 1)'.format(prop.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the applied material properties!")
    print("==================================================================")

def apply_fixed_constraint(constraint_name, x_direction, z_direction):
    JPT.ClearLog()
    constraint_dir = ""
    selected_edges = ""
    for edge in JPT.GetSelectedEdges():
        if x_direction == True:
            constraint_dir = "X"
            contraint_type = 59
        if z_direction == True:
            constraint_dir = "Z"
            contraint_type = 62
        if x_direction == True and z_direction == True:
            constraint_dir = "X and Z"
            contraint_type = 63
        JPT.Exec('FixedConstraint("{0}", {1}, 0:0, 0, 0, 0:0, 0, [5:{2}], 0:0)'.format(constraint_name, contraint_type, edge.id))
        selected_edges += str(edge.id) + ", "
    JPT.ClearLog()
    selected_edges = selected_edges[:-2]
    print("==================================================================")
    print("Constraint information: ")
    print("--- Selected edges (ID): %s" %str(selected_edges))
    print("--- Fixed direction: %s" %str(constraint_dir))
    print("==================================================================")

def clear_fixed_constraint():
    JPT.ClearLog()
    for fixed_constrains in JPT.GetAllByTypeID(37):
        JPT.Exec('DeleteItem(0, [37:{}], [], [], 1)'.format(fixed_constrains.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the applied constraints!")
    print("==================================================================")

def apply_force(force_name, force_x, force_z):
    JPT.ClearLog()
    selected_edges = ""
    for edge in JPT.GetSelectedEdges():
        if force_x == "":
            force_x = 0
        else:
            force_x = float(force_x)
        if force_z == "":
            force_z = 0
        else:
            force_z = float(force_z)
        JPT.Exec('ForceGeneral("{0}", [{1}, 0, {2}], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], \
0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [5:{3}], 0:0)'.\
            format(force_name, force_x, force_z, edge.id))
        selected_edges += str(edge.id) + ", "
    JPT.ClearLog()
    selected_edges = selected_edges[:-2]
    print("==================================================================")
    print("Force information: ")
    print("--- Selected edges (ID): %s" %str(selected_edges))
    print("--- Fixed direction:")
    print("------- X direction: %s" %str(float(force_x)))
    print("------- Z direction: %s" %str(float(force_z)))
    print("==================================================================")

def clear_force():
    JPT.ClearLog()
    for force in JPT.GetAllByTypeID(29):
        JPT.Exec('DeleteItem(0, [29:{}], [], [], 1)'.format(force.id))
    JPT.ClearLog()
    print("==================================================================")
    print("Deleted all the applied forces!")
    print("==================================================================")

def export_and_run_calculation(dlg):
    JPT.ClearLog()
    file_name = dlg.get_item_text("part_name")
    output_folder = dlg.get_item_text("open_folder_for_saving")
    if output_folder != "":
        if os.path.isdir(output_folder) == False:
            print("[Warning]: Inputted folder is not exist!")
            print("--- Creating {0} folder".format(output_folder))
            os.mkdir(output_folder)
            print("--- Created {0} folder".format(output_folder))
        if file_name == "":
            message = "The part name is blanked. The exported file will use the inputted part's name. \
If part's name is blanked, 'Test.bdf' will be used. \
Do you want to continue?"
            title = "Warning!"
            result = ctypes.windll.user32.MessageBoxW(0, message, title, 0x04)
            if result == 6:
                file_name = 'Test'
                full_path_to_saved_folder = re.sub("//", "/", re.sub(re.escape("\\"), "/", output_folder))
                full_path_bdf_file = full_path_to_saved_folder + "/" + file_name + ".bdf"
                ts_ss_job = 'TSSS_LinearStatic("{0}", "", [], 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1.79769e+308, 2147483647, \
1, 2, 0, 1, 101, "", [1.79769e+308, 1.79769e+308, 2147483647], [0, 1.79769e+308, 1.79769e+308, \
2147483647, 0, 0, 1.79769e+308, 1.79769e+308, 2147483647], [1.79769e+308, 1.79769e+308, 2147483647, 0], \
[2147483647, 1.79769e+308, 2147483647, 2, 0], [2147483647, 2147483647, 2147483647, 2147483647, 2147483647, \
2147483647, 2147483647, 0, 0, 2147483647, 0, 0, 0, 0, 0, 0, 0, 2147483647, 2147483647, 1, 0, 0, 0, 1, 0, 0, 0, \
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0], [0, ""], [2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647], \
[-1, 0, 0, "", "", "", "", 2147483647, 2, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, \
0, 2147483647, 1, 0], [1, 3, 2147483647, 0, 0, 1, 1.79769e+308, 1.79769e+308, 0.01], [2147483647, 1.79769e+308, 2147483647], \
[], "", "", "", "", "", 0, 2147483647, [], 0:0, "{1}", 0, 0, 0)'\
                                .format(file_name, full_path_bdf_file)
                JPT.Exec(ts_ss_job)
                bat_file_contents = 'setlocal\n\nset filename=%%1\nset ss_working_dir=%%2\n\nif %%filename%%=="" \
goto nofile\ncall:get_path %%ss_working_dir%% cwd\n\nset cwd=%%3\n\nif %%cwd%%=="" \
goto nocwd\n\ncall :get_drive %%cwd%% drive\ncd %%cwd%%\n%%drive%%\n\n%%ss_working_dir%% %%filename%%\n\
goto eof\n\n:nofile\necho ERROR : Input file not selected\ngoto :eof\n\n:nocwd\n\
echo ERROR : Working directory not selected\ngoto :eof\n\n:eof\nendlocal\n\
goto :eof\n\n:get_drive \nset "%%~2=%%~d1"\ngoto :eof\n\n:get_path \nset "%%~2=%%~dp1"\ngoto :eof'
                bat_file_contents = re.sub(re.escape("%%"), r"%", bat_file_contents)
                bat_file = output_folder + "\\start_ts_ss.bat"
                jupiter_installation_folder = JPT.GetAppPathInfo(0)
                bat_file_param_1 = re.sub("/", re.escape("\\"), full_path_bdf_file)
                bat_file_param_2 = jupiter_installation_folder + r"SunShine\sunshine.exe"
                bat_file_param_3 = re.sub("/", re.escape("\\"), full_path_to_saved_folder)
                with open (bat_file, "w") as f:
                    f.writelines(bat_file_contents)
                run_sunshine = subprocess.Popen([bat_file,
                                                bat_file_param_1,
                                                bat_file_param_2,
                                                bat_file_param_3],
                                                stdout=subprocess.PIPE)
                run_sunshine.wait()
                rc = run_sunshine.returncode
                check_result = False
                if str(rc).strip() == "0":
                    for root, dirs, files in os.walk(bat_file_param_3):
                        for file in files:
                            if file.lower().find(".op2") != -1:
                                check_result = True
                                op2_file = re.sub(re.escape("\\"), "/", root + "\\" + file)
                                break
                        if check_result == True:
                            break
                else:
                    JPT.ClearLog()
                    print("[Error]: Calculation process is stopped without exporting op2 file")
                if check_result == True:
                    JPT.ClearLog()
                    ctypes.windll.user32.MessageBoxW(0, "Calculation step is done!", "FINISHED", 0x0 | 0x40)
                    print(" FINISHED ".center("+", 30))
                    print("The result file is saved at:")
                    print("--- %s" %str(op2_file))
                    print("+"*30)
                else:
                    JPT.ClearLog()
                    ctypes.windll.user32.MessageBoxW(0, "Calculation is stopped with an error", "Error", 0x0 | 0x10)
                    print(" Error ".center(30, "+"))
                    print("An error has occurred while calculating")
                    print("+"*30)
            else:
                JPT.ClearLog()
                print("Please input the part's name in the Geometry tab")
        else:
            JPT.ClearLog()
            full_path_to_saved_folder = re.sub("//", "/", re.sub(re.escape("\\"), "/", output_folder))
            full_path_bdf_file = full_path_to_saved_folder + "/" + file_name + ".bdf"
            ts_ss_job = 'TSSS_LinearStatic("{0}", "", [], 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1.79769e+308, 2147483647, \
1, 2, 0, 1, 101, "", [1.79769e+308, 1.79769e+308, 2147483647], [0, 1.79769e+308, 1.79769e+308, 2147483647, \
0, 0, 1.79769e+308, 1.79769e+308, 2147483647], [1.79769e+308, 1.79769e+308, 2147483647, 0], \
[2147483647, 1.79769e+308, 2147483647, 2, 0], [2147483647, 2147483647, 2147483647, 2147483647, 2147483647, \
2147483647, 2147483647, 0, 0, 2147483647, 0, 0, 0, 0, 0, 0, 0, 2147483647, 2147483647, 1, 0, 0, 0, 1, 0, 0, \
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0], [0, ""], [2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647], \
[-1, 0, 0, "", "", "", "", 2147483647, 2, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 0, \
2147483647, 1, 0], [1, 3, 2147483647, 0, 0, 1, 1.79769e+308, 1.79769e+308, 0.01], [2147483647, 1.79769e+308, 2147483647], \
[], "", "", "", "", "", 0, 2147483647, [], 0:0, "{1}", 0, 0, 0)'\
                            .format(file_name, full_path_bdf_file)
            JPT.Exec(ts_ss_job)
            bat_file_contents = 'setlocal\n\nset filename=%%1\nset ss_working_dir=%%2\n\nif %%filename%%=="" \
goto nofile\ncall:get_path %%ss_working_dir%% cwd\n\nset cwd=%%3\n\nif %%cwd%%=="" \
goto nocwd\n\ncall :get_drive %%cwd%% drive\ncd %%cwd%%\n%%drive%%\n\n%%ss_working_dir%% %%filename%%\n\
goto eof\n\n:nofile\necho ERROR : Input file not selected\ngoto :eof\n\n:nocwd\n\
echo ERROR : Working directory not selected\ngoto :eof\n\n:eof\nendlocal\ngoto :eof\n\n:get_drive \nset "%%~2=%%~d1"\n\
goto :eof\n\n:get_path \nset "%%~2=%%~dp1"\ngoto :eof'
            bat_file_contents = re.sub(re.escape("%%"), r"%", bat_file_contents)
            bat_file = output_folder + "\\start_ts_ss.bat"
            jupiter_installation_folder = JPT.GetAppPathInfo(0)
            bat_file_param_1 = re.sub("/", re.escape("\\"), full_path_bdf_file)
            bat_file_param_2 = jupiter_installation_folder + r"SunShine\sunshine.exe"
            bat_file_param_3 = re.sub("/", re.escape("\\"), full_path_to_saved_folder)
            with open (bat_file, "w") as f:
                f.writelines(bat_file_contents)
            run_sunshine = subprocess.Popen([bat_file,
                                                bat_file_param_1,
                                                bat_file_param_2,
                                                bat_file_param_3],
                                                stdout=subprocess.PIPE)
            run_sunshine.wait()
            rc = run_sunshine.returncode
            check_result = False
            if str(rc).strip() == "0":
                for root, dirs, files in os.walk(bat_file_param_3):
                    for file in files:
                        if file.lower().find(".op2") != -1:
                            check_result = True
                            op2_file = re.sub(re.escape("\\"), "/", root + "\\" + file)
                            break
                    if check_result == True:
                        break
            else:
                JPT.ClearLog()
                print("[Error]: Calculation process is stopped without exporting op2 file")
            if check_result == True:
                JPT.ClearLog()
                ctypes.windll.user32.MessageBoxW(0, "Calculation step is done!", "FINISHED", 0x0 | 0x40)
                print(" FINISHED ".center(30, "+"))
                print("The result file is saved at:")
                print("--- %s" %str(op2_file))
                print("+"*30)
            else:
                JPT.ClearLog()
                ctypes.windll.user32.MessageBoxW(0, "Calculation is stopped with an error", "Error", 0x0 | 0x10)
                print(" Error ".center("+", 30))
                print("An error has occurred while calculating")
                print("+"*30)
    else:
        JPT.ClearLog()
        ctypes.windll.user32.MessageBoxW(0, "Please input output folder!", "Error", 0x0 | 0x10)

def main():
    dlg=JDGCreator(title="Plane Stress",resizable=True,validation=True)
    #
    dlg.add_layout(name="Layout2",orientation=orientation.vertical,layout="Window")
    #
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Layout2")
    sample_folder = re.sub(re.escape("\\"), "/", (JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH) + \
                                                  r'SampleData\PSJ\PSJ-GUI\PlaneStress\PlaneStress_Pics'))
    picture_file = sample_folder + "/PlaneStress_2D_pic.PNG"
    dlg.add_imagectrl(name="ImageCtrl",image_file=picture_file,layout="Layout1")
    #
    dlg.add_tabwnd(name="TabCtrl2",width=400,height=270,layout="Layout2")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem7",page_text="Geometry")
    #
    dlg.add_layout(name="Layout7",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="get_name",text="Part name",width=80,layout="Layout7")
    dlg.add_textbox(name="part_name",text="planestress_model1",type="string",layout="Layout7")
    dlg.add_separator(name="Separator6",layout="Layout7")
    #
    dlg.add_layout(name="Layout16",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="Label17",text="Coordinate ",width=80,layout="Layout16")
    dlg.add_combobox(name="ComboBox27",options=["Global"],layout="Layout16")
    dlg.add_separator(name="Separator7",layout="Layout16")
    #
    dlg.add_layout(name="Layout19",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="width",text="Width",width=80,layout="Layout19")
    dlg.add_textbox(name="get_width",text="20.0",type="double",layout="Layout19")
    dlg.add_separator(name="Separator8",layout="Layout19")
    #
    dlg.add_layout(name="Layout22",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="Label23",text="Heigth",width=80,layout="Layout22")
    dlg.add_textbox(name="get_height",text="10.0",type="double",layout="Layout22")
    dlg.add_separator(name="Separator9",layout="Layout22")
    #
    dlg.add_layout(name="Layout25",orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_label(name="Label26",text="Hole Rad",width=80,layout="Layout25")
    dlg.add_textbox(name="get_radius",text="1.0",type="double",layout="Layout25")
    dlg.add_separator(name="Separator10",layout="Layout25")
    #
    dlg.add_layout(name="Layout44",margin=[10,10,0,0],orientation=orientation.horizontal,layout="TabItem7")
    dlg.add_button(name="apply_geometry",text="Apply",width=80,height=30,layout="Layout44")
    dlg.add_button(name="clear_geometry",text="Clear",width=80,height=30,layout="Layout44")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem26",page_text="Meshing")
    #
    dlg.add_layout(name="Layout29",orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_label(name="Label30",text="Average Size",width=100,layout="Layout29")
    dlg.add_textbox(name="avg_size",text="0.5",type="double",layout="Layout29")
    #
    dlg.add_layout(name="Layout30",orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_label(name="Label31",text="Minimum Size",width=100,layout="Layout30")
    dlg.add_textbox(name="min_size",text="0.1",type="double",layout="Layout30")
    #
    dlg.add_layout(name="Layout31",orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_label(name="Label32",text="Maximum Size",width=100,layout="Layout31")
    dlg.add_textbox(name="max_size",text="1.0",type="double",layout="Layout31")
    #
    dlg.add_layout(name="Layout38",margin=[0,10,0,0],orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_checkbox(name="second_element",text="Second Order Element",checked=True,layout="Layout38")
    #
    dlg.add_layout(name="Layout37",margin=[10,10,0,0],orientation=orientation.horizontal,layout="TabItem26")
    dlg.add_button(name="generate_meshing",text="Apply",width=80,height=30,layout="Layout37")
    dlg.add_button(name="undo_meshing",text="Undo meshing",width=80,height=30,layout="Layout37")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem41",page_text="Properties")
    #
    dlg.add_layout(name="Layout41",orientation=orientation.horizontal,layout="TabItem41")
    dlg.add_label(name="Label44",text="Material",layout="Layout41")
    dlg.add_combobox(name="list_material",options=["Copper Alloy","Manesium Alloy","Concrete","Structural Steel","Stainless Steel"],layout="Layout41")
    #
    dlg.add_layout(name="Layout42",margin=[0,10,0,0],orientation=orientation.horizontal,layout="TabItem41")
    dlg.add_button(name="apply_property",text="Apply",width=60,height=30,layout="Layout42")
    dlg.add_button(name="clear_property",text="Clear",width=60,height=30,layout="Layout42")
    #
    dlg.add_tabwnd_page(name="TabCtrl2",page_name="TabItem48",page_text="LBCs")
    #
    dlg.add_layout(name="Layout55",margin=[0,0,0,5],orientation=orientation.horizontal,layout="TabItem48")
    dlg.add_groupbox(name="group_fixed_constraint",text="Fixed Condition",layout="Layout55")
    #
    dlg.add_layout(name="Layout52",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_fixed_constraint")
    dlg.add_label(name="Label49",text="Name",width=80,layout="Layout52")
    dlg.add_textbox(name="constraint_name",text="FixedConstraint_1",type="string",layout="Layout52")
    #
    dlg.add_layout(name="Layout51",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_fixed_constraint")
    dlg.add_label(name="Label52",text="Direction",layout="Layout51")
    dlg.add_checkbox(name="x_direction",text="X direction",checked=True,layout="Layout51")
    dlg.add_checkbox(name="z_direction",text="Z direction",width=70,checked=True,layout="Layout51")
    #
    dlg.add_layout(name="Layout68",margin=[30,0,0,0],orientation=orientation.horizontal,layout="group_fixed_constraint")
    dlg.add_button(name="apply_fixed_constraint",text="Apply",width=60,height=30,layout="Layout68")
    dlg.add_button(name="clear_fixed_constraint",text="Clear",width=60,height=30,layout="Layout68")
    #
    dlg.add_layout(name="Layout58",margin=[0,0,0,2],orientation=orientation.horizontal,layout="TabItem48")
    dlg.add_groupbox(name="group_force_condition",text="Force Condition",layout="Layout58")
    #
    dlg.add_layout(name="Layout61",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_label(name="Label62",text="Name",width=80,layout="Layout61")
    dlg.add_textbox(name="force_name",text="ForceConstraint_1",type="string",layout="Layout61")
    #
    dlg.add_layout(name="Layout63",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_label(name="force_x_label",text="X direction",width=80,layout="Layout63")
    dlg.add_textbox(name="force_x",text="-10.0",type="double",layout="Layout63")
    #
    dlg.add_layout(name="Layout70",margin=[0,0,0,2],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_label(name="force_z_label",text="Z direction",width=80,layout="Layout70")
    dlg.add_textbox(name="force_z",text="0.0",type="double",layout="Layout70")
    #
    dlg.add_layout(name="Layout72",margin=[30,0,0,0],orientation=orientation.horizontal,layout="group_force_condition")
    dlg.add_button(name="apply_force",text="Apply",width=60,height=30,layout="Layout72")
    dlg.add_button(name="clear_force",text="Clear",width=60,height=30,layout="Layout72")
    dlg.add_edge_selector()
    #
    dlg.add_groupbox(name="GroupBox1",text="Select folder",layout="Window")
    dlg.add_label(name="Label111",width=200,text="Select folder to export the result",layout="GroupBox1")
    dlg.add_browser(name="open_folder_for_saving",mode="folder",file_filter="All Files(*.*)",layout="GroupBox1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Export and run the calculation",width=200,height=30,layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",width=100,height=30,layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    #
    dlg.on_command("apply_geometry", create_geometry)
    dlg.on_command("clear_geometry", clear_geometry)
    dlg.on_command("generate_meshing", generate_meshing)
    dlg.on_command("undo_meshing", undo_meshing)
    dlg.on_command("apply_property", apply_property)
    dlg.on_command("clear_property", clear_property)
    dlg.on_command("apply_fixed_constraint", apply_fixed_constraint)
    dlg.on_command("clear_fixed_constraint", clear_fixed_constraint)
    dlg.on_command("apply_force", apply_force)
    dlg.on_command("clear_force", clear_force)
    dlg.on_command("ButtonApply", export_and_run_calculation)
    #
    dlg.generate_window()

if __name__=='__main__':
    main()

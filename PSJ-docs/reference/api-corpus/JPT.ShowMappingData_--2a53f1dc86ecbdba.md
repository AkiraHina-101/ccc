# JPT.ShowMappingData()

JPT.ShowMappingData()

Description​

Show specified mapping contour on current model.

Syntax​

JPT.ShowMappingData(...)

Inputs​

DItemObject​

A DItem object which will be display contour.

This is a required input.

BoolType​

A Boolean that controls the data display type when Convection Mapping is selected.

True: Display Temperature data.

False: Display Heat Transfer Coefficient data.

The default value is False.

Return Code​

This utility function does not have output value.

Sample Code​

import os
import csv
import itertools

def write_node_data(filename, node_data):
    headers = [
        'nodenumber', 
        'x-coordinate', 
        'y-coordinate', 
        'z-coordinate', 
        'temperature', 
        'heat-transfer-coef'
    ]

    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)    
        writer.writerow(headers)
        for node in node_data:
            writer.writerow(node)

def generate_conv_data(
    size=5, 
    start_pos=-10, 
    step=5, 
    start_temp=-100, 
    temp_step=10, 
    start_coef=0.01, 
    coef_step=0.01
):
    positions = [start_pos + i * step for i in range(size)]
    nodes = [
        [i + 1, x, y, z, start_temp + i * temp_step, start_coef + i * coef_step]
        for i, (x, y, z) in enumerate(itertools.product(positions, repeat=3))
    ]

    return nodes

def setup_mapping_view():
    JPT.DisableScreenAnimation()
    JPT.ViewFitToModel()
    conv_map = JPT.GetEntitiesByID(JPT.EntityType.LBC_MAPPING_THERMAL_CONVECTION, 1)[0]
    JPT.ShowMappingData(conv_map)

def save_mapping_image(image_path):
    MainWindow.RightClick.ShowHideAllToolbar(iType=1, bShow=False)
    Home.ToImage(strImgPath=image_path)
    MainWindow.RightClick.ShowHideAllToolbar(iType=1, bShow=True)

def apply_convection_mapping(csv_path):
    BoundaryConditions.Convection.SurfaceMapping(
        strName="MappingConvection_1", 
        crlTargets=[Face(24, 26, 22)], 
        iPos=2, 
        iCp=2, 
        iMappedCpIndex0=1, 
        dSearchRange=0.0, 
        iTempUnit=1, 
        strPath=csv_path
    )

def main():
    temp_path = JPT.GetAppPathInfo(JPT.PathType.TEMP_PATH)
    csv_path = os.path.join(temp_path, 'node_data.csv')
    image_path = os.path.join(temp_path, "conv_img.png")

    #Prepare mapping data (convection)
    nodes = generate_conv_data()
    write_node_data(csv_path, nodes)

    #Preapre Model
    Geometry.Part.Cube(iPartColor=6409934)
    apply_convection_mapping(csv_path)

    #Show mapping result and save image
    setup_mapping_view()
    save_mapping_image(image_path)

if __name__ == "__main__":
    main()

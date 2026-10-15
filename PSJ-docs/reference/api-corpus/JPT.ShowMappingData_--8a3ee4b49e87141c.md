# JPT.ShowMappingData()

JPT.ShowMappingData()

説明​

現在のモデルに指定されたマッピング輪郭を表示します。

構文​

JPT.ShowMappingData(...)

入力​

DItemObject​

表示される DItem オブジェクト。

これは必須の入力です。

BoolType​

対流マッピング（Convection Mapping）が選択されている場合に、データ表示タイプを制御する Boolean 値です。

True: 温度データを表示

False: 熱伝達係数データを表示

デフォルト値は False です。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

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

    #マッピングデータ（対流）の準備
    nodes = generate_conv_data()
    write_node_data(csv_path, nodes)

    #モデルの準備
    Geometry.Part.Cube(iPartColor=6409934)
    apply_convection_mapping(csv_path)

    #マッピング結果の表示と画像の保存
    setup_mapping_view()
    save_mapping_image(image_path)

if __name__ == "__main__":
    main()

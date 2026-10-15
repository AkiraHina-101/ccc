# パートIDからプロパティを取得します

パートIDからプロパティを取得します

🎯 導入​

このチュートリアルでは、パートのIDからプロパティを取得する方法を学びます。

財産の資料を作成します。

2つのシェルプロパティの作成：1つ目は第1キューブパート用で、2番目は2番目と3番目のキューブパート用です。

現在のモデルですべてのパートと2Dシェルプロパティのリストを取得します。

パートのIDからプロパティを取得する関数を定義します。

パートIDからプロパティを取得します。Python APIウィンドウで対応するプロパティID、プロパティ名、パートID、パート名を表示します。

📖 チュートリアル​

# Python APIウィンドウでログメッセージをクリアします
JPT.ClearLog()

# 3つのキューブパートを作成します
cube1 = Geometry.Part.Cube(iPartColor=12999622)
cube2 = Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], dlLength=[0.02, 0.01, 0.01], strName="Cube_2", iPartColor=5093709)
cube3 = Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], dlLength=[0.03, 0.01, 0.01], strName="Cube_3", iPartColor=6118877)

# ディスプレイビューのモデルのビューをフィットします
JPT.ViewFitToModel()

# 素材を作成します
Properties.Material.Add("Structural_Steel", [Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])

# 2つのシェルプロパティを作成します。最初はCube1パートです。2番目は、Cube2およびCube3パート用です
Properties.Shell(strName="シェルプロパティ1の Cube1", iPropertyId=1, dThickness=0.005, crlTargets=[cube1],
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1) )
Properties.Shell(strName="シェルプロパティ2の Cube2-3", iPropertyId=2, dThickness=0.01, crlTargets=[cube2, cube3],
    crMatMembrane=Material(1), crMatBend=Material(1), crMatShear=Material(1) )

# 現在のモデルですべてのパートと2Dシェルプロパティのリストを取得する
listPart = JPT.GetAllParts()
listProp = JPT.GetAllByType(JPT.DItemType.PROPERTY_2D_SHELL)

# パートのIDからプロパティを取得する関数を定義します
def GetPropertyFromPartID(partID):
    for prop in listProp:
        listAssosicatedPart = prop.targets
        for assoPart in listAssosicatedPart:
            if assoPart.id == partID:
                return prop

# すべてのパートリストの各部分をループすることにより、パートのIDからプロパティを取得します
# Python APIウィンドウで各パートのパート名、プロパティID、プロパティ名を表示リストパートの一部の場合：
    foundProperty = GetPropertyFromPartID(part.id)
    print("プロパティID: {} | プロパティ名： {} | パートID： {} | パート名： {} "
    .format(foundProperty.id,foundProperty.name,part.id,part.name))

# JPT.SaveToMLIB()

JPT.SaveToMLIB()

説明​

ドキュメント内の材料を.mlibファイルに保存します。

構文​

JPT.SaveToMLIB(...)

入力​

strFileName​

保存する.mlibファイルへのパスを指定する String です。

これは必須入力です。

bAppendToCurrentMlib​

現在のライブラリ内の材料も保存かどうかを指定する Boolean 値です。

これは必須入力です。

crlMaterials​

セーブする材料を指定する CursorStr のリストです。

デフォルト値は[]です。

戻り値​

True : 実行成功

False : 実行失敗

サンプルコード​

# Create materials in User Data Base.
Properties.Material.Add(
    strMaterialName="MyMaterial1",
    dictMaterialProperty={
        'Density': {
            'density': {
                'DENSITY': [8300.0]}}, 
        'Elastic': {
            'elastic': {
                'YOUNGS_MODULUS': [110000000000.0], 
                'POISSONS_RATIO': [0.34]}}}, 
    iMaterialID=1, 
    iMaterialColor=7901428)

Properties.Material.Add(
    strMaterialName="MyMaterial2", 
    dictMaterialProperty={
        'Density': {
            'density': {
                'DENSITY': [2770.0]}}, 
        'Elastic': {
            'elastic': {
                'YOUNGS_MODULUS': [71000000000.0], 
                'POISSONS_RATIO': [0.33]}}}, 
     iMaterialID=2, 
    iMaterialColor=11052963)

# Get all materials from current user data base. 
strCrlMaterials=[mat.id for mat in JPT.GetAllMaterials()]
strMlibFileName = "C:/Temp/new.mlib" 

crlMaterials=Material(*[mat.id for mat in JPT.GetAllMaterials()])

JPT.SaveToMLIB(
    strFileName=strMlibFileName, 
    crlMaterials=[crlMaterials], 
    bAppendToCurrentMlib=True # Include all the materials in Library Data Base
)

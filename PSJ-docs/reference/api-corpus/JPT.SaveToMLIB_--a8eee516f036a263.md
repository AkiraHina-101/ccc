# JPT.SaveToMLIB()

JPT.SaveToMLIB()

Description​

Save materials in document to *.mlib file.

Syntax​

JPT.SaveToMLIB(...)

Inputs​

strFileName​

A String specifying the path of *.mlib file to save.

This is a required input.

bAppendToCurrentMlib​

A Boolean specifying whether the materials in current library also copied in the *.mlib file.

This is a required input.

crlMaterials​

A List of Cursor specifying the materials needed to save.

The default value is [].

Return Code​

True : The function can be executed

False : The function cannot be executed

Sample Code​

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

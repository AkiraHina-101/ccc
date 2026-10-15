# DMaterial

DMaterial

Description​

This is an instance of a DMaterial class, represents user material item inside Jupiter.

Properties​

 | Attribute | Description

 | name | Name of the material.
The return value is a string name (str).

 | description | Description of the material.
The return value is a string description (str).

 | isComposite | Determine whether is is a composite material.

 | id | External ID of the material.
ID cannot be duplicated.
ID can be changed using the renumbering function.
The return value is ID (int).

 | color* 1 | Material color information.
This value can be adjusted.
The return value is a RGB color.

 | matStandard | Determine the standard of the material.
 The return value is a standard of SD_JIS, SD_ISO, SD_AISI, SD_SAE, SD_BS, SD_DIN, SD_EN, SD_NF, or SD_OCT.

 | dictMatProps | All material properties information.
The return value is a dictionary.

 | GetValues | Get and convert the material property value.
The return value is a list of material value (double).

 | SetValues | Set and convert the new material property value.
The return value is a dictionary.

Attribute​

GetValues​

keys​

A List of String specifying the keys of material property.

This is a required input.

unit​

An Enum specifying the unit of material to be converted.

For the material property with unit, the unit should be specified.

For the non-unit material property, the unit should be set by None, -1, or set it empty.

The default value is -1.

Sample Code

Properties.Material.Add(strMaterialName="Structural_Steel", 
                        listMaterialProperty=[
                        Density(density=[
                            (DENSITY, [7850.000000000001])]), 
                            Elastic(elastic=[(YOUNGS_MODULUS, [200000000000.0]), 
                            (POISSONS_RATIO, [0.3])]), 
                        Expansion(expansion=[
                            (ALPHA, [1.2e-05])]), 
                            Conductivity(conductivity=[(CONDUCTIVITY, [59.0])]), 
                            SpecificHeat(specificHeat=[(SPECIFIC_HEAT, [461.0])])], 
                        iMaterialID=5, 
                        iMaterialColor=10264731)
mat0 = JPT.GetAllMaterials()[0]
dict1 = mat0.dictMatProps
list_keys=['Density', 'density', 'DENSITY']
unit=JPT.DensityUnit.Density_kg_m3
pprint(mat0.GetValues(keys=list_keys, unit=unit))
pprint(mat0.SetValues(values=[8500], keys=list_keys, unit=unit))

SetValues​

values​

A List of Double specifying the new material property value will be set.

This is a required input.

keys​

A List of String specifying the keys of material property.

This is a required input.

unit​

An Enum specifying the unit of material to be converted.

For the material property with unit, the unit should be specified.

For the non-unit material property, the unit should be set by None, -1, or set it empty.

The default value is -1.

Sample Code

Properties.Material.Add(strMaterialName="Structural_Steel", 
                        listMaterialProperty=[
                        Density(density=[
                            (DENSITY, [7850.000000000001])]), 
                            Elastic(elastic=[(YOUNGS_MODULUS, [200000000000.0]), 
                            (POISSONS_RATIO, [0.3])]), 
                        Expansion(expansion=[
                            (ALPHA, [1.2e-05])]), 
                            Conductivity(conductivity=[(CONDUCTIVITY, [59.0])]), 
                            SpecificHeat(specificHeat=[(SPECIFIC_HEAT, [461.0])])], 
                        iMaterialID=5, 
                        iMaterialColor=10264731)
mat0 = JPT.GetAllMaterials()[0]
dict1 = mat0.dictMatProps
list_keys=['Density', 'density', 'DENSITY']
unit=JPT.DensityUnit.Density_kg_m3
pprint(mat0.GetValues(keys=list_keys, unit=unit))
new_dict=mat0.SetValues(values=[8500], keys=list_keys, unit=unit))
pprint(new_dict)
Properties.Material.Modify(strMaterialName="Structural_Steel", 
                            listMaterialProperty=new_dict, 
                            iMaterialID=5, 
                            iMaterialColor=10264731)

Notice​

Footnotes​

The attribute can be changed/assigned from the current to the new value. ↩

# DMaterialLib

DMaterialLib

Description​

This is an instance of a DMaterialLib class, represents library material item inside Jupiter.

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

mat0 = JPT.GetAllLibraryMaterials()[0]
dict1 = mat0.dictMatProps
list_keys=['Density', 'density', 'DENSITY']
unit=JPT.DensityUnit.Density_kg_m3
pprint(mat0.GetValues(keys=list_keys, unit=unit))

Notice​

Footnotes​

The attribute can be changed/assigned from the current to the new value. ↩

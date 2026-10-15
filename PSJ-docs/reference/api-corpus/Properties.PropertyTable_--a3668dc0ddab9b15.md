# Properties.PropertyTable()

Properties.PropertyTable()

Description​

This method renumbers property/material ID according to the input ID numbers.

Syntax​

Properties.PropertyTable(listRenumberProp=[])

Ribbon: Properties » PropertyTable

Inputs​

listRenumberProp​

A RENUMBER_PROP List specifying the list of properties will be renumbered.

The default value is [RENUMBER_PROP].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Geometry.Part.Cube(iPartColor=11817908)
Properties.Material.Add("Structural_Steel", [Density([(DENSITY, 7.85e-09)]), 
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])])
Properties.Material.Add("Aluminum_Alloy", [Density([(DENSITY, 2.77e-09)]), 
    Elastic([(YOUNGS_MODULUS, 71000.0), (POISSONS_RATIO, 0.33)])])
Properties.Solid(crlTargets=[Part(1)], strName="Solid Property 1", iPropertyColor=16059195, 
    crMaterial=Material(1), iCordM=-2, dDispHG=DFLT_DBL, iFLG=-1)

result = Properties.PropertyTable(listRenumberProp=[RENUMBER_PROP(crTarget=Property3DSolid(1), 
    crMat=Material(1), newId=10)])
print (str(result)) #for checking return value

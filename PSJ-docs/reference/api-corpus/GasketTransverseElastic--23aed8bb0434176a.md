# GasketTransverseElastic

GasketTransverseElastic

Description​

This is an instance of a GasketTransverseElastic class, represents GasketTransverseElastic characteristic of material.

Properties​

 | Attribute | Description

 | gasketTransverseElastic | A List of Tuple specifying all data of GasketTransverseElastic characteristic. 
 The data includes SHEAR_STIFFNESS_H, TEMPERATURE_H, EXTRA_FIELDS_H, SHEAR_STIFFNESS_V, TEMPERATURE_V, and EXTRA_FIELDS_V.

 | temperatureDependencyH | A Boolean specifying the use of temperature in horizontal transverse.

 | dependenciesH | An Integer specifying the number of dependencies in temperature (horizontal transverse).

 | unitH | An Integer specifying the unit type of horizontal transverse.

 | unitV | An Integer specifying the unit type of vertical transverse

 | temperatureDependencyV | A Boolean specifying the use of temperature in vertical transverse.

 | dependenciesV | An Integer specifying the number of dependencies in temperature (vertical transverse).

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) #for checking return value

# GasketThickness

GasketThickness

Description​

This is an instance of a GasketThickness class, represents GasketThickness characteristic of material.

Properties​

 | Attribute | Description

 | gasketThickness | A List of Tuple specifying all data of GasketThickness characteristic. 
 The data includes PRESSURE_FORCE_LOADING, CLOSURE_LOADING, TEMPERATURE_LOADING, EXTRA_FIELDS_LOADING, PRESSURE_FORCE_UNLOADING, CLOSURE_UNLOADING, PLASTIC_MAX_CLOSURE_UNLOADING, TEMPERATURE_UNLOADING, and EXTRA_FIELDS_UNLOADING.

 | type | An Integer specifying the type of gasket thickness behavior.

 | unit | An Integer specifying the unit.

 | yieldMethod | An Integer specifying the yielding method.

 | yieldValue | A Float specifying the value of yielding.

 | tensileType | A Integer specifying the tensile stiffness factor/value type.

 | tensileValue | An Float specifying the value of tensile.

 | loadingTempDepend | A Boolean specifying the use of temperature in loading.

 | loadingDependency | An Integer specifying the number of dependencies in temperature (loading).

 | unloadingTempDepend | An Boolean specifying the use of temperature in unloading.

 | unloadingDependency | An Integer specifying the number of dependencies in temperature (unloading).

 | unloadingIncludeCurve | An Boolean specifying the use of user-defined curve.

Sample Code​

structure_steel = Properties.Material.Add(strMaterialName="Structural_Steel",
    listMaterialProperty=[Density([(DENSITY, 7.85e-09)]),
    Elastic([(YOUNGS_MODULUS, 200000.0), (POISSONS_RATIO, 0.3)])],
    iMaterialID=5)

JPT.Debugger(structure_steel) #for checking return value

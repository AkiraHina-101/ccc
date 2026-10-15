# GasketThicknessBehavior

GasketThicknessBehavior

Description​

This is an instance of a GasketThicknessBehavior class, represents GasketThickness characteristic of material.

Properties​

 | Attribute | Description

 | gasketThickness | A List of Tuple specifying all data of GasketThickness characteristic.

 | type | An Integer specifying the type of gasket thickness behavior.

 | unit | An Integer specifying the unit of gasket thickness behavior.

 | yieldMethod | An Integer specifying the yield generation rule.

 | yieldValue | A Float specifying the yielding value.

 | tensileType | A Integer specifying the tensile stiffness factor/value type.

 | tensileValue | An Float specifying the tensile stiffness factor/value corresponding to the selected tensileType.

 | loadingTempDepend | A Boolean specifying whether to use the temperature-dependence data (loading curve).

 | loadingDependency | An Integer specifying the number of field variables (loading curve).

 | unloadingTempDepend | An Boolean specifying whether to use the temperature-dependence data (unloading curve).

 | unloadingDependency | An Integer specifying the number of dependencies in temperature (unloading).

 | unloadingIncludeCurve | An Boolean specifying whether to include the user-specified unloading curve.

GasketThickness Characteristic​

Either KEY NAME or ID can be used to define the material property.
The ID of material property which was primarily used in functions can be referred to in the Int Notation column.
However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.
For example: PRESSURE_FORCE_LOADING is equal to ID = 63.

 | INT Notation | Key Name | Description

 | 63 | PRESSURE_FORCE_LOADING | A Tuple specifying the pressure force data of loading curve.

 | 64 | CLOSURE_LOADING | A Tuple specifying the closure data of loading curve.

 | 134 | TEMPERATURE_LOADING | A Tuple specifying the temperature-dependent data of loading curve.

 | 147 | EXTRA_FIELDS_LOADING | A Tuple specifying the extra field data of loading curve.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[GasketThickness(gasketThickness=[
                                        (PRESSURE_FORCE_LOADING, [100.0]), 
                                        (CLOSURE_LOADING, [50.0]), 
                                        (TEMPERATURE_LOADING, [300.0])], 
                                        unit=1, yieldMethod=3, 
                                        yieldValue=0.1, 
                                        tensileType=1, 
                                        tensileValue=0.001, 
                                        loadingTempDepend=True)], 
                                        iMaterialID=1, i
                                        MaterialColor=13770132, 
                                        strDescription="GasketThicknessBehavior")
JPT.Debugger(sample_Mat) #for checking return value

 | INT Notation | Key Name | Description

 | 65 | PRESSURE_FORCE_UNLOADING | A Tuple specifying the pressure force data of unloading curve.

 | 66 | CLOSURE_UNLOADING | A Tuple specifying the closure data of unloading curve.

 | 67 | PLASTIC_MAX_CLOSURE_UNLOADING | A Tuple specifying the plastic max closure data of unloading curve.

 | 135 | TEMPERATURE_UNLOADING | A Tuple specifying the temperature-dependent data of unloading curve.

 | 148 | EXTRA_FIELDS_UNLOADING | A Tuple specifying the extra field data of unloading curve.

Sample Code

sample_Mat = Properties.Material.Add(strMaterialName="Sample_Material", 
                                    listMaterialProperty=[GasketThickness(gasketThickness=[
                                        (PRESSURE_FORCE_UNLOADING, [100.0]), 
                                        (CLOSURE_UNLOADING, [50.0]), 
                                        (PLASTIC_MAX_CLOSURE_UNLOADING, [150.0]), 
                                        (TEMPERATURE_UNLOADING, [200.0])], 
                                        unit=1, 
                                        yieldMethod=3, 
                                        yieldValue=0.1, 
                                        tensileType=1, 
                                        tensileValue=0.001, 
                                        unloadingTempDepend=True, 
                                        unloadingIncludeCurve=True)], 
                                        iMaterialID=1, 
                                        iMaterialColor=12901750, 
                                        strDescription="GasketThickness")
JPT.Debugger(sample_Mat) #for checking return value

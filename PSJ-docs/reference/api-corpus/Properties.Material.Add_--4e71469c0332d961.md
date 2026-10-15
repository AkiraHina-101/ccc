# Properties.Material.Add()

Properties.Material.Add()

Description​

Create a new material to the current User database library.

This command is not compatible with V5.0 series. If you wish to use scripts currently running on V5.0.1-V5.0.4 with V5.1, please modify your scripts accordingly.

Syntax​

Properties.Material.Add(...)

Ribbon: Properties » Material » Add

Inputs​

strMaterialName​

A String specifying the material name.

This is a required input.

dictMaterialProperty​

A dictionary specifying  dictMatProps.

This is a required input.

listMaterialProperty​

A List of MATERIAL PROPERTY specifying all attributes of property such as density, elasticity, etc.

caution

This input is discarded from V5.1. Please use dictMaterialProperty instead.

iMaterialID​

An Integer specifying the NasID of material to be added.

The NasID can be referred in *.mlib material library file.

This is a required input.

iMaterialColor​

An Integer specifying the ID of color .

The default value is 0.

strDescription​

A String specifying the description of material.

The default value is "".

Return Code​

A Cursor specifying the new material created.

Sample Code​

#Prepare material with unit
dict_mat_prop = {
    'Density': {
        'density': {
            'DENSITY': [8.3e-9],
        },
    },
    'Elastic': {
        'elastic': {
            'POISSONS_RATIO': [0.3],
            'YOUNGS_MODULUS': [1.1e+5],
            'SHEAR_MODULUS': [5.2e+3],
        }
    },
    'Unit': {
        'Density': {
            'density': {  
                'DENSITY': JPT.DensityUnit.Density_t_mm3
            }
        },
        'Elastic': {
            'elastic': {  
                'YOUNGS_MODULUS': JPT.ModulusUnit.Modulus_N_mm2
            }
        }
    }
}

#Add new material to document
new_material=Properties.Material.Add(
    strMaterialName="NewMaterial", 
    dictMaterialProperty=dict_mat_prop,
    iMaterialID=1, 
    iMaterialColor=9614382)

JPT.Debugger(new_material) #for checking return value

# Material Types

Material Types

This is an enumeration type represents type of Material in Jupiter.

The ID of material property which was primarily used in functions can be referred to in the Int Notation column.

However, in order to explicitly describe meaning of material properties, user can use the KEY NAME instead of specifying ID.

For example: YOUNGS_MODULUS is equal to ID = 1.

 | Int Notation | Key Name | Description

 | 0 | DENSITY | A Tuple specifying the density data

 | 1 | YOUNGS_MODULUS | A Tuple specifying the young modulus data

 | 2 | SHEAR_MODULUS | A Tuple specifying the shear modulus data

 | 3 | POISSONS_RATIO | A Tuple specifying the poisson ratio data

 | 4 | NASTRAN_FAILURE_INDEX_TENSION | A Tuple specifying the Nastran failure index tension data

 | 5 | NASTRAN_FAILURE_INDEX_COMPRESSION | A Tuple specifying the Nastran failure index compression data

 | 6 | NASTRAN_FAILURE_INDEX_SHEAR | A Tuple specifying the Nastran failure index shear data

 | 7 | E1 | A Tuple specifying the E1 data

 | 8 | E2 | A Tuple specifying the E2 data

 | 9 | E3 | A Tuple specifying the E3 data

 | 10 | E4 | A Tuple specifying the E4 data

 | 11 | E5 | A Tuple specifying the E5 data

 | 12 | E6 | A Tuple specifying the E6 data

 | 13 | G12 | A Tuple specifying the G12 data

 | 14 | G1Z | A Tuple specifying the G1Z data

 | 15 | G2Z | A Tuple specifying the G2Z data

 | 16 | G13 | A Tuple specifying the G13 data

 | 17 | G23 | A Tuple specifying the G23 data

 | 18 | NU12 | A Tuple specifying the Nu12 data

 | 19 | NU13 | A Tuple specifying the Nu13 data

 | 20 | NU23 | A Tuple specifying the Nu23 data

 | 21 | XT | A Tuple specifying the XT data

 | 22 | XC | A Tuple specifying the XC data

 | 23 | YT | A Tuple specifying the YT data

 | 24 | YC | A Tuple specifying the YC data

 | 25 | S | A Tuple specifying the S data

 | 26 | F12 | A Tuple specifying the F12 data

 | 27 | STRN | A Tuple specifying the STRN data

 | 28 | D1111 | A Tuple specifying the D1111 data

 | 29 | D1122 | A Tuple specifying the D1122 data

 | 30 | D2222 | A Tuple specifying the D2222 data

 | 31 | D1133 | A Tuple specifying the D1133 data

 | 32 | D2233 | A Tuple specifying the D2233 data

 | 33 | D3333 | A Tuple specifying the D3333 data

 | 34 | D1212 | A Tuple specifying the D1212 data

 | 35 | D1313 | A Tuple specifying the D1313 data

 | 36 | D2323 | A Tuple specifying the D2323 data

 | 37 | EKNN | A Tuple specifying the E/knn  data

 | 38 | G1KSS | A Tuple specifying the G1/kss data

 | 39 | G2KTT | A Tuple specifying the G2/ktt data

 | 40 | STRESS | A Tuple specifying the stress/yield stress data

 | 41 | STRAIN | A Tuple specifying the strain/yield strain data

 | 42 | A | A Tuple specifying the A data

 | 43 | B | A Tuple specifying the B data

 | 44 | M | A Tuple specifying the M data

 | 45 | N | A Tuple specifying the N data

 | 46 | MELTING_TEMP | A Tuple specifying the melting temperature data

 | 47 | TRANSITION_TEMP | A Tuple specifying the transient temperature data

 | 48 | HARDENING_PROP | A Tuple specifying the hardening properties data

 | 49 | GAMMA | A Tuple specifying the gamma data

 | 50 | HARD_PARAM | A Tuple specifying the hardening parameter data

 | 51 | CONDUCTIVITY | A Tuple specifying the conductivity data

 | 52 | K11 | A Tuple specifying the K11 data

 | 53 | K22 | A Tuple specifying the K22 data

 | 54 | K33 | A Tuple specifying the K33 data

 | 55 | K12 | A Tuple specifying the K12 data

 | 56 | K13 | A Tuple specifying the K13 data

 | 57 | K23 | A Tuple specifying the K23 data

 | 58 | SPECIFIC_HEAT | A Tuple specifying the specific heat data

 | 59 | HEAT_GENERATE_RATE | A Tuple specifying the heat generate rate data

 | 60 | EQUIV_STRESS | A Tuple specifying the equivalent stress data

 | 61 | EQUIV_STRAIN | A Tuple specifying the equivalent stress data

 | 62 | Q_INFINITY | A Tuple specifying the Q infinity data

 | 63 | PRESSURE_FORCE_LOADING | A Tuple specifying the pressure force loading data

 | 64 | CLOSURE_LOADING | A Tuple specifying the closure loading data

 | 65 | PRESSURE_FORCE_UNLOADING | A Tuple specifying the pressure force unloading data

 | 66 | CLOSURE_UNLOADING | A Tuple specifying the closure unloading data

 | 67 | PLASTIC_MAX_CLOSURE_UNLOADING | A Tuple specifying the plastic max closure unloading data

 | 68 | HARDENING_B | A Tuple specifying the hardening B data

 | 69 | ALPHA | A Tuple specifying the alpha data

 | 70 | ALPHA11 | A Tuple specifying the alpha11 data

 | 71 | ALPHA22 | A Tuple specifying the alpha22 data

 | 72 | ALPHA33 | A Tuple specifying the alpha33 data

 | 73 | ALPHA12 | A Tuple specifying the alpha12 data

 | 74 | ALPHA23 | A Tuple specifying the alpha23 data

 | 75 | ALPHA13 | A Tuple specifying the alpha13 data

 | 76 | BULK_MODULUS | A Tuple specifying the bulk modulus data

 | 77 | TIME_DELAY | A Tuple specifying the time delay data

 | 78 | SHIFT_FACTOR | A Tuple specifying the shift factor data

 | 79 | VISCOSITY | A Tuple specifying the viscosity data

 | 80 | STRESS_L | A Tuple specifying the stress L data

 | 81 | STRAIN_L | A Tuple specifying the strain L data

 | 82 | STRESS_T | A Tuple specifying the stress T data

 | 83 | STRAIN_T | A Tuple specifying the strain T data

 | 84 | STRESS_Z | A Tuple specifying the stress Z data

 | 85 | STRAIN_Z | A Tuple specifying the strain Z data

 | 86 | STRESS_LT | A Tuple specifying the stress LT data

 | 87 | STRAIN_LT | A Tuple specifying the strain LT data

 | 88 | STRESS_TZ | A Tuple specifying the stress TZ data

 | 89 | STRAIN_TZ | A Tuple specifying the strain TZ data

 | 90 | STRESS_ZL | A Tuple specifying the stress ZL data

 | 91 | STRAIN_ZL | A Tuple specifying the strain ZL data

 | 92 | MU | A Tuple specifying the Mu data

 | 93 | LAMDA_M | A Tuple specifying the lamda_M data

 | 94 | D | A Tuple specifying the D data

 | 95 | C10 | A Tuple specifying the C10 data

 | 96 | C01 | A Tuple specifying the C01 data

 | 97 | D1 | A Tuple specifying the D1 data

 | 98 | MU1 | A Tuple specifying the Mu1 data

 | 99 | ALPHA1 | A Tuple specifying the alpha1 data

 | 100 | BETA | A Tuple specifying the beta data

 | 101 | C0 | A Tuple specifying the C0 data

 | 102 | C1 | A Tuple specifying the C1 data

 | 103 | C2 | A Tuple specifying the C2 data

 | 104 | C3 | A Tuple specifying the C3 data

 | 105 | C20 | A Tuple specifying the C20 data

 | 106 | C30 | A Tuple specifying the C30 data

 | 107 | D1 | A Tuple specifying the D1 data

 | 108 | D2 | A Tuple specifying the D2 data

 | 109 | D3 | A Tuple specifying the nomial stress data

 | 110 | NOMIAL_STRESS | A Tuple specifying the nomial strain data

 | 111 | NOMIAL_STRAIN | A Tuple specifying the lateral nomial strain data

 | 112 | LATERAL_NOMIAL_STRAIN | A Tuple specifying the time data

 | 113 | TIME | A Tuple specifying the time data

 | 114 | STRESS_COMPRESSION | A Tuple specifying the stress compression data

 | 115 | STRESS_TENSION | A Tuple specifying the stress tension data

 | 116 | STRAIN_COMPRESSION | A Tuple specifying the strain compression data

 | 117 | STRAIN_TENSION | A Tuple specifying the strain tension data

 | 118 | POWER_LAW_MULTIPLIER | A Tuple specifying the power law multiplier data

 | 119 | HYPER_LAW_MULTIPLIER | A Tuple specifying the hyper law multiplier data

 | 120 | EQ_STRESS_MULTIPLIER | A Tuple specifying the Eq stress multiplier data

 | 121 | EQ_STRESS_ORDER | A Tuple specifying the Eq stress order data

 | 122 | UNIVERSAL_GAS_CONST | A Tuple specifying the Universal gas const data

 | 123 | ACTIVATION_ENERGY | A Tuple specifying the activation energy data

 | 124 | TIME_ORDER | A Tuple specifying the time order data

 | 125 | MEAN_STRESS | A Tuple specifying the mean stress data

 | 126 | STRESS_AMPLITUDE | A Tuple specifying the stress amplitude data

 | 127 | DAMPING | A Tuple specifying the damping data

 | 128 | RESISTIVITY | A Tuple specifying the resistivity data

 | 129 | FREQUENCY | A Tuple specifying the frequency data

 | 130 | TEMPERATURE | A Tuple specifying the temperature data

 | 131 | TEMPERATURE_H | A Tuple specifying the temperature H data

 | 132 | TEMPERATURE_V | A Tuple specifying the temperature V data

 | 133 | TEMPERATURE_SUB | A Tuple specifying the temperature sub option data

 | 134 | TEMPERATURE_LOADING | A Tuple specifying the temperature loading data

 | 135 | TEMPERATURE_UNLOADING | A Tuple specifying the temperature unloading data

 | 136 | TEMPERATURE_UNIAXIAL | A Tuple specifying the temperature uniaxial data

 | 137 | SHEAR_STIFFNESS_H | A Tuple specifying the shear stiffness H data

 | 138 | SHEAR_STIFFNESS_V | A Tuple specifying the shear stiffness V data

 | 139 | FREQUENCY_DEPENDENCE | A Tuple specifying the frequency dependence data

 | 140 | STRAIN_RATE | A Tuple specifying the strain rate

 | 141 | STRAIN_RATE_COMPRESSION | A Tuple specifying the strain rate compression

 | 142 | STRAIN_RATE_TENSION | A Tuple specifying the strain rate tension

 | 143 | EXTRA_FIELDS | A Tuple specifying the extra fields data

 | 144 | EXTRA_FIELDS_H | A Tuple specifying the extra fields H data

 | 145 | EXTRA_FIELDS_V | A Tuple specifying the extra fields V  data

 | 146 | EXTRA_FIELDS_SUB | A Tuple specifying the extra fields sub option data

 | 147 | EXTRA_FIELDS_LOADING | A Tuple specifying the extra fields loading data

 | 148 | EXTRA_FIELDS_UNLOADING | A Tuple specifying the extra fields unloading data

 | 149 | EXTRA_FIELDS_UNIAXIAL | A Tuple specifying the extra fields uniaxial data

 | 150 | EXTRA_FIELDS_COMPRESSION | A Tuple specifying the extra fields compression data

 | 151 | EXTRA_FIELDS_TENSION | A Tuple specifying the extra fields tension data

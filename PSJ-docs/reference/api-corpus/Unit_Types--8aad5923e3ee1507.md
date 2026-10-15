# Unit Types

Unit Types

This is an enumeration type represents units used in Jupiter.
Functions used for unit conversion:

JPT.ConvertFromDocUnit: Convert the inputted value from the current Jupiter unit system to SI[m] unit.

JPT.ConvertFromMacroUnit: Convert the inputted value from the specified unit to the SI[m] unit.

JPT.ConvertValueToDocUnit: Convert the inputted value from SI[m] units to the current Jupiter unit system.

JPT.ConvertValueToMacroUnit: Convert the inputted value from the SI[m] unit to the specified unit.

For more information, refer to Convert Unit tutorial

 | ID | Unit Type | Description | String Unit

 | 0 | JPT.UnitType.Unit_Length | Length | mmmftincmmm\\m\\ft\\in\\cmmmmftincm

 | 1 | JPT.UnitType.Unit_Time | Time | sminhs\\min\\hsminh

 | 2 | JPT.UnitType.Unit_Mass | Mass | tkgkgf∗s2/mmsluglbf∗s2/inlbgt\\kg\\kgf*s^2/mm\\slug\\lbf*s^2/in\\lb\\gtkgkgf∗s2/mmsluglbf∗s2/inlbg

 | 3 | JPT.UnitType.Unit_Force | Force | NmNkNkgflbftfN\\mN\\kN\\kgf\\lbf\\tfNmNkNkgflbftf

 | 4 | JPT.UnitType.Unit_Angle | Angle | degraddeg\\raddegrad

 | 5 | JPT.UnitType.Unit_Temperature | Temperature | KdegCdegFK\\deg C\\deg FKdegCdegF

 | 6 | JPT.UnitType.Unit_Area | Area | mm2m2ft2in2cm2mm^2\\m^2\\ft^2\\in^2\\cm^2mm2m2ft2in2cm2

 | 7 | JPT.UnitType.Unit_Volume | Volume | mm3m3ft3in3cm3mm^3\\m^3\\ft^3\\in^3\\cm^3mm3m3ft3in3cm3

 | 8 | JPT.UnitType.Unit_Velocity | Velocity | mm/sm/sft/sin/smm/s\\m/s\\ft/s\\in/smm/sm/sft/sin/s

 | 9 | JPT.UnitType.Unit_Acceleration | Acceleration | mm/s2m/s2ft/s2in/s2gGalmm/s^2\\m/s^2\\ft/s^2\\in/s^2\\g\\Galmm/s2m/s2ft/s2in/s2gGal

 | 10 | JPT.UnitType.Unit_RotateVelo | Rotational velocity | rad/sdeg/srpmrad/s\\deg/s\\rpmrad/sdeg/srpm

 | 11 | JPT.UnitType.Unit_RotateAcc | Rotational acceleration | rad/s2deg/s2rad/s^2\\deg/s^2rad/s2deg/s2

 | 12 | JPT.UnitType.Unit_Moment | Moment | N∗mmN∗mmN∗mmkgf∗mmlbf∗ftlbf∗intf∗mN*mm\\N*m\\mN*mm\\kgf*mm\\lbf*ft\\lbf*in\\tf*mN∗mmN∗mmN∗mmkgf∗mmlbf∗ftlbf∗intf∗m

 | 13 | JPT.UnitType.Unit_Pressure | Pressure | MPaPakPakgf/mm2lbf/ft2lbf/in2tf/m2GPaMPa\\Pa\\kPa\\kgf/mm^2\\lbf/ft^2\\lbf/in^2\\tf/m^2\\GPaMPaPakPakgf/mm2lbf/ft2lbf/in2tf/m2GPa

 | 14 | JPT.UnitType.Unit_Density | Density | t/mm3kg/m3kg/mm3kgf∗s2/mm4slug/ft3lbf∗s2/in4t/mm^3\\kg/m^3\\kg/mm^3\\kgf*s^2/mm^4\\slug/ft^3\\lbf*s^2/in^4t/mm3kg/m3kg/mm3kgf∗s2/mm4slug/ft3lbf∗s2/in4

 | 15 | JPT.UnitType.Unit_Stiffness | Stiffness | N/mmN/mmN/mmkgf/mmlbf/ftlbf/inN/mm\\N/m\\mN/mm\\kgf/mm\\lbf/ft\\lbf/inN/mmN/mmN/mmkgf/mmlbf/ftlbf/in

 | 16 | JPT.UnitType.Unit_RotateStiff | Rotational stiffness | N∗mm/radN∗m/radmN∗mm/radkgf∗mm/radlbf∗ft/radlbf∗in/radN∗mm/degmN∗mm/degN*mm/rad\\N*m/rad\\mN*mm/rad\\kgf*mm/rad\\lbf*ft/rad\\lbf*in/rad\\N*mm/deg\\mN*mm/degN∗mm/radN∗m/radmN∗mm/radkgf∗mm/radlbf∗ft/radlbf∗in/radN∗mm/degmN∗mm/deg

 | 17 | JPT.UnitType.Unit_DampingCoef | Damping coefficient | N∗s/mmN∗s/mmN∗s/mmkgf∗s/mmlbf∗s/ftlbf∗s/inN*s/mm\\N*s/m\\mN*s/mm\\kgf*s/mm\\lbf*s/ft\\lbf*s/inN∗s/mmN∗s/mmN∗s/mmkgf∗s/mmlbf∗s/ftlbf∗s/in

 | 18 | JPT.UnitType.Unit_RotateDampingCoef | Rotational damping coefficient | N∗mm∗s/radN∗m∗s/radmN∗mm∗s/radkgf∗mm∗s/radlbf∗ft∗s/radlbf∗in∗s/radN∗mm∗s/degN*mm*s/rad\\N*m*s/rad\\mN*mm*s/rad\\kgf*mm*s/rad\\lbf*ft*s/rad\\lbf*in*s/rad\\N*mm*s/degN∗mm∗s/radN∗m∗s/radmN∗mm∗s/radkgf∗mm∗s/radlbf∗ft∗s/radlbf∗in∗s/radN∗mm∗s/deg

 | 19 | JPT.UnitType.Unit_Modulus | Elastic modulus | N/mm2N/m2mN/mm2kgf/mm2lbf/ft2lbf/in2N/mm^2\\N/m^2\\mN/mm^2\\kgf/mm^2\\lbf/ft^2\\lbf/in^2N/mm2N/m2mN/mm2kgf/mm2lbf/ft2lbf/in2

 | 20 | JPT.UnitType.Unit_Energy | Energy | mJJmiuJkcalft∗lbfin∗lbfkJcalmJ\\J\\miuJ\\kcal\\ft*lbf\\in*lbf\\kJ\\calmJJmiuJkcalft∗lbfin∗lbfkJcal

 | 21 | JPT.UnitType.Unit_Power | Power | mWWmiuWkcal/sft∗lbf/sin∗lbf/smW\\W\\miuW\\kcal/s\\ft*lbf/s\\in*lbf/smWWmiuWkcal/sft∗lbf/sin∗lbf/s

 | 22 | JPT.UnitType.Unit_ThermalExCoef | Coefficient of linear expansion | /K/K/K

 | 23 | JPT.UnitType.Unit_ThermalConductivity | Thermal conductivity | mW/mm∗KW/m∗KmiuW/mm∗Kkcal/mm∗h∗Klbf/ft∗s∗Klbf/in∗s∗KmW/mm*K\\W/m*K\\miuW/mm*K\\kcal/mm*h*K\\lbf/ft*s*K\\lbf/in*s*KmW/mm∗KW/m∗KmiuW/mm∗Kkcal/mm∗h∗Klbf/ft∗s∗Klbf/in∗s∗K

 | 24 | JPT.UnitType.Unit_ConvectionCoef | Convection coefficient | mW/mm2∗KW/m2∗KmiuW/mm2∗Kkcal/mm2∗h∗Klbf/ft∗s∗Klbf/in∗s∗KmW/mm^2*K\\W/m^2*K\\miuW/mm^2*K\\kcal/mm^2*h*K\\lbf/ft*s*K\\lbf/in*s*KmW/mm2∗KW/m2∗KmiuW/mm2∗Kkcal/mm2∗h∗Klbf/ft∗s∗Klbf/in∗s∗K

 | 25 | JPT.UnitType.Unit_SpecificHeat | Specific heat | mJ/t∗KJ/kg∗KmiuJ/kg∗Kkcal/kg∗Kft∗lbf/slug∗Kin2/s2∗KmJ/t*K\\J/kg*K\\miuJ/kg*K\\kcal/kg*K\\ft*lbf/slug*K\\in^2/s^2*KmJ/t∗KJ/kg∗KmiuJ/kg∗Kkcal/kg∗Kft∗lbf/slug∗Kin2/s2∗K

 | 26 | JPT.UnitType.Unit_HeatFlux | Heat flux | mW/mm2W/m2miuW/mm2kcal/mm2∗hlbf/ft∗slbf/in∗smW/mm^2\\W/m^2\\miuW/mm^2\\kcal/mm^2*h\\lbf/ft*s\\lbf/in*smW/mm2W/m2miuW/mm2kcal/mm2∗hlbf/ft∗slbf/in∗s

 | 27 | JPT.UnitType.Unit_HeatGeneration | Heat generation | mW/mm3W/m3miuW/mm3kcal//mm3∗hlbf/ft2∗slbf/in2∗smW/mm^3\\W/m^3\\miuW/mm^3\\kcal//mm^3*h\\lbf/ft^2*s\\lbf/in^2*smW/mm3W/m3miuW/mm3kcal//mm3∗hlbf/ft2∗slbf/in2∗s

 | 28 | JPT.UnitType.Unit_LinearDensity | Linear density | kg/moz/ftoz/inlb/ydkg/m\\oz/ft\\oz/in\\lb/ydkg/moz/ftoz/inlb/yd

 | 29 | JPT.UnitType.Unit_SurfaceDensity | Surface density | 

 | 30 | JPT.UnitType.Unit_AreaMomentInertia | Moment of Inertia (Area) | mm4m4ft4in4cm4mm^4\\m^4\\ft^4\\in^4\\cm^4mm4m4ft4in4cm4

 | 31 | JPT.UnitType.Unit_TorsionalConst | Torsional rigidity | mm4m4ft4in4cm4mm^4\\m^4\\ft^4\\in^4\\cm^4mm4m4ft4in4cm4

 | 32 | JPT.UnitType.Unit_WarpCoef | Warping factor | mm6m6ft6in6cm6mm^6\\m^6\\ft^6\\in^6\\cm^6mm6m6ft6in6cm6

 | 33 | JPT.UnitType.Unit_LinearMassMomentIntertia | Mass moment of inertia | t∗mmkg∗mkg∗mmkgf∗s2slug∗ftlbf∗s2t*mm\\kg*m\\kg*mm\\kgf*s^2\\slug*ft\\lbf*s^2t∗mmkg∗mkg∗mmkgf∗s2slug∗ftlbf∗s2

 | 34 | JPT.UnitType.Unit_MomentInertia | Inertia (Area) moment | t*mm^2\\kg*m^2\\kg*mm^2\\kgf*mm*s^2\\slug*ft^2\\lbf*in*s^

 | 35 | JPT.UnitType.Unit_Stress | Stress | N/mm2N/m2mN/mm2N/mm^2\\N/m^2\\mN/mm^2N/mm2N/m2mN/mm2

 | 36 | JPT.UnitType.Unit_Strain | Strain | N−mN−mmN-m\\N-mmN−mN−mm

 | 37 | JPT.UnitType.Unit_StrainEnergy | Strain energy | N−mmN−mN-mm\\N-mN−mmN−m

 | 38 | JPT.UnitType.Unit_ThermalEnergy | Thermal energy | JmJcalJ\\mJ\\calJmJcal

 | 39 | JPT.UnitType.Unit_Frequency | Frequency | HzHzHz

 | 40 | JPT.UnitType.Unit_VolumeEnergyDensity | Volume energy density | J/mm3J/m3mJ/mm3J/mm^3\\J/m^3\\mJ/mm^3J/mm3J/m3mJ/mm3

 | 41 | JPT.UnitType.Unit_ElectricalResistivity | Electrical resistivity | Ohm−mmOhm−mOhm-mm\\Ohm-mOhm−mmOhm−m

 | 42 | JPT.UnitType.Unit_StressReciprocal | Stress Reciprocal | Ohm−mmOhm−mOhm-mm\\Ohm-mOhm−mmOhm−m

 | 43 | JPT.UnitType.Unit_ThermalRadiation | Thermal radiation | mm2/Nm2/Nmm2/mNmm^2/N\\m^2/N\\mm^2/mNmm2/Nm2/Nmm2/mN

 | 44 | JPT.UnitType.Unit_Displacement | Displacement | mm2/Nm2/Nmm2/mNmm^2/N\\m^2/N\\mm^2/mNmm2/Nm2/Nmm2/mN

 | 45 | JPT.UnitType.Unit_EnergyDensity | Energy density | mJ/mm3J/m3Kcal/mm3mJ/mm^3\\J/m^3\\Kcal/mm^3mJ/mm3J/m3Kcal/mm3

 | 46 | JPT.UnitType.Unit_TemperatureGradient | Temperature gradient | K/mK/mmK/m\\K/mmK/mK/mm

 | 47 | JPT.UnitType.Unit_Current | Current | AmAuAkAA\\mA\\uA\\kAAmAuAkA

 | 48 | JPT.UnitType.Unit_Voltage | Current | VmVuVkVV\\mV\\uV\\kVVmVuVkV

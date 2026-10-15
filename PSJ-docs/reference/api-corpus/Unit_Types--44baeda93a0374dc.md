# Unit Types

Unit Types

これは、Jupiterで使用される単位を表す列挙型です。
単位変換に使用される機能：

JPT.ConvertFromDocUnit: 入力値を現在のJupiter単位系からSI[m]単位に変換します。

JPT.ConvertFromMacroUnit: 入力値を指定された単位からSI[m]単位に変換します。

JPT.ConvertValueToDocUnit: 入力値をSI[m]単位から現在のJupiter単位系に変換します。

JPT.ConvertValueToMacroUnit: 入力値をSI[m]単位から指定された単位に変換します。

詳細については、単位変換チュートリアルを参照してください。

 | ID | 単位タイプ | 説明 | 文字単位

 | 0 | JPT.UnitType.Unit_Length | 長さ | mmmftincmmm\\m\\ft\\in\\cmmmmftincm

 | 1 | JPT.UnitType.Unit_Time | 時間 | sminhs\\min\\hsminh

 | 2 | JPT.UnitType.Unit_Mass | 質量 | tkgkgf∗s2/mmsluglbf∗s2/inlbgt\\kg\\kgf*s^2/mm\\slug\\lbf*s^2/in\\lb\\gtkgkgf∗s2/mmsluglbf∗s2/inlbg

 | 3 | JPT.UnitType.Unit_Force | 力 | NmNkNkgflbftfN\\mN\\kN\\kgf\\lbf\\tfNmNkNkgflbftf

 | 4 | JPT.UnitType.Unit_Angle | 角度 | degraddeg\\raddegrad

 | 5 | JPT.UnitType.Unit_Temperature | 温度 | KdegCdegFK\\deg C\\deg FKdegCdegF

 | 6 | JPT.UnitType.Unit_Area | 面積 | mm2m2ft2in2cm2mm^2\\m^2\\ft^2\\in^2\\cm^2mm2m2ft2in2cm2

 | 7 | JPT.UnitType.Unit_Volume | 体積 | mm3m3ft3in3cm3mm^3\\m^3\\ft^3\\in^3\\cm^3mm3m3ft3in3cm3

 | 8 | JPT.UnitType.Unit_Velocity | 速度 | mm/sm/sft/sin/smm/s\\m/s\\ft/s\\in/smm/sm/sft/sin/s

 | 9 | JPT.UnitType.Unit_Acceleration | 加速度 | mm/s2m/s2ft/s2in/s2gGalmm/s^2\\m/s^2\\ft/s^2\\in/s^2\\g\\Galmm/s2m/s2ft/s2in/s2gGal

 | 10 | JPT.UnitType.Unit_RotateVelo | 回転速度 | rad/sdeg/srpmrad/s\\deg/s\\rpmrad/sdeg/srpm

 | 11 | JPT.UnitType.Unit_RotateAcc | 回転加速度 | rad/s2deg/s2rad/s^2\\deg/s^2rad/s2deg/s2

 | 12 | JPT.UnitType.Unit_Moment | モーメント | N∗mmN∗mmN∗mmkgf∗mmlbf∗ftlbf∗intf∗mN*mm\\N*m\\mN*mm\\kgf*mm\\lbf*ft\\lbf*in\\tf*mN∗mmN∗mmN∗mmkgf∗mmlbf∗ftlbf∗intf∗m

 | 13 | JPT.UnitType.Unit_Pressure | 圧力 | MPaPakPakgf/mm2lbf/ft2lbf/in2tf/m2GPaMPa\\Pa\\kPa\\kgf/mm^2\\lbf/ft^2\\lbf/in^2\\tf/m^2\\GPaMPaPakPakgf/mm2lbf/ft2lbf/in2tf/m2GPa

 | 14 | JPT.UnitType.Unit_Density | 密度 | t/mm3kg/m3kg/mm3kgf∗s2/mm4slug/ft3lbf∗s2/in4t/mm^3\\kg/m^3\\kg/mm^3\\kgf*s^2/mm^4\\slug/ft^3\\lbf*s^2/in^4t/mm3kg/m3kg/mm3kgf∗s2/mm4slug/ft3lbf∗s2/in4

 | 15 | JPT.UnitType.Unit_Stiffness | 剛性 | N/mmN/mmN/mmkgf/mmlbf/ftlbf/inN/mm\\N/m\\mN/mm\\kgf/mm\\lbf/ft\\lbf/inN/mmN/mmN/mmkgf/mmlbf/ftlbf/in

 | 16 | JPT.UnitType.Unit_RotateStiff | 回転剛性 | N∗mm/radN∗m/radmN∗mm/radkgf∗mm/radlbf∗ft/radlbf∗in/radN∗mm/degmN∗mm/degN*mm/rad\\N*m/rad\\mN*mm/rad\\kgf*mm/rad\\lbf*ft/rad\\lbf*in/rad\\N*mm/deg\\mN*mm/degN∗mm/radN∗m/radmN∗mm/radkgf∗mm/radlbf∗ft/radlbf∗in/radN∗mm/degmN∗mm/deg

 | 17 | JPT.UnitType.Unit_DampingCoef | 減衰係数 | N∗s/mmN∗s/mmN∗s/mmkgf∗s/mmlbf∗s/ftlbf∗s/inN*s/mm\\N*s/m\\mN*s/mm\\kgf*s/mm\\lbf*s/ft\\lbf*s/inN∗s/mmN∗s/mmN∗s/mmkgf∗s/mmlbf∗s/ftlbf∗s/in

 | 18 | JPT.UnitType.Unit_RotateDampingCoef | 回転減衰係数 | N∗mm∗s/radN∗m∗s/radmN∗mm∗s/radkgf∗mm∗s/radlbf∗ft∗s/radlbf∗in∗s/radN∗mm∗s/degN*mm*s/rad\\N*m*s/rad\\mN*mm*s/rad\\kgf*mm*s/rad\\lbf*ft*s/rad\\lbf*in*s/rad\\N*mm*s/degN∗mm∗s/radN∗m∗s/radmN∗mm∗s/radkgf∗mm∗s/radlbf∗ft∗s/radlbf∗in∗s/radN∗mm∗s/deg

 | 19 | JPT.UnitType.Unit_Modulus | 弾性率 | N/mm2N/m2mN/mm2kgf/mm2lbf/ft2lbf/in2N/mm^2\\N/m^2\\mN/mm^2\\kgf/mm^2\\lbf/ft^2\\lbf/in^2N/mm2N/m2mN/mm2kgf/mm2lbf/ft2lbf/in2

 | 20 | JPT.UnitType.Unit_Energy | エネルギー | mJJmiuJkcalft∗lbfin∗lbfkJcalmJ\\J\\miuJ\\kcal\\ft*lbf\\in*lbf\\kJ\\calmJJmiuJkcalft∗lbfin∗lbfkJcal

 | 21 | JPT.UnitType.Unit_Power | 力 | mWWmiuWkcal/sft∗lbf/sin∗lbf/smW\\W\\miuW\\kcal/s\\ft*lbf/s\\in*lbf/smWWmiuWkcal/sft∗lbf/sin∗lbf/s

 | 22 | JPT.UnitType.Unit_ThermalExCoef | 線膨張率 | /K/K/K

 | 23 | JPT.UnitType.Unit_ThermalConductivity | 熱伝導率 | mW/mm∗KW/m∗KmiuW/mm∗Kkcal/mm∗h∗Klbf/ft∗s∗Klbf/in∗s∗KmW/mm*K\\W/m*K\\miuW/mm*K\\kcal/mm*h*K\\lbf/ft*s*K\\lbf/in*s*KmW/mm∗KW/m∗KmiuW/mm∗Kkcal/mm∗h∗Klbf/ft∗s∗Klbf/in∗s∗K

 | 24 | JPT.UnitType.Unit_ConvectionCoef | 対流係数 | mW/mm2∗KW/m2∗KmiuW/mm2∗Kkcal/mm2∗h∗Klbf/ft∗s∗Klbf/in∗s∗KmW/mm^2*K\\W/m^2*K\\miuW/mm^2*K\\kcal/mm^2*h*K\\lbf/ft*s*K\\lbf/in*s*KmW/mm2∗KW/m2∗KmiuW/mm2∗Kkcal/mm2∗h∗Klbf/ft∗s∗Klbf/in∗s∗K

 | 25 | JPT.UnitType.Unit_SpecificHeat | 比熱量 | mJ/t∗KJ/kg∗KmiuJ/kg∗Kkcal/kg∗Kft∗lbf/slug∗Kin2/s2∗KmJ/t*K\\J/kg*K\\miuJ/kg*K\\kcal/kg*K\\ft*lbf/slug*K\\in^2/s^2*KmJ/t∗KJ/kg∗KmiuJ/kg∗Kkcal/kg∗Kft∗lbf/slug∗Kin2/s2∗K

 | 26 | JPT.UnitType.Unit_HeatFlux | 熱流 | mW/mm2W/m2miuW/mm2kcal/mm2∗hlbf/ft∗slbf/in∗smW/mm^2\\W/m^2\\miuW/mm^2\\kcal/mm^2*h\\lbf/ft*s\\lbf/in*smW/mm2W/m2miuW/mm2kcal/mm2∗hlbf/ft∗slbf/in∗s

 | 27 | JPT.UnitType.Unit_HeatGeneration | 発熱量 | mW/mm3W/m3miuW/mm3kcal//mm3∗hlbf/ft2∗slbf/in2∗smW/mm^3\\W/m^3\\miuW/mm^3\\kcal//mm^3*h\\lbf/ft^2*s\\lbf/in^2*smW/mm3W/m3miuW/mm3kcal//mm3∗hlbf/ft2∗slbf/in2∗s

 | 28 | JPT.UnitType.Unit_LinearDensity | 線密度 | kg/moz/ftoz/inlb/ydkg/m\\oz/ft\\oz/in\\lb/ydkg/moz/ftoz/inlb/yd

 | 29 | JPT.UnitType.Unit_SurfaceDensity | 表面密度 | 

 | 30 | JPT.UnitType.Unit_AreaMomentInertia | 断面慣性モーメント | mm4m4ft4in4cm4mm^4\\m^4\\ft^4\\in^4\\cm^4mm4m4ft4in4cm4

 | 31 | JPT.UnitType.Unit_TorsionalConst | ねじり剛性 | mm4m4ft4in4cm4mm^4\\m^4\\ft^4\\in^4\\cm^4mm4m4ft4in4cm4

 | 32 | JPT.UnitType.Unit_WarpCoef | ねじれ係数 | mm6m6ft6in6cm6mm^6\\m^6\\ft^6\\in^6\\cm^6mm6m6ft6in6cm6

 | 33 | JPT.UnitType.Unit_LinearMassMomentIntertia | 質量慣性モーメント | t∗mmkg∗mkg∗mmkgf∗s2slug∗ftlbf∗s2t*mm\\kg*m\\kg*mm\\kgf*s^2\\slug*ft\\lbf*s^2t∗mmkg∗mkg∗mmkgf∗s2slug∗ftlbf∗s2

 | 34 | JPT.UnitType.Unit_MomentInertia | 慣性モーメント（面積） | t*mm^2\\kg*m^2\\kg*mm^2\\kgf*mm*s^2\\slug*ft^2\\lbf*in*s^

 | 35 | JPT.UnitType.Unit_Stress | 応力 | N/mm2N/m2mN/mm2N/mm^2\\N/m^2\\mN/mm^2N/mm2N/m2mN/mm2

 | 36 | JPT.UnitType.Unit_Strain | 歪み | N−mN−mmN-m\\N-mmN−mN−mm

 | 37 | JPT.UnitType.Unit_StrainEnergy | 歪エネルギー | N−mmN−mN-mm\\N-mN−mmN−m

 | 38 | JPT.UnitType.Unit_ThermalEnergy | 熱エネルギー | JmJcalJ\\mJ\\calJmJcal

 | 39 | JPT.UnitType.Unit_Frequency | 周波数 | HzHzHz

 | 40 | JPT.UnitType.Unit_VolumeEnergyDensity | 体積エネルギー密度 | J/mm3J/m3mJ/mm3J/mm^3\\J/m^3\\mJ/mm^3J/mm3J/m3mJ/mm3

 | 41 | JPT.UnitType.Unit_ElectricalResistivity | 電気抵抗率 | Ohm−mmOhm−mOhm-mm\\Ohm-mOhm−mmOhm−m

 | 42 | JPT.UnitType.Unit_StressReciprocal | 応力の逆数 | Ohm−mmOhm−mOhm-mm\\Ohm-mOhm−mmOhm−m

 | 43 | JPT.UnitType.Unit_ThermalRadiation | 熱放射 | mm2/Nm2/Nmm2/mNmm^2/N\\m^2/N\\mm^2/mNmm2/Nm2/Nmm2/mN

 | 44 | JPT.UnitType.Unit_Displacement | 変位 | mm2/Nm2/Nmm2/mNmm^2/N\\m^2/N\\mm^2/mNmm2/Nm2/Nmm2/mN

 | 45 | JPT.UnitType.Unit_EnergyDensity | エネルギー密度 | mJ/mm3J/m3Kcal/mm3mJ/mm^3\\J/m^3\\Kcal/mm^3mJ/mm3J/m3Kcal/mm3

 | 46 | JPT.UnitType.Unit_TemperatureGradient | 温度勾配 | K/mK/mmK/m\\K/mmK/mK/mm

 | 47 | JPT.UnitType.Unit_Current | 電流 | AmAuAkAA\\mA\\uA\\kAAmAuAkA

 | 48 | JPT.UnitType.Unit_Voltage | 電圧 | VmVuVkVV\\mV\\uV\\kVVmVuVkV

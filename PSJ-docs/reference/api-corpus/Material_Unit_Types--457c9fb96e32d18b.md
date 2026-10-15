# Material Unit Types

Material Unit Types

Jupiterの物質単位のタイプを表す列挙型です。
物質の単位を指定するために、JPT.UnitType.KeyName として使用されます。
以下は、単位の種類と KeyName の一覧です。

 LengthUnit 

長さに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Length_mm | JPT.LengthUnit.Length_mm | mmmmmm

 | 1 | Length_m | JPT.LengthUnit.Length_m | mmm

 | 2 | Length_ft | JPT.LengthUnit.Length_ft | ftftft

 | 3 | Length_in | JPT.LengthUnit.Length_in | ininin

 | 4 | Length_cm | JPT.LengthUnit.Length_cm | cmcmcm

 TimeUnit 

時間に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Time_s | JPT.TimeUnit.Time_s | sss

 | 1 | Time_min | JPT.TimeUnit.Time_min | minminmin

 | 2 | Time_h | JPT.TimeUnit.Time_h | hhh

 MassUnit 

質量に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Mass_t | JPT.MassUnit.Mass_t | ttt

 | 1 | Mass_kg | JPT.MassUnit.Mass_kg | kgkgkg

 | 2 | Mass_kgfs2_mm | JPT.MassUnit.Mass_kgfs2_mm | kgf∗s2/mmkgf*s^2/mmkgf∗s2/mm

 | 3 | Mass_slug | JPT.MassUnit.Mass_slug | slugslugslug

 | 4 | Mass_lbfs2_in | JPT.MassUnit.Mass_lbfs2_in | lbf∗s2/inlbf*s^2/inlbf∗s2/in

 | 5 | Mass_lb | JPT.MassUnit.Mass_lb | lblblb

 | 6 | Mass_g | JPT.MassUnit.Mass_g | ggg

 ForceUnit 

力に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Force_N | JPT.ForceUnit.Force_N | NNN

 | 1 | Force_mN | JPT.ForceUnit.Force_mN | mNmNmN

 | 2 | Force_kN | JPT.ForceUnit.Force_kN | kNkNkN

 | 3 | Force_kgf | JPT.ForceUnit.Force_kgf | kgfkgfkgf

 | 4 | Force_lbf | JPT.ForceUnit.Force_lbf | lbflbflbf

 | 5 | Force_tf | JPT.ForceUnit.Force_tf | tftftf

 AngleUnit 

角度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Angle_rad | JPT.AngleUnit.Angle_rad | degdegdeg

 | 1 | Angle_degree | JPT.AngleUnit.Angle_degree | radradrad

 TemperatureUnit 

温度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Temperature_K | JPT.TemperatureUnit.Temperature_K | KKK

 | 1 | Temperature_degC | JPT.TemperatureUnit.Temperature_degC | degCdeg CdegC

 | 2 | Temperature_degF | JPT.TemperatureUnit.Temperature_degF | degFdeg FdegF

 AreaUnit 

面積に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Area_mm2 | JPT.AreaUnit.Area_mm2 | mm2mm^2mm2

 | 1 | Area_m2 | JPT.AreaUnit.Area_m2 | m2m^2m2

 | 2 | Area_ft2 | JPT.AreaUnit.Area_ft2 | ft2ft^2ft2

 | 3 | Area_in2 | JPT.AreaUnit.Area_in2 | in2in^2in2

 | 4 | Area_cm2 | JPT.AreaUnit.Area_cm2 | cm2cm^2cm2

 VolumeUnit 

体積に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Volume_mm3 | JPT.VolumeUnit.Volume_mm3 | mm3mm^3mm3

 | 1 | Volume_m3 | JPT.VolumeUnit.Volume_m3 | m3m^3m3

 | 2 | Volume_ft3 | JPT.VolumeUnit.Volume_ft3 | ft3ft^3ft3

 | 3 | Volume_in3 | JPT.VolumeUnit.Volume_in3 | in3in^3in3

 | 4 | Volume_cm3 | JPT.VolumeUnit.Volume_cm3 | cm3cm^3cm3

 VelocityUnit 

速度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Velocity_mm_s | JPT.VelocityUnit.Velocity_mm_s | mm/smm/smm/s

 | 1 | Velocity_m_s | JPT.VelocityUnit.Velocity_m_s | m/sm/sm/s

 | 2 | Velocity_ft_s | JPT.VelocityUnit.Velocity_ft_s | ft/sft/sft/s

 | 3 | Velocity_in_s | JPT.VelocityUnit.Velocity_in_s | in/sin/sin/s

 AccelerationUnit 

加速度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Acceleration_mm_s2 | JPT.AccelerationUnit.Acceleration_mm_s2 | mm/s2mm/s^2mm/s2

 | 1 | Acceleration_m_s2 | JPT.AccelerationUnit.Acceleration_m_s2 | m/s2m/s^2m/s2

 | 2 | Acceleration_ft_s2 | JPT.AccelerationUnit.Acceleration_ft_s2 | ft/s2ft/s^2ft/s2

 | 3 | Acceleration_in_s2 | JPT.AccelerationUnit.Acceleration_in_s2 | in/s2in/s^2in/s2

 | 4 | Acceleration_g | JPT.AccelerationUnit.Acceleration_g | ggg

 | 5 | Acceleration_Gal | JPT.AccelerationUnit.Acceleration_Gal | GalGalGal

 RotateVeloUnit 

回転速度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | RotateVelo_rad_s | JPT.RotateVeloUnit.RotateVelo_rad_s | rad/srad/srad/s

 | 1 | RotateVelo_deg_s | JPT.RotateVeloUnit.RotateVelo_deg_s | deg/sdeg/sdeg/s

 | 2 | RotateVelo_rpm | JPT.RotateVeloUnit.RotateVelo_rpm | rpmrpmrpm

 RotateAccUnit 

回転加速度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | RotateAcc_rad_s2 | JPT.RotateAccUnit.RotateAcc_rad_s2 | rad/s2rad/s^2rad/s2

 | 1 | RotateAcc_deg_s2 | JPT.RotateAccUnit.RotateAcc_deg_s2 | deg/s2deg/s^2deg/s2

 MomentUnit 

モーメントに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Moment_Nmm | JPT.MomentUnit.Moment_Nmm | N∗mmN*mmN∗mm

 | 1 | Moment_Nm | JPT.MomentUnit.Moment_Nm | N∗mN*mN∗m

 | 2 | Moment_mNmm | JPT.MomentUnit.Moment_mNmm | mN∗mmmN*mmmN∗mm

 | 3 | Moment_kgfmm | JPT.MomentUnit.Moment_kgfmm | kgf∗mmkgf*mmkgf∗mm

 | 4 | Moment_lbfft | JPT.MomentUnit.Moment_lbfft | lbf∗ftlbf*ftlbf∗ft

 | 5 | Moment_lbfin | JPT.MomentUnit.Moment_lbfin | lbf∗inlbf*inlbf∗in

 | 6 | Moment_kgfcm | JPT.MomentUnit.Moment_kgfcm | kgf∗cmkgf*cmkgf∗cm

 PressureUnit 

圧力に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Pressure_MPa | JPT.PressureUnit.Pressure_MPa | MPaMPaMPa

 | 1 | Pressure_Pa | JPT.PressureUnit.Pressure_Pa | PaPaPa

 | 2 | Pressure_kPa | JPT.PressureUnit.Pressure_kPa | kPakPakPa

 | 3 | Pressure_kgf_mm2 | JPT.PressureUnit.Pressure_kgf_mm2 | kgf/mm2kgf/mm^2kgf/mm2

 | 4 | Pressure_lbf_ft2 | JPT.PressureUnit.Pressure_lbf_ft2 | lbf/ft2lbf/ft^2lbf/ft2

 | 5 | Pressure_lbf_in2 | JPT.PressureUnit.Pressure_lbf_in2 | lbf/in2lbf/in^2lbf/in2

 | 6 | Pressure_tf_m2 | JPT.PressureUnit.Pressure_tf_m2 | tf/m2tf/m^2tf/m2

 | 7 | Pressure_GPa | JPT.PressureUnit.Pressure_GPa | GPaGPaGPa

 DensityUnit 

密度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Density_t_mm3 | Density_t_mm3 | t/mm3t/mm^3t/mm3

 | 1 | Density_kg_m3 | Density_kg_m3 | kg/m3kg/m^3kg/m3

 | 2 | Density_kg_mm3 | Density_kg_mm3 | kg/mm3kg/mm^3kg/mm3

 | 3 | Density_kgfs2_mm4 | Density_kgfs2_mm4 | kgf∗s2/mm4kgf*s^2/mm^4kgf∗s2/mm4

 | 4 | Density_slug_ft3 | Density_slug_ft3 | slug/ft3slug/ft^3slug/ft3

 | 5 | Density_lbfs2_in4 | Density_lbfs2_in4 | lbf∗s2/in4lbf*s^2/in^4lbf∗s2/in4

 StiffnessUnit 

剛性に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Stiffness_N_mm | JPT.StiffnessUnit.Stiffness_N_mm | N/mmN/mmN/mm

 | 1 | Stiffness_N_m | JPT.StiffnessUnit.Stiffness_N_m | N/mN/mN/m

 | 2 | Stiffness_mN_mm | JPT.StiffnessUnit.Stiffness_mN_mm | mN/mmmN/mmmN/mm

 | 3 | Stiffness_kgf_mm | JPT.StiffnessUnit.Stiffness_kgf_mm | kgf/mmkgf/mmkgf/mm

 | 4 | Stiffness_lbf_ft | JPT.StiffnessUnit.Stiffness_lbf_ft | lbf/ftlbf/ftlbf/ft

 | 5 | Stiffness_lbf_in | JPT.StiffnessUnit.Stiffness_lbf_in | lbf/inlbf/inlbf/in

 RotateStiffUnit 

回転剛性に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | RotateStiff_Nmm_rad | JPT.RotateStiffUnit.RotateStiff_Nmm_rad | N∗mm/radN*mm/radN∗mm/rad

 | 1 | RotateStiff_Nm_rad | JPT.RotateStiffUnit.RotateStiff_Nm_rad | N∗m/radN*m/radN∗m/rad

 | 2 | RotateStiff_mNmm_rad | JPT.RotateStiffUnit.RotateStiff_mNmm_rad | mN∗mm/radmN*mm/radmN∗mm/rad

 | 3 | RotateStiff_kgfmm_rad | JPT.RotateStiffUnit.RotateStiff_kgfmm_rad | kgf∗mm/radkgf*mm/radkgf∗mm/rad

 | 4 | RotateStiff_lbfft_rad | JPT.RotateStiffUnit.RotateStiff_lbfft_rad | lbf∗ft/radlbf*ft/radlbf∗ft/rad

 | 5 | RotateStiff_lbfin_rad | JPT.RotateStiffUnit.RotateStiff_lbfin_rad | lbf∗in/radlbf*in/radlbf∗in/rad

 | 6 | RotateStiff_Nmm_deg | JPT.RotateStiffUnit.RotateStiff_Nmm_deg | N∗mm/degN*mm/degN∗mm/deg

 | 7 | RotateStiff_mNmm_deg | JPT.RotateStiffUnit.RotateStiff_mNmm_deg | mN∗mm/degmN*mm/degmN∗mm/deg

 DampCoefUnit 

減衰係数に使用可能な単位。

回転剛性に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 1 | DampCoef_Ns_mm | JPT.DampCoefUnit.DampCoef_Ns_mm | N∗s/mmN*s/mmN∗s/mm

 | 2 | DampCoef_Ns_m | JPT.DampCoefUnit.DampCoef_Ns_m | N∗s/mN*s/mN∗s/m

 | 3 | DampCoef_mNs_mm | JPT.DampCoefUnit.DampCoef_mNs_mm | mN∗s/mmmN*s/mmmN∗s/mm

 | 4 | DampCoef_kgfs_mm | JPT.DampCoefUnit.DampCoef_kgfs_mm | kgf∗s/mmkgf*s/mmkgf∗s/mm

 | 5 | DampCoef_lbfs_ft | JPT.DampCoefUnit.DampCoef_lbfs_ft | lbf∗s/ftlbf*s/ftlbf∗s/ft

 | 6 | DampCoef_lbfs_in | JPT.DampCoefUnit.DampCoef_lbfs_in | lbf∗s/inlbf*s/inlbf∗s/in

 RotateDampCoefUnit 

回転減衰係数に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | RotateDampCoef_Nmms_rad | JPT.RotateDampCoefUnit.RotateDampCoef_Nmms_rad | N∗mm∗s/radN*mm*s/radN∗mm∗s/rad

 | 1 | RotateDampCoef_Nms_rad | JPT.RotateDampCoefUnit.RotateDampCoef_Nms_rad | N∗m∗s/radN*m*s/radN∗m∗s/rad

 | 2 | RotateDampCoef_mNmms_rad | JPT.RotateDampCoefUnit.RotateDampCoef_mNmms_rad | mN∗mm∗s/radmN*mm*s/radmN∗mm∗s/rad

 | 3 | RotateDampCoef_kgfmms_rad | JPT.RotateDampCoefUnit.RotateDampCoef_kgfmms_rad | kgf∗mm∗s/radkgf*mm*s/radkgf∗mm∗s/rad

 | 4 | RotateDampCoef_lbffts_rad | JPT.RotateDampCoefUnit.RotateDampCoef_lbffts_rad | lbf∗ft∗s/radlbf*ft*s/radlbf∗ft∗s/rad

 | 5 | RotateDampCoef_lbfins_rad | JPT.RotateDampCoefUnit.RotateDampCoef_lbfins_rad | lbf∗in∗s/radlbf*in*s/radlbf∗in∗s/rad

 | 6 | RotateDampCoef_Nmms_deg | JPT.RotateDampCoefUnit.RotateDampCoef_Nmms_deg | N∗mm∗s/degN*mm*s/degN∗mm∗s/deg

 | 7 | RotateDampCoef_mNmms_deg | JPT.RotateDampCoefUnit.RotateDampCoef_mNmms_deg | mN∗mm∗s/degmN*mm*s/degmN∗mm∗s/deg

 ModulusUnit 

弾性係数に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Modulus_N_mm2 | JPT.ModulusUnit.Modulus_N_mm2 | N/mm2N/mm^2N/mm2

 | 1 | Modulus_N_m2 | JPT.ModulusUnit.Modulus_N_m2 | N/m2N/m^2N/m2

 | 2 | Modulus_mN_mm2 | JPT.ModulusUnit.Modulus_mN_mm2 | mN/mm2mN/mm^2mN/mm2

 | 3 | Modulus_kgf_mm2 | JPT.ModulusUnit.Modulus_kgf_mm2 | kgf/mm2kgf/mm^2kgf/mm2

 | 4 | Modulus_lbf_ft2 | JPT.ModulusUnit.Modulus_lbf_ft2 | lbf/ft2lbf/ft^2lbf/ft2

 | 5 | Modulus_lbf_in2 | JPT.ModulusUnit.Modulus_lbf_in2 | lbf/in2lbf/in^2lbf/in2

 EnergyUnit 

エネルギーに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 1 | Energy_mJ | JPT.EnergyUnit.Energy_mJ | mJmJmJ

 | 2 | Energy_J | JPT.EnergyUnit.Energy_J | JJJ

 | 3 | Energy_miuJ | JPT.EnergyUnit.Energy_miuJ | μJ\mu JμJ

 | 4 | Energy_kCal | JPT.EnergyUnit.Energy_kCal | kcalkcalkcal

 | 5 | Energy_ftlbf | JPT.EnergyUnit.Energy_ftlbf | ft∗lbfft*lbfft∗lbf

 | 6 | Energy_inlbf | JPT.EnergyUnit.Energy_inlbf | in∗lbfin*lbfin∗lbf

 | 7 | Energy_kJ | JPT.EnergyUnit.Energy_kJ | kJkJkJ

 | 8 | Energy_cal | JPT.EnergyUnit.Energy_cal | calcalcal

 PowerUnit 

パワーに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Power_mW | JPT.PowerUnit.Power_mW | mWmWmW

 | 1 | Power_W | JPT.PowerUnit.Power_W | WWW

 | 2 | Power_miuW | JPT.PowerUnit.Power_miuW | μW\mu WμW

 | 3 | Power_kcal_s | JPT.PowerUnit.Power_kcal_s | kcal/skcal/skcal/s

 | 4 | Power_ftlbf_s | JPT.PowerUnit.Power_ftlbf_s | ft∗lbf/sft*lbf/sft∗lbf/s

 | 5 | Power_inlbf_s | JPT.PowerUnit.Power_inlbf_s | in∗lbf/sin*lbf/sin∗lbf/s

 ThermalExCoefUnit 

線膨張係数に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | ThermalExCoef_K_ | JPT.ThermalExCoefUnit.ThermalExCoef_K_ | /K/K/K

 ThermalConductUnit 

熱伝導率に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | ThermalConduct_mW_mmK | JPT.ThermalConductUnit.ThermalConduct_mW_mmK | mW/mm∗KmW/mm*KmW/mm∗K

 | 1 | ThermalConduct_W_mK | JPT.ThermalConductUnit.ThermalConduct_W_mK | W/m∗KW/m*KW/m∗K

 | 2 | ThermalConduct_miuW_mmK | JPT.ThermalConductUnit.ThermalConduct_miuW_mmK | μW/mm∗K\mu W/mm*KμW/mm∗K

 | 3 | ThermalConduct_kcal_mmhK | JPT.ThermalConductUnit.ThermalConduct_kcal_mmhK | kcal/mm∗h∗Kkcal/mm*h*Kkcal/mm∗h∗K

 | 4 | ThermalConduct_lbf_sK | JPT.ThermalConductUnit.ThermalConduct_lbf_sK | lbf/s∗Klbf/s*Klbf/s∗K

 HeatTransCoefUnit 

対流係数に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 1 | HeatTransCoef_mW_mm2K | JPT.HeatTransCoefUnit.HeatTransCoef_mW_mm2K | mW/mm2∗KmW/mm^2*KmW/mm2∗K

 | 2 | HeatTransCoef_W_m2K | JPT.HeatTransCoefUnit.HeatTransCoef_W_m2K | W/m2∗KW/m^2*KW/m2∗K

 | 3 | HeatTransCoef_miuW_mm2K | JPT.HeatTransCoefUnit.HeatTransCoef_miuW_mm2K | μW/mm2∗K\mu W/mm^2*KμW/mm2∗K

 | 4 | HeatTransCoef_kcal_mm2hK | JPT.HeatTransCoefUnit.HeatTransCoef_kcal_mm2hK | kcal/mm2∗h∗Kkcal/mm^2*h*Kkcal/mm2∗h∗K

 | 5 | HeatTransCoef_lbf_ftsK | JPT.HeatTransCoefUnit.HeatTransCoef_lbf_ftsK | lbf/ft∗s∗Klbf/ft*s*Klbf/ft∗s∗K

 | 6 | HeatTransCoef_lbf_insK | JPT.HeatTransCoefUnit.HeatTransCoef_lbf_insK | lbf/in∗s∗Klbf/in*s*Klbf/in∗s∗K

 SpecificHeatUnit 

比熱に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | SpecificHeat_mJ_tK | JPT.SpecificHeatUnit.SpecificHeat_mJ_tK | mJ/t∗KmJ/t*KmJ/t∗K

 | 1 | SpecificHeat_J_kgK | JPT.SpecificHeatUnit.SpecificHeat_J_kgK | J/kg∗KJ/kg*KJ/kg∗K

 | 2 | SpecificHeat_miuJ_kgK | JPT.SpecificHeatUnit.SpecificHeat_miuJ_kgK | μJ/kg∗K\mu J/kg*KμJ/kg∗K

 | 3 | SpecificHeat_kcal_kgK | JPT.SpecificHeatUnit.SpecificHeat_kcal_kgK | kcal/kg∗Kkcal/kg*Kkcal/kg∗K

 | 4 | SpecificHeat_ftlbf_slugK | JPT.SpecificHeatUnit.SpecificHeat_ftlbf_slugK | ft∗lbf/slug∗Kft*lbf/slug*Kft∗lbf/slug∗K

 | 5 | SpecificHeat_in2_s2K | JPT.SpecificHeatUnit.SpecificHeat_in2_s2K | in2/s2∗Kin^2/s^2*Kin2/s2∗K

 HeatFluxUnit 

熱流束に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | HeatFlux_mW_mm2 | JPT.HeatFluxUnit.HeatFlux_mW_mm2 | mW/mm2mW/mm^2mW/mm2

 | 1 | HeatFlux_W_m2 | JPT.HeatFluxUnit.HeatFlux_W_m2 | W/m2W/m^2W/m2

 | 2 | HeatFlux_miuW_mm2 | JPT.HeatFluxUnit.HeatFlux_miuW_mm2 | μW/mm2\mu W/mm^2μW/mm2

 | 3 | HeatFlux_kcal_mm2h | JPT.HeatFluxUnit.HeatFlux_kcal_mm2h | kcal/mm2∗hkcal/mm^2*hkcal/mm2∗h

 | 4 | HeatFlux_lbf_fts | JPT.HeatFluxUnit.HeatFlux_lbf_fts | lbf/ft∗slbf/ft*slbf/ft∗s

 | 5 | HeatFlux_lbf_ins | JPT.HeatFluxUnit.HeatFlux_lbf_ins | lbf/in∗slbf/in*slbf/in∗s

 HeatGenerationUnit 

発熱に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 1 | HeatGeneration_mW_mm3 | JPT.HeatGenerationUnit.HeatGeneration_mW_mm3 | mW/mm3mW/mm^3mW/mm3

 | 2 | HeatGeneration_W_m3 | JPT.HeatGenerationUnit.HeatGeneration_W_m3 | W/m3W/m^3W/m3

 | 3 | HeatGeneration_miuW_mm3 | JPT.HeatGenerationUnit.HeatGeneration_miuW_mm3 | μW/mm3\mu W/mm^3μW/mm3

 | 4 | HeatGeneration_kcal_mm3h | JPT.HeatGenerationUnit.HeatGeneration_kcal_mm3h | kcal/mm3∗hkcal/mm^3*hkcal/mm3∗h

 | 5 | HeatGeneration_lbf_ft2s | JPT.HeatGenerationUnit.HeatGeneration_lbf_ft2s | lbf/ft2∗slbf/ft^2*slbf/ft2∗s

 | 6 | HeatGeneration_lbf_in2s | JPT.HeatGenerationUnit.HeatGeneration_lbf_in2s | lbf/in2∗slbf/in^2*slbf/in2∗s

 MassPerLengthUnit 

線密度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | MassPerLength_t_mm | JPT.MassPerLengthUnit.MassPerLength_t_mm | t/mmt/mmt/mm

 | 1 | MassPerLength_kg_m | JPT.MassPerLengthUnit.MassPerLength_kg_m | kg/mkg/mkg/m

 | 2 | MassPerLength_kg_mm | JPT.MassPerLengthUnit.MassPerLength_kg_mm | kg/mmkg/mmkg/mm

 | 3 | MassPerLength_kgfs2_mm2 | JPT.MassPerLengthUnit.MassPerLength_kgfs2_mm2 | kgf∗s2/mm2kgf*s^2/mm^2kgf∗s2/mm2

 | 4 | MassPerLength_slug_ft | JPT.MassPerLengthUnit.MassPerLength_slug_ft | slug/ftslug/ftslug/ft

 | 5 | MassPerLength_lbfs2_in2 | JPT.MassPerLengthUnit.MassPerLength_lbfs2_in2 | lbf∗s2/in2lbf*s^2/in^2lbf∗s2/in2

 MassPerAreaUnit 

面密度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | MassPerArea_t_mm2 | JPT.MassPerAreaUnit.MassPerArea_t_mm2 | t/mm2t/mm^2t/mm2

 | 1 | MassPerArea_kg_m2 | JPT.MassPerAreaUnit.MassPerArea_kg_m2 | kg/m2kg/m^2kg/m2

 | 2 | MassPerArea_kg_mm2 | JPT.MassPerAreaUnit.MassPerArea_kg_mm2 | kg/mm2kg/mm^2kg/mm2

 | 3 | MassPerArea_kgfs2_mm3 | JPT.MassPerAreaUnit.MassPerArea_kgfs2_mm3 | kgf∗s2/mm3kgf*s^2/mm^3kgf∗s2/mm3

 | 4 | MassPerArea_slug_ft2 | JPT.MassPerAreaUnit.MassPerArea_slug_ft2 | slug/ft2slug/ft^2slug/ft2

 | 5 | MassPerArea_lbfs2_in3 | JPT.MassPerAreaUnit.MassPerArea_lbfs2_in3 | lbf∗s2/in3lbf*s^2/in^3lbf∗s2/in3

 AreaMomentInertiaUnit 

断面二次モーメント（面積）に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | AreaMomentInertia_mm4 | JPT.AreaMomentInertiaUnit.AreaMomentInertia_mm4 | mm4mm^4mm4

 | 1 | AreaMomentInertia_m4 | JPT.AreaMomentInertiaUnit.AreaMomentInertia_m4 | m4m^4m4

 | 2 | AreaMomentInertia_ft4 | JPT.AreaMomentInertiaUnit.AreaMomentInertia_ft4 | ft4ft^4ft4

 | 3 | AreaMomentInertia_in4 | JPT.AreaMomentInertiaUnit.AreaMomentInertia_in4 | in4in^4in4

 | 4 | AreaMomentInertia_cm4 | JPT.AreaMomentInertiaUnit.AreaMomentInertia_cm4 | cm4cm^4cm4

 TorsionalConstUnit 

ねじり剛性に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | TorsionalConst_mm4 | JPT.TorsionalConstUnit.TorsionalConst_mm4 | mm4mm^4mm4

 | 1 | TorsionalConst_m4 | JPT.TorsionalConstUnit.TorsionalConst_m4 | m4m^4m4

 | 2 | TorsionalConst_ft4 | JPT.TorsionalConstUnit.TorsionalConst_ft4 | ft4ft^4ft4

 | 3 | TorsionalConst_in4 | JPT.TorsionalConstUnit.TorsionalConst_in4 | in4in^4in4

 | 4 | TorsionalConst_cm4 | JPT.TorsionalConstUnit.TorsionalConst_cm4 | cm4cm^4cm4

 WarpCoefUnit 

ワーピング係数に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | WarpCoef_mm6 | JPT.WarpCoefUnit.WarpCoef_mm6 | mm6mm^6mm6

 | 1 | WarpCoef_m6 | JPT.WarpCoefUnit.WarpCoef_m6 | m6m^6m6

 | 2 | WarpCoef_ft6 | JPT.WarpCoefUnit.WarpCoef_ft6 | ft6ft^6ft6

 | 3 | WarpCoef_in6 | JPT.WarpCoefUnit.WarpCoef_in6 | in6in^6in6

 | 4 | WarpCoef_cm6 | JPT.WarpCoefUnit.WarpCoef_cm6 | cm6cm^6cm6

 MassMomentInertiaPerLengthUnit 

単位長さあたりの質量慣性モーメントに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | MassMomentInertiaPerLength_tmm | JPT.MassMomentInertiaPerLengthUnit.MassMomentInertiaPerLength_tmm | t∗mmt*mmt∗mm

 | 1 | MassMomentInertiaPerLength_kgm | JPT.MassMomentInertiaPerLengthUnit.MassMomentInertiaPerLength_kgm | kg∗mkg*mkg∗m

 | 2 | MassMomentInertiaPerLength_kgmm | JPT.MassMomentInertiaPerLengthUnit.MassMomentInertiaPerLength_kgmm | kg∗mmkg*mmkg∗mm

 | 3 | MassMomentInertiaPerLength_kgfs2 | JPT.MassMomentInertiaPerLengthUnit.MassMomentInertiaPerLength_kgfs2 | kgf∗s2kgf*s^2kgf∗s2

 | 4 | MassMomentInertiaPerLength_slugft | JPT.MassMomentInertiaPerLengthUnit.MassMomentInertiaPerLength_slugft | slug∗ftslug*ftslug∗ft

 | 5 | MassMomentInertiaPerLength_lbfs2 | JPT.MassMomentInertiaPerLengthUnit.MassMomentInertiaPerLength_lbfs2 | lbf∗s2lbf*s^2lbf∗s2

 MomentInertiaUnit 

慣性（面積）モーメントに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | MomentInertia_tmm2 | JPT.MomentInertiaUnit.MomentInertia_tmm2 | t∗mm2t*mm^2t∗mm2

 | 1 | MomentInertia_kgm2 | JPT.MomentInertiaUnit.MomentInertia_kgm2 | kg∗m2kg*m^2kg∗m2

 | 2 | MomentInertia_kgmm2 | JPT.MomentInertiaUnit.MomentInertia_kgmm2 | kg∗mm2kg*mm^2kg∗mm2

 | 3 | MomentInertia_kgfmms2 | JPT.MomentInertiaUnit.MomentInertia_kgfmms2 | kgf∗mm∗s2kgf*mm*s^2kgf∗mm∗s2

 | 4 | MomentInertia_slugft2 | JPT.MomentInertiaUnit.MomentInertia_slugft2 | slug∗ft2slug*ft^2slug∗ft2

 | 5 | MomentInertia_lbfins2 | JPT.MomentInertiaUnit.MomentInertia_lbfins2 | lbf∗in∗s2lbf*in*s^2lbf∗in∗s2

 StressUnit 

応力に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Stress_N_mm2 | JPT.StressUnit.Stress_N_mm2 | N/mm2N/mm^2N/mm2

 | 1 | Stress_N_m2 | JPT.StressUnit.Stress_N_m2 | N/m2N/m^2N/m2

 | 2 | Stress_mN_mm2 | JPT.StressUnit.Stress_mN_mm2 | mN/mm2mN/mm^2mN/mm2

 StrainUnit 

ひずみに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Strain_Null | JPT.StrainUnit.Strain_Null | 

 StrainEnergyUnit 

ひずみエ ネルギーに使用可能な単位。

 | ID | Key Name | Usage | Description

 |  | StrainEnergy_Nm | JPT.StrainEnergyUnit.StrainEnergy_Nm | N−mN-mN−m

 |  | StrainEnergy_Nmm | JPT.StrainEnergyUnit.StrainEnergy_Nmm | N−mmN-mmN−mm

 ThermalEnergyUnit 

熱エネルギーに使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | ThermalEnergy_J | JPT.ThermalEnergyUnit.ThermalEnergy_J | JJJ

 | 1 | ThermalEnergy_cal | JPT.ThermalEnergyUnit.ThermalEnergy_cal | calcalcal

 | 2 | ThermalEnergy_mJ | JPT.ThermalEnergyUnit.ThermalEnergy_mJ | mJmJmJ

 FrequencyUnit 

周波数に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Frequency_hz | JPT.FrequencyUnit.Frequency_hz | HzHzHz

 VolumeEnergyDensityUnit 

体積エネルギー密度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | VolumeEnergyDensity_J_m3 | JPT.VolumeEnergyDensityUnit.VolumeEnergyDensity_J_m3 | J/m3J/m^3J/m3

 | 1 | VolumeEnergyDensity_J_mm3 | JPT.VolumeEnergyDensityUnit.VolumeEnergyDensity_J_mm3 | J/mm3J/mm^3J/mm3

 | 2 | VolumeEnergyDensity_mJ_mm3 | JPT.VolumeEnergyDensityUnit.VolumeEnergyDensity_mJ_mm3 | mJ/mm3mJ/mm^3mJ/mm3

 ElectricalResistivityUnit 

電気抵抗率に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | ElectricalResistivity_Ohm_m | ElectricalResistivity_Ohm_m | Ω⋅m\Omega \cdot mΩ⋅m

 | 1 | ElectricalResistivity_Ohm_mm | ElectricalResistivity_Ohm_mm | Ω⋅mm\Omega \cdot mmΩ⋅mm

 StressReciprocalUnit(temp)  

応力逆数に使用可能な単位。

 ThermalRadiationUnit 

熱放射に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | ThermalRadiation_W_m2K4 | JPT.ThermalRadiationUnit.ThermalRadiation_W_m2K4 | W/m2∗K4W/m^2*K^4W/m2∗K4

 | 1 | ThermalRadiation_mW_mm2K4 | JPT.ThermalRadiationUnit.ThermalRadiation_mW_mm2K4 | mW/mm2∗K4mW/mm^2*K^4mW/mm2∗K4

 | 2 | ThermalRadiation_kcal_smm2K4 | JPT.ThermalRadiationUnit.ThermalRadiation_kcal_smm2K4 | kcal/s∗mm2∗K4kcal/s*mm^2*K^4kcal/s∗mm2∗K4

 DisplacementUnit 

変位に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Displacement_mm | JPT.Displacement.Displacement_mm | mmmmmm

 | 1 | Displacement_m | JPT.Displacement.Displacement_m | mmm

 | 2 | Displacement_ft | JPT.Displacement.Displacement_ft | ftftft

 | 3 | Displacement_in | JPT.Displacement.Displacement_in | ininin

 | 4 | Displacement_cm | JPT.Displacement.Displacement_cm | cmcmcm

 EnergyDensityUnit 

エネルギー密度に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | EnergyDensity_J_m3 | JPT.EnergyDensityUnit.EnergyDensity_J_m3 | J/m3J/m^3J/m3

 | 1 | EnergyDensity_mJ_mm3 | JPT.EnergyDensityUnit.EnergyDensity_mJ_mm3 | mJ/mm3mJ/mm^3mJ/mm3

 | 2 | EnergyDensity_Kcal_mm3 | JPT.EnergyDensityUnit.EnergyDensity_Kcal_mm3 | kcal/mm3kcal/mm^3kcal/mm3

 TemperatureGradientUnit 

温度勾配に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | TemperatureGradient_K_m | JPT.TemperatureGradientUnit.TemperatureGradient_K_m | K/mK/mK/m

 | 1 | TemperatureGradient_K_mm | JPT.TemperatureGradientUnit.TemperatureGradient_K_mm | K/mmK/mmK/mm

 CurrentUnit 

電流に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Current_A | JPT.CurrentUnit.Current_A | AAA

 | 1 | Current_mA | JPT.CurrentUnit.Current_mA | mAmAmA

 | 2 | Current_uA | JPT.CurrentUnit.Current_uA | μA\mu AμA

 | 3 | Current_kA | JPT.CurrentUnit.Current_kA | kAkAkA

 VoltageUnit 

電圧に使用可能な単位。

 | ID | Key Name | Usage | Description

 | 0 | Voltage_V | JPT.VoltageUnit.Voltage_V | VVV

 | 1 | Voltage_mV | JPT.VoltageUnit.Voltage_mV | mVmVmV

 | 2 | Voltage_uV | JPT.VoltageUnit.Voltage_uV | μV\mu VμV

 | 3 | Voltage_kV | JPT.VoltageUnit.Voltage_kV | kVkVkV

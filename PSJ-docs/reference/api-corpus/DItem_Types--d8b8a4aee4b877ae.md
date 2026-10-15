# DItem Types

DItem Types

This is an enumeration type represents type of DItem in Jupiter.

The ID of item which is primarily used in functions can be referred to in the Int Notation column.

However, in order to explicitly describe meaning of ID, user can use JPT.DItemType.DItem instead of specifying ID.

For example: JPT.DItemType.BODY is equal to ID = 3.

 | Int Notation | Type of DItem | Description

 | 2 | INST | Sub Assembly  (For tree display)

 | 3 | BODY | Parts

 | 4 | VERTEX | Vertex

 | 5 | EDGE | Edge

 | 6 | FACE | Face

 | 7 | SOLID | Solid shape 
※Not an element

 | 8 | SHAPELINK | Shape link

 | 9 | BODYLINK | Body link

 | 10 | NODE | Node

 | 11 | ELEM | Element

 | 12 | REF_BODY | Reference parts

 | 13 | REF_VERTEX | Reference part composition vertex

 | 14 | REF_EDGE | Reference part composition edge

 | 15 | REF_FACE | Reference part composition face

 | 16 | REF_SOLID | Reference part composition solid

 | 17 | REF_SHAPELINK | Reference shape link

 | 18 | REF_BODYLINK | Reference body link

 | 19 | REF_NODE | Reference part composition node

 | 20 | REF_ELEM | Reference part component

 | 21 | LOCAL_SETTING | Local settings

 | 22 | MATERIAL | Material

 | 23 | ENTITY_ATTR_CAD_INFO | CAD attribute information

 | 24 | FEM_FIELD_SCALAR | For LBC-FIELD (Scalar)

 | 25 | FEM_FIELD_VECTOR | For LBC-FIELD (Vector)

 | 26 | FEM_FIELD_TENSOR | For LBC-FIELD (Tensor)

 | 27 | COORD | Coordinate system

 | 28 | LOADCASE | Load case

 | 29 | LBC_FORCE | Boundary condition: Force

 | 30 | LBC_FORCE_ND | Boundary condition: Force (Normal direction)

 | 31 | LBC_FORCE_QUADRATIC | Boundary condition: Force (Cylindrical surface load (Secondary))

 | 32 | LBC_FORCE_SINE | Boundary condition: Force (Cylindrical surface load (Sine))

 | 33 | LBC_FORCE_VECTOR | Boundary condition: Force (Cylindrical surface load (Vector))

 | 34 | LBC_NOLIN1 | Boundary condition: Force (Non-linear force (NOLIN1))

 | 35 | LBC_NOLIN3 | Boundary condition: Force (Non-linear force (NOLIN3))

 | 36 | LBC_NOLIN4 | Boundary condition: Force (Non-linear force (NOLIN4))

 | 37 | LBC_CONSTRAINT | Boundary condition: Constraint

 | 38 | LBC_ENFORCED_DISP | Boundary condition: Forced displacement

 | 39 | LBC_GRAVITY | Boundary condition: Gravity

 | 40 | LBC_G_PRESSURE | Boundary condition: Pressure (General)

 | 41 | LBC_H_PRESSURE | Boundary condition: Pressure (Hydrostatic pressure)

 | 42 | LBC_T_PRESSURE | Boundary condition: Pressure (2 points designation)

 | 43 | LBC_PRESSURE_QUADRATIC | Boundary condition: Pressure (Cylindrical surface load (Secondary))

 | 44 | LBC_PRESSURE_SINE | Boundary condition: Pressure (Cylindrical load (Sine))

 | 45 | LBC_T_CENTRIFUGAL_FORCE | Boundary condition: Centrifugal force (2 points designation)

 | 46 | LBC_CS_CENTRIFUGAL_FORCE | Boundary condition: Centrifugal force (Coordinate system)

 | 47 | LBC_TEMP_INI | Boundary condition: Initial temperature

 | 48 | LBC_TEMP_LOAD | Boundary condition: Temperature load

 | 49 | LBC_TEMP_LOAD_GENERAL | Boundary condition: Temperature load (Constant)

 | 50 | LBC_TEMP_LOAD_ADVC_FILE | Boundary condition: Temperature load (ADVC file)

 | 51 | LBC_TEMP_LOAD_NASTRAN | Boundary condition: Temperature load (Nastran Punch)

 | 53 | LBC_TEMP_BOUNDARY | Boundary condition: Boundary temperature

 | 54 | LBC_CONCENTRATE_FLUX | Boundary condition: Concentrated heat flux

 | 55 | LBC_SURFACE_FLUX | Boundary condition: Surface heat flux

 | 56 | LBC_THERMAL_CONVECTION | Boundary condition: Surface convection (Constant)

 | 57 | LBC_ENFORCED_VELOCITY | Boundary condition: Forced speed

 | 58 | LBC_ENFORCED_ACCELERATION | Boundary condition: Forced acceleration

 | 59 | LBC_DYNAMIC_INITIAL_CONDITION | Boundary condition: Dynamic initial condition

 | 60 | LBC_CONTACT_CLEARANCE | Boundary connection: Contact (Contact surface gap amount)

 | 61 | LBC_MAPPING_PRESSURE | Boundary condition: Pressure (Surface mapping)

 | 62 | LBC_MAPPING_FORCE | Boundary condition: Force (Surface mapping)

 | 63 | LBC_MAPPING_TEMP_LOAD | Boundary condition: Temperature load (Whole mapping)

 | 64 | LBC_MAPPING_TEMP_BOUNDARY | Boundary condition: Boundary temperature (Surface mapping)

 | 65 | LBC_MAPPING_THERMAL_CONVECTION | Boundary condition: Surface convection (Surface mapping)

 | 66 | LBC_INITSTRESS_GENERAL | Boundary condition: Initial stress

 | 174 | LBC_MAPPING_TEMP_INIT | Boundary condition: Initial temperature (Whole mapping)

 | 68 | LBC_PRETENSION | Connection: Pretension (General)

 | 69 | LBC_PRETENSION_ABAQUS | Connection: Pretension (Abaqus)

 | 70 | LBC_SURFACE_LOADS | Boundary condition: Pressure (ADVC)

 | 71 | LBC_SUBMODEL_FORCED_DISP | Boundary condition: Sub-model forced displacement

 | 72 | LBC_SUBMODEL_FORCED_TEMP | Boundary condition: Sub-model forced temperature

 | 73 | LBC_SUBMODEL_FORCED_FLUX | Boundary condition: Sub-model forced heat flux

 | 74 | LBC_INSIDE_HEAT_GENERATION | Boundary condition: Internal heat flux

 | 75 | LBC_RIGIDWALL | Connection: Rigid wall

 | 76 | LBC_INIT_ANGULAR_VEL_ABAQUS | Boundary condition: Initial angular velocity (Abaqus)

 | 77 | LBC_WELD | Boundary condition: Weld

 | 78 | SUP_GROUP | Parent group (For tree display)

 | 79 | GROUP | Group

 | 80 | ELEMEDGE_GROUP | Element edge group

 | 81 | FIELD_DATA | Field data

 | 82 | PROPERTY_0D_MASS | Connection: Mass element

 | 83 | PROPERTY_1D_BAR | Property: 1D (Bar element)

 | 84 | PROPERTY_1D_BEAM | Property: 1D (Beam element)

 | 85 | PROPERTY_1D_ROD | Property: 1D (Rod)

 | 86 | PROPERTY_1D_PLOT | Connection: Plot

 | 87 | PROPERTY_2D_SHELL | Property: 2D (Shell)

 | 88 | PROPERTY_2D_COMPOSITE_SHELL | Property: 2D (Laminated material)

 | 89 | PROPERTY_3D_SOLID | Property: 3D (Solid)

 | 90 | PROPERTY_3D_GASKET | Property: 3D (Gasket)

 | 91 | PROPERTY_3D_COHESIVE | Property: 3D (Adhesive element)

 | 92 | PROPERTY_3D_WELDBEAD | Property: 3D (Weld bead)

 | 93 | SECTION_GENERAL | Property: 1D (Section (General))

 | 94 | SECTION_LIBRARY | Property: 1D (Section (Library))

 | 95 | SECTION_SKETCHER | Property: 1D (Section (Sketcher))

 | 96 | CONNECT_MPC | Connection: MPC

 | 97 | CONNECT_SPRING | Connection: Spring element

 | 98 | CONNECT_RBE2 | Connection: RBE2

 | 99 | CONNECT_CONM | Connection: Mass element

 | 100 | CONNECT_PROD | Connection: Rod element

 | 101 | CONNECT_RBAR | Connection: Bar element

 | 102 | CONNECT_RBE3 | Connection: RBE3

 | 103 | CONNECT_BUSH | Connection: Bush

 | 104 | CONNECT_MOMENT | Connection: Moment

 | 105 | CONNECT_WELD | Connection: Weld

 | 106 | CONNECT_DAMPER | Connection: Damper

 | 107 | CONNECT_CONNECTOR | Connection: Connector

 | 108 | CONTACT_ADVC | Connection: Contact (ADVC)

 | 109 | CONTACT_NXNASTRAN | Connection: Contact (NX Nastran)

 | 110 | CONTACT_MSCNASTRAN | Connection: Contact (MSC Nastran)

 | 111 | CONTACT_ABAQUS | Connection: Contact (Abaqus)

 | 112 | CONTACT_ANSYS | Connection: Contact (Ansys)

 | 113 | CONTACT | Connection: Contact

 | 114 | CUSTOM_ATTR_STRING | 

 | 115 | CUSTOM_ATTR_VECTOR | 

 | 116 | CUSTOM_ATTR_DOUBLE | 

 | 117 | DCS | Displacement coordinate system

 | 118 | ADVCPROCESS | ADVC process

 | 119 | ADVCPROCESS_STATIC | ADVC process (Static)

 | 120 | ADVCPROCESS_DYNAMIC | ADVC process (Dynamic)

 | 121 | ADVCPROCESS_EIGEN | ADVC process (Eigen value)

 | 122 | ADVCPROCESS_CREEP | ADVC process (Creep)

 | 123 | ADVCPROCESS_DYNAMIC_EXPLICIT | ADVC process (Dynamic explicit)

 | 124 | ADVCPROCESS_FATIGUE | ADVC process (Fatigue)

 | 125 | ADVCPROCESS_MODAL_FREQ_RESP | ADVC process (Modal frequency response)

 | 126 | ADVCPROCESS_RESP_SPEC | ADVC process (Response spectrum)

 | 127 | ADVCPROCESS_RAND_RESP | ADVC process (Random response)

 | 128 | ADVCPROCESS_SSH | ADVC process (Steady state heat)

 | 129 | ADVCPROCESS_TH | ADVC process (Transient heat)

 | 130 | ADVCJOB | ADVC job

 | 131 | ABAQSTEPS | Abaqus step

 | 132 | ABAQSTEPS_STRUCT | Abaqus Step: Structure

 | 133 | ABAQSTEPS_THERMAL | Abaqus step: Heat transfer

 | 134 | ABAQSTEPS_STRUCT_STATIC | Abaqus Step: Structure (Static General)

 | 135 | ABAQSTEPS_STRUCT_FREQUENCY | Abaqus Step: Structure (Natural Frequency)

 | 136 | ABAQSTEPS_STRUCT_COUPLEDTD | Abaqus Step: Structure(Coupled-Temp-Displacement)

 | 137 | ABAQSTEPS_STRUCT_DYNAMIC | Abaqus Step: Structure (Dynamic Implicit)

 | 138 | ABAQSTEPS_STRUCT_DYNAMIC_COUPLEDTD | Abaqus Step: Structure (Dynamic Coupled-Temp-Displacement, Explicit)

 | 139 | ABAQSTEPS_STRUCT_DYNAMIC_EXPLICIT | Abaqus Step: Structure (Dynamic Explicit)

 | 140 | ABAQSTEPS_STRUCT_STATICRISK | Abaqus Step: Structure (Static Riks)

 | 141 | ABAQSTEPS_THERMAL_SS | Abaqus Step: Heat transfer (Steady State)

 | 142 | ABAQSTEPS_THERMAL_TRANSIENT | Abaqus Step: Heat (Transient)

 | 143 | ABAQUSJOB | Abaqus job

 | 144 | LBC_MAPPING_HEATFLUX | Boundary condition: Heat flux (Surface mapping)

 | 145 | CONNECT_GAP | Connection: Gap

 | 146 | ANSYSJOB | Ansys job

 | 147 | NASTRANJOB | Nastran job

 | 148 | DYANAMISJOB | TS-Solver job

 | 149 | WELDORDER | Weld order

 | 150 | ATTRIBUTE_FXWELD | Attribute fix weld

 | 151 | ACTRANJOB | Actran job

 | 152 | LSDYNAJOB | LS-Dyna job

 | 153 | NCS | Nodal coordinate system

 | 154 | ATTRIBUTE_PS_BLENDSURFACE | 

 | 155 | LBC_DOFSET | Boundary condition: Definition of degrees of freedom

 | 156 | BEAM_PROP_ATTR | Property: Beam element attribute 1

 | 157 | BEAM_PROP_ATTR2 | Property: Beam element attribute 2

 | 158 | SHELL_PROP_ATTR | Property: Shell attribute

 | 159 | CONN_PROP_ATTR | Property: Join attribute

 | 160 | LBC_PRETENSION_NXN | 

 | 161 | LBC_MAPPING_TEMP_MARINE_ENGINE | 

 | 162 | USER_PROP | 

 | 163 | CONNECTION_ELEMENT | Connection: Connection element

 | 164 | CONTACT_TSSS | Connection: Contact (SunShine)

 | 165 | LBC_MAPPING_FORCEDDISPLACEMENT | Boundary condition: Force Displacement (surface mapping)

 | 166 | LBC_MAPPING_FORCED_TEMP | Boundary condition: Force Temperature (surface mapping)

 | 167 | NASTRAN_POSTJOB | Nastran Post job

 | 168 | ADVC2_POSTJOB | ADVC Post job

 | 169 | USER_RESULT | User Result Post

 | 170 | LBC_PRETENSION_ADVC | Pre Tension : ADVC

 | 171 | CONTACT_TSSOLVER | Contact : for TS-Solver

 | 172 | NASTRAN_HDF5_POSTJOB | Nastran HDF5 Post job

 | 175 | PROPERTY_2D_RIGID_BODY | Property : Rigid Body

 | 176 | LBC_PRETENSION_SUNSHINE | Pre Tension: SunShine

 | 179 | CONTACT_PERMAS | Contact: Permas

 | 181 | FRONTISTRSTEP | Step : FrontISTR

 | 182 | UNV_POSTJOB | Universal Post job

 | 183 | TSV_POSTJOB | TSV Post job

 | 184 | MARCJOB | Marc Post job

 | 185 | MARCSTEPS_STRUCT_STATIC | Marc step - static

 | 186 | MARCSTEPS_STRUCT_FREQUENCY | Marc step - frequency

 | 187 | MARCSTEPS_THERMAL_SS | Marc step - thermal

 | 188 | MARCSTEPS_THERMAL_TRANSIENT | Marc step - transient

 | 173 | PERMASJOB | Permas Post job

 | 180 | FRONTISTRJOB | FrontISTR Post job

 | 192 | POST_NODE | Node in Post Database

 | 193 | POST_ELEM | Element in Post Database

 | 194 | POST_RESULT_CURVE | Post result curve

 | 195 | POST_FREQ_ANALYSIS | Post frequency analysis

 | 196 | POST_FREQ_RESULT_CURVE | Post frequency result curve

 | 197 | POST_FREQ_LOAD | Post frequency load

 | 198 | POST_FREQ_LOADCASE | Post frequency load case

 | 199 | POST_FREQ_RESPONSE | Post frequency response

 | 200 | POST_FREQ_INTERACTIVE_LOAD_AND_RESPONSE | Post frequency interactive load and response

 | 201 | POST_FREQ_RESULT_MPF_CURVE | Post frequency MPF curve

 | 202 | POST_TRANS_ANALYSIS | Post transient analysis

 | 203 | POST_TRANS_RESULT_CURVE | Post transient result curve

 | 204 | POST_TRANS_LOAD | Post transient load

 | 205 | POST_TRANS_LOADCASE | Post transient load case

 | 206 | POST_TRANS_RESPONSE | Post transient response

 | 207 | POST_TRANS_RESULT_MPF_CURVE | Post transient MPF curve

 | 208 | POST_BTXBTA | Post btx bta

 | 209 | POST_ACTRAN_ANALYSIS | Post actran analysis

 | 210 | POST_ACTRAN_DOMAIN_GROUP | Post actran domain group

 | 211 | POST_ACTRAN_DOMAIN | Post actran domain

 | 212 | POST_ACTRAN_SURFACE_GROUP | Post actran surface group

 | 213 | POST_ACTRAN_SURFACE | Post actran surface

 | 214 | POST_ACTRAN_POINT_GROUP | Post actran point group

 | 215 | POST_ACTRAN_POINT | Post actran point

 | 216 | POST_ACTRAN_LOADCASE | Post actran load case

 | 218 | POST_GURURI_RESPONSE | Post gururi response

 | 219 | POST_GURURI_SWEEP | Post gururi sweep

 | 220 | POST_FFT_CONDITION | Post FFT condition

 | 221 | POST_FREQ_ANALYSIS_SOLVER | Post frequency analysis (solver)

 | 222 | POST_FREQ_LOAD_SOLVER | Post frequency load (solver)

 | 223 | POST_FREQ_RESPONSE_SOLVER | Post frequency response (solver)

 | 224 | POST_FREQ_INTERACTIVE_ANALYSIS | Post frequency interactive analysis

 | 225 | POST_MBD_FATIGUE_ANALYSIS | Post fatigue analysis

 | 226 | POST_MBD_FATIGUE_RESULT | Post fatigue result

 | 227 | POST_MBD_FATIGUE_THERMAL_STRESS | Post fatigue thermal stress

 | 228 | POST_MBD_FATIGUE_NODAL_TEMPERATURE | Post fatigue nodal temperature

 | 229 | POST_MBD_FATIGUE_PROPERTY | Post fatigue property

 | 230 | POST_MBD_FATIGUE_CONDITION | Post fatigue  condition

 | 231 | CONNECT_LINEARGAP | Connection: Linear Gap

 | 232 | OPTISHAPE_TS_JOB | OPTISHAPE Post job

 | 233 | POST_MBD_FATIGUE_STRESS_RECOVERY | 

 | 234 | CONTACT_FRONTISTR | Connection: Contact (FRONTISTR)

 | 235 | POST_ACTRAN_CONTRIBUTION_RESULT_CURVE | Post Actran contribution result curve

 | 236 | POST_MAC_SENSOR | Post MAC Sensor

 | 237 | POST_MAC_SENSOR_COLLECTION | Post MAC Sensor collection

 | 238 | POST_SURFACE_DISTANCE | Post surface distance

 | 240 | POST_ACOUSTIC_TRANSMISSION_LOSS | Post acoustic transmission loss

 | 241 | POST_ACOUSTIC_TL_PCH_RESULT | Post acoustic TL PCH result

 | 242 | POST_ACOUSTIC_TL_CONDITION | Post acoustic TL condition

 | 243 | POST_ACOUSTIC_TRANSMISSION_LOSS_CONDITION_CURVE | Post acoustic transmission loss condition curve

 | 246 | WAON_ANALYSIS_JOB | Waon: analysis job

 | 247 | POST_MAC_DATA | Post MAC factor

 | 248 | POST_ROUGH_SURF | Post MAC factor

 | 249 | POST_MAC_FACTOR_CALCULATION | Post MAC factor

 | 259 | CONTACT_LSDYNA | Contact: LS-Dyna

 | 260 | ADVCPROCESS_RDNLK | ADVC Process: RDNLK

 | 261 | WAON_STRUCTURE_MANAGER | Waon: structure manager

 | 262 | WAON_SOUNDSOURCE_MANAGER | Waon: soundsource manager

 | 263 | WAON_ABSORPTION_MANAGER | Waon: absorption manager

 | 264 | POST_FATIGUE_MATERIAL | Post fagigue material

 | 265 | WAON_FIELDCAL_MANAGER | Waon: field cal manager

 | 266 | WAON_TRANSFERFUNC_MANAGER | Waon: transfer func manager

 | 267 | POST_RESULT_TREE_RENAME | Post result tree rename

 | 270 | CUSTOM_NOTE | Custom note

 | 271 | CUSTOM_NOTE_COLLECTION | Custom note collection

 | 272 | POST_TRANS_ANALYSIS_SOLVER | Post's transient analysis (solver)

 | 273 | POST_TRANS_LOAD_SOLVER | post's load setting for transient analysis

 | 274 | POST_TRANS_RESPONSE_SOLVER | Post's response setting for  transient analysis

 | 275 | LBC_ACCELERATION_LOAD_ACCEL | Boundary condition: Body Loads > Acceleration Load > ACCEL

 | 276 | LBC_ACCELERATION_LOAD_ACCEL1 | Boundary condition: Body Loads > Acceleration Load > ACCEL1

 | 277 | LBC_ENFORCED_RELATIVE_DISP | Boundary Conditions>Enforced Load>Enforced Displacement for Implicit Nonlinear

 | 278 | MEASURE_NOTE | Measure note

 | 279 | MEASURE_NOTE_COLLECTION | Measure note collection

 | 283 | LBC_PRETENSION_MSC_NASTRAN | Connections > Pretension > MSC Nastran

 | 284 | LBC_PRESCRIBED_MOTION | Prescribed motion For LS-Dyna

 | 285 | DAMPING_PART_STIFFNESS | Damping part stiffness For LS-Dyna

 | 286 | CONNECT_RBC | RBC For LS-Dyna

 | 287 | POST_ERP | Calculation > ERP

 | 288 | POST_PLOT_ERP | Calculation > ERP (Plot)

 | 289 | LBC_COIL | SunShine

 | 290 | LBC_THERMAL_SHELL_CONVECTION | Shell Convection (Nastran, Sun Shine)

 | 291 | LBC_EXTERNAL_CURRENT_DENSITY | External current density load for SunShine

 | 292 | LBC_MAGNETIC_POTENTIAL | SunShine's Electric Potential functions

 | 293 | LBC_SURFACE_CURRENT_DENSITY | SunShine's Electric Potential functions

 | 294 | LBC_ELECTRIC_POTENTIAL | SunShine's Electric Potential functions

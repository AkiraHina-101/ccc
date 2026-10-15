# DItem Types

DItem Types

This is an enumeration type represents type of DItem in Jupiter.

The ID of item which is primarily used in functions can be referred to in the Int Notation column.

However, in order to explicitly describe meaning of ID, user can use JPT.DItemType.DItem instead of specifying ID.

For example: JPT.DItemType.BODY is equal to ID = 3.

 | Int Notation | Type of DItem | Description

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

 | 40 | LBC_G_PRESSURE | Boundary condition: Pressure (general)

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

 | 52 | LBC_TEMP_LOAD_ADVC_RESULT_REFERENCE | Boundary condition: Temperature load (Overall mapping)

 | 53 | LBC_TEMP_BOUNDARY | Boundary condition: Boundary temperature

 | 54 | LBC_CONCENTRATE_FLUX | Boundary condition: Concentrated heat flux

 | 55 | LBC_SURFACE_FLUX | Boundary condition: Surface heat flux

 | 56 | LBC_THERMAL_CONVECTION | Boundary condition: Surface convection

 | 57 | LBC_ENFORCED_VELOCITY | Boundary condition: Forced speed

 | 58 | LBC_ENFORCED_ACCELERATION | Boundary condition: Forced acceleration

 | 59 | LBC_DYNAMIC_INITIAL_CONDITION | Boundary condition: Dynamic initial condition

 | 60 | LBC_CONTACT_CLEARANCE | Boundary connection: Contact (Contact surface gap amount)

 | 61 | LBC_MAPPING_PRESSURE | Boundary condition: Pressure (surface mapping)

 | 62 | LBC_MAPPING_FORCE | Boundary condition: Force (surface mapping)

 | 63 | LBC_MAPPING_TEMP_LOAD | Boundary condition: Temperature load (surface mapping)

 | 64 | LBC_MAPPING_TEMP_BOUNDARY | Boundary condition: Boundary temperature (Surface mapping)

 | 65 | LBC_MAPPING_THERMAL_CONVECTION | Boundary condition: Surface convection (surface mapping)

 | 66 | LBC_INITSTRESS_GENERAL | Boundary condition: Initial stress

 | 174 | LBC_MAPPING_TEMP_INIT | Boundary condition: Initial temperature (Surface mapping)

 | 67 | LBC_INITSTRESS_MAPPING | Boundary condition: Initial stress (Surface mapping)

 | 68 | LBC_PRETENSION | Connection: Pretension (general)

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

 | 183 | TSV_POSTJOB | TSV Post job

 | 184 | MARCJOB | Marc Post job

 | 173 | PERMASJOB | Permas Post job

 | 180 | FRONTISTRJOB | FrontISTR Post job

 | 192 | POST_NODE | Node in Post Database

 | 193 | POST_ELEM | Element in Post Database

 | 232 | OPTISHAPE_TS_JOB | OPTISHAPE Post job

 | 233 | CONTACT_FRONTISTR | Connection: Contact (FRONTISTR)

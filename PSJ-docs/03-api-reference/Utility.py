from jupiterutils.PSJ_Interpreter import RUN_FILE, RUN_DEBUG, RUN_CODE
import win32gui

########################################################################
# PSJ Utilities
########################################################################

def JPT_RUN_LINE(message):
    return RUN_DEBUG(message, False)

def JPT_RUN_FILE(message):
    RUN_FILE(message, False)

def JPT_RUN_CODE(message):
    RUN_CODE(message, False)

class EntityType:
    values = "JPT.EntityType.values"
    UNKNOWN = 0
    INST = 2
    PROJECT = 1
    BODY = 3
    VERTEX = 4
    EDGE = 5
    FACE = 6
    SOLID = 7
    SHAPELINK = 8
    ELEM = 11
    BODYLINK = 9
    REF_BODY = 12
    REF_VERTEX = 13
    NODE = 10
    REF_FACE = 15
    REF_SOLID = 16
    REF_SHAPELINK = 17
    REF_EDGE = 14
    REF_BODYLINK = 18
    LOCAL_SETTING = 21
    REF_ELEM = 20
    MATERIAL = 22
    ENTITY_ATTR_CAD_INFO = 23
    FEM_FIELD_SCALAR = 24
    FEM_FIELD_TENSOR = 26
    FEM_FIELD_VECTOR = 25
    REF_NODE = 19
    LOADCASE = 28
    COORD = 27
    LBC_FORCE = 29
    LBC_FORCE_QUADRATIC = 31
    LBC_FORCE_VECTOR = 33
    LBC_FORCE_SINE = 32
    LBC_FORCE_ND = 30
    LBC_NOLIN3 = 35
    LBC_NOLIN1 = 34
    LBC_ENFORCED_DISP = 38
    LBC_CONSTRAINT = 37
    LBC_NOLIN4 = 36
    LBC_GRAVITY = 39
    LBC_H_PRESSURE = 41
    LBC_G_PRESSURE = 40
    LBC_T_PRESSURE = 42
    LBC_PRESSURE_QUADRATIC = 43
    LBC_T_CENTRIFUGAL_FORCE = 45
    LBC_CS_CENTRIFUGAL_FORCE = 46
    LBC_PRESSURE_SINE = 44
    LBC_TEMP_INI = 47
    LBC_TEMP_LOAD = 48
    LBC_TEMP_LOAD_ADVC_FILE = 50
    LBC_TEMP_LOAD_GENERAL = 49
    LBC_TEMP_LOAD_ADVC_RESULT_REFERENCE = 52
    LBC_CONCENTRATE_FLUX = 54
    LBC_TEMP_BOUNDARY = 53
    LBC_TEMP_LOAD_NASTRAN = 51
    LBC_SURFACE_FLUX = 55
    LBC_ENFORCED_VELOCITY = 57
    LBC_ENFORCED_ACCELERATION = 58
    LBC_DYNAMIC_INITIAL_CONDITION = 59
    LBC_MAPPING_FORCE = 62
    LBC_MAPPING_PRESSURE = 61
    LBC_THERMAL_CONVECTION = 56
    LBC_MAPPING_TEMP_LOAD = 63
    LBC_MAPPING_TEMP_INIT = 174
    LBC_MAPPING_TEMP_BOUNDARY = 64
    LBC_MAPPING_THERMAL_CONVECTION = 65
    LBC_CONTACT_CLEARANCE = 60
    LBC_INITSTRESS_GENERAL = 66
    LBC_INITSTRESS_MAPPING = 67
    LBC_PRETENSION = 68
    LBC_PRETENSION_ABAQUS = 69
    LBC_SURFACE_LOADS = 70
    LBC_SUBMODEL_FORCED_DISP = 71
    LBC_SUBMODEL_FORCED_FLUX = 73
    LBC_INSIDE_HEAT_GENERATION = 74
    LBC_SUBMODEL_FORCED_TEMP = 72
    LBC_INIT_ANGULAR_VEL_ABAQUS = 76
    SUP_GROUP = 78
    LBC_WELD = 77
    ELEMEDGE_GROUP = 80
    FIELD_DATA = 81
    PROPERTY_0D_MASS = 82
    LBC_RIGIDWALL = 75
    PROPERTY_1D_BAR = 83
    PROPERTY_1D_BEAM = 84
    PROPERTY_1D_ROD = 85
    PROPERTY_1D_PLOT = 86
    PROPERTY_2D_SHELL = 87
    PROPERTY_2D_COMPOSITE_SHELL = 88
    GROUP = 79
    PROPERTY_3D_SOLID = 89
    PROPERTY_3D_GASKET = 90
    PROPERTY_3D_COHESIVE = 91
    SECTION_LIBRARY = 94
    PROPERTY_3D_WELDBEAD = 92
    SECTION_GENERAL = 93
    CONNECT_MPC = 96
    CONNECT_SPRING = 97
    CONNECT_RBE2 = 98
    SECTION_SKETCHER = 95
    CONNECT_CONM = 99
    CONNECT_PROD = 100
    CONNECT_RBAR = 101
    CONNECT_WELD = 105
    CONNECT_RBE3 = 102
    CONNECT_BUSH = 103
    CONNECT_DAMPER = 106
    CONNECT_MOMENT = 104
    CONNECT_CONNECTOR = 107
    CONTACT_ADVC = 108
    CONTACT_NXNASTRAN = 109
    CONTACT_ANSYS = 112
    CONTACT_MSCNASTRAN = 110
    CONTACT_ABAQUS = 111
    CUSTOM_ATTR_VECTOR = 115
    CONTACT = 113
    CUSTOM_ATTR_DOUBLE = 116
    DCS = 117
    CUSTOM_ATTR_STRING = 114
    ADVCPROCESS_STATIC = 119
    ADVCPROCESS_DYNAMIC = 120
    ADVCPROCESS_EIGEN = 121
    ADVCPROCESS_DYNAMIC_EXPLICIT = 123
    ADVCPROCESS_CREEP = 122
    ADVCPROCESS_FATIGUE = 124
    ADVCPROCESS = 118
    ADVCPROCESS_MODAL_FREQ_RESP = 125
    ADVCPROCESS_RAND_RESP = 127
    ADVCPROCESS_TH = 129
    ADVCPROCESS_SSH = 128
    ADVCPROCESS_RESP_SPEC = 126
    ABAQSTEPS_STRUCT = 132
    ABAQSTEPS_THERMAL = 133
    ABAQSTEPS = 131
    ADVCJOB = 130
    ABAQSTEPS_STRUCT_FREQUENCY = 135
    ABAQSTEPS_STRUCT_DYNAMIC = 137
    ABAQSTEPS_STRUCT_DYNAMIC_EXPLICIT = 139
    ABAQSTEPS_STRUCT_COUPLEDTD = 136
    ABAQSTEPS_STRUCT_DYNAMIC_COUPLEDTD = 138
    ABAQSTEPS_STRUCT_STATIC = 134
    ABAQSTEPS_STRUCT_STATICRISK = 140
    ABAQSTEPS_THERMAL_SS = 141
    ABAQSTEPS_THERMAL_TRANSIENT = 142
    ABAQUSJOB = 143
    CONNECT_GAP = 145
    ANSYSJOB = 146
    NASTRANJOB = 147
    LBC_MAPPING_HEATFLUX = 144
    WELDORDER = 149
    ATTRIBUTE_FXWELD = 150
    LSDYNAJOB = 152
    ACTRANJOB = 151
    ATTRIBUTE_PS_BLENDSURFACE = 154
    NCS = 153
    DYANAMISJOB = 148
    LBC_DOFSET = 155
    BEAM_PROP_ATTR = 156
    BEAM_PROP_ATTR2 = 157
    CONN_PROP_ATTR = 159
    SHELL_PROP_ATTR = 158
    LBC_PRETENSION_NXN = 160
    USER_PROP = 162
    LBC_MAPPING_TEMP_MARINE_ENGINE = 161
    CONNECTION_ELEMENT = 163
    LBC_MAPPING_FORCEDDISPLACEMENT = 165
    NASTRAN_POSTJOB = 167
    LBC_MAPPING_FORCED_TEMP = 166
    CONTACT_TSSS = 164
    ADVC2_POSTJOB = 168
    END = 182

class UnitType:
    values = "JPT.UnitType.values"
    Unit_Time = 1
    Unit_Force = 3
    Unit_Mass = 2
    Unit_Length = 0
    Unit_Angle = 4
    Unit_Temperature = 5
    Unit_Acceleration = 9
    Unit_Velocity = 8
    Unit_RotateAcc = 11
    Unit_Volume = 7
    Unit_RotateVelo = 10
    Unit_Density = 14
    Unit_Moment = 12
    Unit_Pressure = 13
    Unit_Stiffness = 15
    Unit_RotateStiff = 16
    Unit_Modulus = 19
    Unit_RotateDampingCoef = 18
    Unit_Area = 6
    Unit_DampingCoef = 17
    Unit_Energy = 20
    Unit_ThermalExCoef = 22
    Unit_ThermalConductivity = 23
    Unit_HeatFlux = 26
    Unit_SpecificHeat = 25
    Unit_HeatGeneration = 27
    Unit_AreaMomentInertia = 30
    Unit_SurfaceDensity = 29
    Unit_LinearDensity = 28
    Unit_TorsionalConst = 31
    Unit_WarpCoef = 32
    Unit_LinearMassMomentIntertia = 33
    Unit_ConvectionCoef = 24
    Unit_Power = 21
    Unit_Stress = 35
    Unit_MomentInertia = 34
    Unit_StrainEnergy = 37
    Unit_ThermalEnergy = 38
    Unit_Strain = 36
    Unit_VolumeEnergyDensity = 40
    Unit_ElectricalResistivity = 41
    Unit_Frequency = 39

class PathType:
    values = "JPT.PathType.values"
    PROGRAM_PATH = 0
    TEMP_PATH = 1
    APPDATA_PATH = 2
    DOC_PATH = 3

class BoolType:
    values = "JPT.BoolType.values"
    TRUE_VAL = 1
    FALSE_VAL = 0

class DTableType:
    values = "JPT.DTableType.values"
    DTABLE_SHAPE = 3
    DTABLE_NODE = 7
    DTABLE_UNKNOWN = 0
    DTABLE_LOCAL_SETTING = 15
    DTABLE_ELEM = 8
    DTABLE_MATERIAL = 16
    DTABLE_BODY = 5
    DTABLE_LBC_START = 20
    DTABLE_COORDINATE = 18
    DTABLE_LOADCASE = 19
    DTABLE_GROUP = 59
    DTABLE_LBC_END = 55
    DTABLE_FIELD_DATA = 56
    DTABLE_PROPERTY = 61
    DTABLE_ADVCPROCESS = 67
    DTABLE_ABAQSTEPS = 69
    DTABLE_CONNECTION = 63
    DTABLE_CONTACT = 64
    DTABLE_NASTRANJOB = 72
    DTABLE_ADVCJOB = 68
    DTABLE_ABAQUSJOB = 70
    DTABLE_DYNAMISJOB = 73
    DTABLE_ANSYSJOB = 71
    DTABLE_ACTRANJOB = 75
    DTABLE_LSDYNAJOB = 76
    DTABLE_BODY = 5
    DTABLE_SHAPE = 3
    DTABLE_ELEM = 8
    DTABLE_UNKNOWN = 0
    DTABLE_LOCAL_SETTING = 15
    DTABLE_COORDINATE = 18
    DTABLE_MATERIAL = 16
    DTABLE_LOADCASE = 19
    DTABLE_NODE = 7
    DTABLE_LBC_START = 20
    DTABLE_GROUP = 59
    DTABLE_PROPERTY = 61
    DTABLE_CONNECTION = 63
    DTABLE_LBC_END = 55
    DTABLE_ADVCPROCESS = 67
    DTABLE_ABAQSTEPS = 69
    DTABLE_ADVCJOB = 68
    DTABLE_ANSYSJOB = 71
    DTABLE_ABAQUSJOB = 70
    DTABLE_CONTACT = 64
    DTABLE_NASTRANJOB = 72
    DTABLE_DYNAMISJOB = 73
    DTABLE_ACTRANJOB = 75
    DTABLE_LSDYNAJOB = 76
    DTABLE_FIELD_DATA = 56

class DItemType:
    values = "JPT.DItemType.values"
    INST = 2
    BODY = 3
    VERTEX = 4
    UNKNOWN = 0
    PROJECT = 1
    EDGE = 5
    SOLID = 7
    BODYLINK = 9
    SHAPELINK = 8
    NODE = 10
    ELEM = 11
    REF_VERTEX = 13
    REF_EDGE = 14
    FACE = 6
    REF_SOLID = 16
    REF_SHAPELINK = 17
    REF_FACE = 15
    REF_BODYLINK = 18
    REF_NODE = 19
    LOCAL_SETTING = 21
    MATERIAL = 22
    REF_ELEM = 20
    ENTITY_ATTR_CAD_INFO = 23
    FEM_FIELD_SCALAR = 24
    FEM_FIELD_VECTOR = 25
    COORD = 27
    LOADCASE = 28
    FEM_FIELD_TENSOR = 26
    LBC_FORCE = 29
    LBC_FORCE_ND = 30
    LBC_FORCE_QUADRATIC = 31
    LBC_FORCE_SINE = 32
    LBC_NOLIN1 = 34
    LBC_NOLIN3 = 35
    LBC_ENFORCED_DISP = 38
    LBC_CONSTRAINT = 37
    LBC_FORCE_VECTOR = 33
    LBC_NOLIN4 = 36
    LBC_G_PRESSURE = 40
    LBC_H_PRESSURE = 41
    LBC_GRAVITY = 39
    LBC_PRESSURE_QUADRATIC = 43
    REF_BODY = 12
    LBC_T_PRESSURE = 42
    LBC_PRESSURE_SINE = 44
    LBC_TEMP_INI = 47
    LBC_CS_CENTRIFUGAL_FORCE = 46
    LBC_TEMP_LOAD_GENERAL = 49
    LBC_T_CENTRIFUGAL_FORCE = 45
    LBC_TEMP_LOAD_ADVC_FILE = 50
    LBC_TEMP_LOAD = 48
    LBC_TEMP_LOAD_NASTRAN = 51
    LBC_TEMP_LOAD_ADVC_RESULT_REFERENCE = 52
    LBC_TEMP_BOUNDARY = 53
    LBC_CONCENTRATE_FLUX = 54
    LBC_SURFACE_FLUX = 55
    LBC_THERMAL_CONVECTION = 56
    LBC_ENFORCED_ACCELERATION = 58
    LBC_DYNAMIC_INITIAL_CONDITION = 59
    LBC_ENFORCED_VELOCITY = 57
    LBC_MAPPING_PRESSURE = 61
    LBC_CONTACT_CLEARANCE = 60
    LBC_MAPPING_FORCE = 62
    LBC_MAPPING_TEMP_LOAD = 63
    LBC_MAPPING_TEMP_INIT = 174
    LBC_MAPPING_TEMP_BOUNDARY = 64
    LBC_MAPPING_THERMAL_CONVECTION = 65
    LBC_INITSTRESS_MAPPING = 67
    LBC_PRETENSION = 68
    LBC_INITSTRESS_GENERAL = 66
    LBC_SUBMODEL_FORCED_TEMP = 72
    LBC_PRETENSION_ABAQUS = 69
    LBC_SURFACE_LOADS = 70
    LBC_SUBMODEL_FORCED_DISP = 71
    LBC_INSIDE_HEAT_GENERATION = 74
    LBC_INIT_ANGULAR_VEL_ABAQUS = 76
    LBC_SUBMODEL_FORCED_FLUX = 73
    SUP_GROUP = 78
    GROUP = 79
    ELEMEDGE_GROUP = 80
    PROPERTY_0D_MASS = 82
    LBC_RIGIDWALL = 75
    PROPERTY_1D_BAR = 83
    LBC_WELD = 77
    FIELD_DATA = 81
    PROPERTY_1D_BEAM = 84
    PROPERTY_2D_SHELL = 87
    PROPERTY_2D_COMPOSITE_SHELL = 88
    PROPERTY_1D_PLOT = 86
    PROPERTY_3D_SOLID = 89
    PROPERTY_1D_ROD = 85
    PROPERTY_3D_COHESIVE = 91
    PROPERTY_3D_GASKET = 90
    PROPERTY_3D_WELDBEAD = 92
    SECTION_LIBRARY = 94
    SECTION_GENERAL = 93
    SECTION_SKETCHER = 95
    CONNECT_MPC = 96
    CONNECT_CONM = 99
    CONNECT_PROD = 100
    CONNECT_SPRING = 97
    CONNECT_RBE3 = 102
    CONNECT_RBE2 = 98
    CONNECT_RBAR = 101
    CONNECT_WELD = 105
    CONNECT_MOMENT = 104
    CONNECT_BUSH = 103
    CONNECT_DAMPER = 106
    CONTACT_NXNASTRAN = 109
    CONTACT_MSCNASTRAN = 110
    CONTACT_ADVC = 108
    CONNECT_CONNECTOR = 107
    CONTACT = 113
    CONTACT_ANSYS = 112
    CONTACT_ABAQUS = 111
    CUSTOM_ATTR_STRING = 114
    CUSTOM_ATTR_VECTOR = 115
    CUSTOM_ATTR_DOUBLE = 116
    ADVCPROCESS = 118
    DCS = 117
    ADVCPROCESS_DYNAMIC = 120
    ADVCPROCESS_EIGEN = 121
    ADVCPROCESS_STATIC = 119
    ADVCPROCESS_DYNAMIC_EXPLICIT = 123
    ADVCPROCESS_FATIGUE = 124
    ADVCPROCESS_MODAL_FREQ_RESP = 125
    ADVCPROCESS_RESP_SPEC = 126
    ADVCPROCESS_SSH = 128
    ADVCPROCESS_CREEP = 122
    ADVCPROCESS_RAND_RESP = 127
    ABAQSTEPS = 131
    ADVCJOB = 130
    ABAQSTEPS_STRUCT = 132
    ABAQSTEPS_STRUCT_FREQUENCY = 135
    ABAQSTEPS_THERMAL = 133
    ADVCPROCESS_TH = 129
    ABAQSTEPS_STRUCT_COUPLEDTD = 136
    ABAQSTEPS_STRUCT_DYNAMIC_EXPLICIT = 139
    ABAQSTEPS_STRUCT_DYNAMIC_COUPLEDTD = 138
    ABAQSTEPS_STRUCT_DYNAMIC = 137
    ABAQSTEPS_STRUCT_STATICRISK = 140
    ABAQSTEPS_STRUCT_STATIC = 134
    ABAQSTEPS_THERMAL_SS = 141
    ABAQSTEPS_THERMAL_TRANSIENT = 142
    CONNECT_GAP = 145
    ABAQUSJOB = 143
    NASTRANJOB = 147
    DYANAMISJOB = 148
    ANSYSJOB = 146
    WELDORDER = 149
    LSDYNAJOB = 152
    ACTRANJOB = 151
    LBC_MAPPING_HEATFLUX = 144
    NCS = 153
    ATTRIBUTE_FXWELD = 150
    ATTRIBUTE_PS_BLENDSURFACE = 154
    BEAM_PROP_ATTR = 156
    BEAM_PROP_ATTR2 = 157
    CONN_PROP_ATTR = 159
    SHELL_PROP_ATTR = 158
    LBC_MAPPING_TEMP_MARINE_ENGINE = 161
    LBC_PRETENSION_NXN = 160
    CONTACT_TSSS = 164
    LBC_MAPPING_FORCEDDISPLACEMENT = 165
    USER_PROP = 162
    CONNECTION_ELEMENT = 163
    LBC_MAPPING_FORCED_TEMP = 166
    NASTRAN_POSTJOB = 167
    LBC_DOFSET = 155
    ADVC2_POSTJOB = 168
    END = 208

class ElemType:
    values = "JPT.ElemType.values"
    ELEMTYPE_UNKNOWN = 0
    ELEMTYPE_POINT = 1
    ELEMTYPE_LINE2 = 2
    ELEMTYPE_LINE3 = 3
    ELEMTYPE_TRI3 = 4
    ELEMTYPE_TRI6 = 5
    ELEMTYPE_QUAD4 = 6
    ELEMTYPE_TET10 = 9
    ELEMTYPE_TET4 = 8
    ELEMTYPE_HEX8 = 10
    ELEMTYPE_HEX20 = 11
    ELEMTYPE_PRISM15 = 13
    ELEMTYPE_PYRAMID5 = 14
    ELEMTYPE_PYRAMID13 = 15
    ELEMTYPE_PRISM6 = 12
    ELEMTYPE_QUAD6 = 17
    ELEMTYPE_QUAD9 = 18
    ELEMTYPE_RBE = 21
    ELEMTYPE_QUAD8 = 7
    ELEMTYPE_PLOT = 16
    ELEMTYPE_MASS = 22
    ELEMTYPE_PRISM12 = 19
    ELEMTYPE_HEX18 = 20
    ELEMTYPE_VIRTUAL = 23

class ElemKind:
    values = "JPT.ElemKind.values"
    ELEMKIND_UNKNOWN = 0
    ELEMKIND_0D = 1
    ELEMKIND_1D = 2
    ELEMKIND_2D = 3
    ELEMKIND_3D = 4
    ELEMKIND_SP = 5

class AssociateType:
    values = "JPT.AssociateType.values"
    AS_BODY = 1
    AS_BARBODY = 0
    AS_FACE = 2
    AS_ELEM1D = 5
    AS_EDGE = 3
    AS_SOLIDELEM = 6
    AS_CONNECTION = 8
    AS_NODE = 7
    AS_GROUP = 11
    AS_ELEM = 4
    AS_CONTTACT = 10
    AS_MASS = 9

class MsgBoxType:
    values = "JPT.MsgBoxType.values"
    MB_WARNING_YESNOCANCEL = 0
    MB_WARNING_YESNO = 1
    MB_WARNING_OK = 2
    MB_WARNING_OKCANCEL = 3
    MB_INFORMATION_YESNOCANCEL = 4
    MB_INFORMATION_YESNO = 5
    MB_INFORMATION_OK = 6
    MB_INFORMATION_OKCANCEL = 7

class JPT:
    EntityType = EntityType()
    UnitType = UnitType()
    PathType = PathType()
    BoolType = BoolType()
    DTableType = DTableType()
    DItemType = DItemType()
    ElemType = ElemType()
    ElemKind = ElemKind()
    AssociateType = AssociateType()
    MsgBoxType = MsgBoxType()

    def DItem():
        return "JPT.DItem()"

    def DFace():
        return "JPT.DFace()"

    def DBody():
        return "JPT.DBody()"

    def DEdge():
        return "JPT.DEdge()"

    def DElem():
        return "JPT.DElem()"

    def DGroup():
        return "JPT.DGroup()"

    def DNode():
        return "JPT.DNode()"

    def VersionInfo():
        return "JPT.VersionInfo()"

    def TVector3d():
        return "JPT.TVector3d()"

    def DItemVector():
        return "JPT.DItemVector()"

    def BodyVector():
        return "JPT.BodyVector()"

    def FaceVector():
        return "JPT.FaceVector()"

    def ElemVector():
        return "JPT.ElemVector()"

    def GroupVector():
        return "JPT.GroupVector()"

    def NodeVector():
        return "JPT.NodeVector()"

    def EdgeVector():
        return "JPT.EdgeVector()"

    def DItemPairVector():
        return "JPT.DItemPairVector()"

    def RemoveEntitiesByID(Input1,Input2):
        r"""
        ## Description
        
        Remove entities from model by id
        
        ## Inputs
        
        1. DItem enum type (JPT.DItemType)
        
        2. id of entity (int)
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        listbody = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube", JPT.BoolType.FALSE_VAL)
        idbody = listbody[0].id
        JPT.RemoveEntitiesByID(JPT.DItemType.BODY, idbody)
        ```
        
        """
        message = "JPT.RemoveEntitiesByID({},{})".format(Input1,Input2)
        return JPT_RUN_LINE(message)

    def RemoveEntitiesByName(Input1,Input2_str,Input3):
        r"""
        ## Description
        
        Remove entities from model by name
        
        ## Inputs
        
        1. DTable enum type (JPT.DTableType)
        
        2. name of entity (string)
        
        3. match with name option (1,0 or JPT.BoolType)
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        JPT.RemoveEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube_1", 1)
        ```
        
        """
        message = "JPT.RemoveEntitiesByName({},'{}',{})".format(Input1,Input2_str,Input3)
        return JPT_RUN_LINE(message)

    def RemoveAllLoadsBCs():
        r"""
        ## Description
        
        Remove all Loads and Boundary Condition in model
        
        ## Syntax
        
        RemoveAllLoadsBCs()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllLoadsBCs()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllLoadsBCs()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllContacts():
        r"""
        ## Description
        
        Remove all of Contact in models
        
        ## Syntax
        
        RemoveAllContacts()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllContacts()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllContacts()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllConnections():
        r"""
        ## Description
        
        Remove all of Connection in models
        
        ## Syntax
        
        RemoveAllConnections()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllConnections()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllConnections()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllLoadCases():
        r"""
        ## Description
        
        Remove all load cases in models
        
        ## Syntax
        
        RemoveAllLoadCases()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllLoadCases()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllLoadCases()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllMaterials():
        r"""
        ## Description
        
        Remove all of Material in User Data Base
        
        ## Syntax
        
        RemoveAllMaterials()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllMaterials()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllMaterials()".format()
        return JPT_RUN_LINE(message)

    def RemoveWSProperties():
        r"""
        ## Description
        
        Remove all properties in models
        
        ## Syntax
        
        RemoveWSProperties()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveWSProperties()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveWSProperties()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllCoordinates():
        r"""
        ## Description
        
        Remove all of created coordinates
        
        ## Syntax
        
        RemoveAllCoordinates()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllCoordinates()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllCoordinates()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllMeshSettings():
        r"""
        ## Description
        
        Remove all local mesh setting
        
        ## Syntax
        
        RemoveAllMeshSettings()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllMeshSettings()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllMeshSettings()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllFieldTables():
        r"""
        ## Description
        
        Remove all of Field Data table
        
        ## Syntax
        
        RemoveAllFieldTables()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllFieldTables()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllFieldTables()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllAbaqusStep():
        r"""
        ## Description
        
        Remove all of Abaqus steps in Analysis
        
        ## Syntax
        
        RemoveAllAbaqusStep()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllAbaqusStep()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllAbaqusStep()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllSolverjob():
        r"""
        ## Description
        
        Remove all analysis Jobs
        
        ## Syntax
        
        RemoveAllSolverjob()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.RemoveAllSolverjob()
        ```
        
        _Output:_
        
        """
        message = "JPT.RemoveAllSolverjob()".format()
        return JPT_RUN_LINE(message)

    def RemoveAllByTableType(Input1):
        r"""
        ## Description
        
        Remove all entities in models by table type
        
        ## Inputs
        
        1. DTable enum type (JPT.DTableType)
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        JPT.RemoveAllByTableType(JPT.DTableType.DTABLE_BODY)
        ```
        
        """
        message = "JPT.RemoveAllByTableType({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CreateSubAssembly(Input1_str,Input2):
        r"""
        ## Description
        
        Create a new sub assembly under the indicated parent sub assembly.
        
        ## Syntax
        
        CreateSubAssembly(string name, DItemW parent)
        
        ## Inputs
        
        1. string
        
        create sub assembly name
        
        2. DItemW
        
        parent assembly tree item
        
        ## Return Code
        
        _Python Output_
        
        - DItemW
        
        Create Tree Item
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.CreateSubAssembly('CreateSubAsm',JPT.DItem())
        SubAsm=JPT.GetSubAssemblyById(1)
        JPT.CreateSubAssembly('AddSubAsm',SubAsm)
        ```
        
        _Output:_
        
        ![](./../_images/CreateSubAsm.png)
        
        """
        message = "JPT.CreateSubAssembly('{}',{})".format(Input1_str,Input2)
        return JPT_RUN_LINE(message)

    def DeleteSubAssembly(Input1):
        r"""
        ## Description
        
        Delete an indicated sub assembly.
        
        ## Syntax
        
        DeleteSubAssembly(DItem subAssembly)
        
        ## Inputs
        
        1. DItem
        
        Target sub assembly.
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        SubAsm=JPT.FindSubAssemblyByID(1)
        JPT.DeleteSubAssembly(SubAsm)
        ```
        
        _Output:_
        
        """
        message = "JPT.DeleteSubAssembly({})".format(Input1)
        return JPT_RUN_LINE(message)

    def FindSubAssemblyByName(Input1_str):
        r"""
        ## Description
        
        Find SubAssembly by Name
        
        ## Syntax
        
        FindSubAssemblyByName(string SubAssemblyName)
        
        ## Inputs
        
        1. String
        
        Name of search target sub assembly
        
        ## Return Code
        
        _Python Output_
        
        - DItemVector
        
        Found sub assemblies.
        
        ## Sample Code
        
        _Input:_
        
        ```python
        SubAsm=JPT.FindSubAssemblyByName('MySubAsms')
        for i in SubAsm
            print(i.name)
        ```
        
        _Output:_
        
        \> `MySubAsms`
        
        """
        message = "JPT.FindSubAssemblyByName('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def FindSubAssemblyByID(Input1):
        r"""
        ## Description
        
        Find SubAssembly by ID
        
        ## Syntax
        
        FindSubAssemblyByID(int SubAssemblyID)
        
        ## Inputs
        
        1. int
        
        Id of search target sub assembly
        
        ## Return Code
        
        _Python Output_
        
        - DItem
        
        Found sub assembly information.
        
        ## Sample Code
        
        _Input:_
        
        ```python
        SubAsm=JPT.FindSubAssemblyByID(1)
        print(SubAsm.name)
        ```
        
        _Output:_
        
        \> `SubAsmName`
        
        """
        message = "JPT.FindSubAssemblyByID({})".format(Input1)
        return JPT_RUN_LINE(message)

    def DeleteSubAssemblyRecursively(Input1):
        r"""
        ## Description
        
        Delete an indicated sub assembly and all the items inside the sub assembly safely.
        
        ## Syntax
        
        JPT.DeleteSubAssemblyRecursively(DItem subAssembly)
        
        ## Inputs
        
        1. DItem
        
        Target sub assembly.
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        SubAsm=JPT.FindSubAssemblyByID(1)
        JPT.JPT.DeleteSubAssemblyRecursively(SubAsm)
        ```
        
        _Output:_
        
        """
        message = "JPT.DeleteSubAssemblyRecursively({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetAllPartsInSubAssembly(Input1):
        r"""
        undefined
        """
        message = "JPT.GetAllPartsInSubAssembly({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastToDItem(Input1):
        r"""
        ## Description
        
        Cast an entity object to [DItem](./../data-type/item-class/Class_DItem.md) object
        
        ## Inputs
        
        1. any kind of objects (DBody, DFace, DElem, DEdge, DGroup, DNode, etc.)
        
        ## Return Code
        
        DItem object (DItem class)
        
        ## Sample Code
        
        ```python
        listDbodyObject = JPT.GetAllParts()
        dbodyObject = listDbodyObject[0]
        ditemObject = JPT.CastToDItem(dbodyObject)
        ```
        
        """
        message = "JPT.CastToDItem({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDBody(Input1):
        r"""
        ## Description
        
        Cast a [DItem](./../data-type/item-class/Class_DItem.md) object to [DBody](./../data-type/item-class/Class_DBody.md) object
        
        ## Inputs
        
        1. DItem object (DItem class)
        
        ## Return Code
        
        DBody object (DBody class)
        
        ## Sample Code
        
        ```python
        listDItemObject = JPT.GetAllByType(JPT.DItemType.BODY)
        ditemObject = listDItemObject[0]
        dbodyObject = JPT.CastDItemToDBody(ditemObject)
        print(s)
        ```
        
        """
        message = "JPT.CastDItemToDBody({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDFace(Input1):
        r"""
        ## Description
        
        Cast a [DItem](./../data-type/item-class/Class_DItem.md) object to [DFace](./../data-type/item-class/Class_DFace.md) object
        
        ## Inputs
        
        1. DItem object (DItem class)
        
        ## Return Code
        
        DFace object (DFace class)
        
        ## Sample Code
        
        ```python
        listDItemObject = JPT.GetAllByType(JPT.DItemType.FACE)
        ditemObject = listDItemObject[0]
        JPT.CastDItemToDFace(ditemObject)
        ```
        
        """
        message = "JPT.CastDItemToDFace({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDElem(Input1):
        r"""
        ## Description
        
        Cast a [DItem](./../data-type/item-class/Class_DItem.md) object to [DElem](./../data-type/item-class/Class_DElem.md) object
        
        ## Inputs
        
        1. DItem object (DItem class)
        
        ## Return Code
        
        DElem object (DElem class)
        
        ## Sample Code
        
        ```python
        listDItemObject = JPT.GetAllByType(JPT.DItemType.ELEM)
        ditemObject = listDItemObject[0]
        JPT.CastDItemToDElem(ditemObject)
        ```
        
        """
        message = "JPT.CastDItemToDElem({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDEdge(Input1):
        r"""
        ## Description
        
        Cast a [DItem](./../data-type/item-class/Class_DItem.md) object to DEdge object
        
        ## Inputs
        
        1. DItem object (DItem class)
        
        ## Return Code
        
        DEdge object (DEdge class)
        
        ## Sample Code
        
        ```python
        listDItemObject = JPT.GetAllByType(JPT.DItemType.EDGE)
        ditemObject = listDItemObject[0]
        JPT.CastDItemToDEdge(ditemObject)
        ```
        
        """
        message = "JPT.CastDItemToDEdge({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDGroup(Input1):
        r"""
        ## Description
        
        Cast a [DItem](./../data-type/item-class/Class_DItem.md) object to [DGroup](./../data-type/item-class/Class_DGroup.md) object
        
        ## Inputs
        
        1. DItem object (DItem class)
        
        ## Return Code
        
        DGroup object (DGroup class)
        
        ## Sample Code
        
        ```python
        listDItemObject = JPT.GetAllByType(JPT.DItemType.GROUP)
        ditemObject = listDItemObject[0]
        JPT.CastDItemToDGroup(ditemObject)
        ```
        
        """
        message = "JPT.CastDItemToDGroup({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDNode(Input1):
        r"""
        ## Description
        
        Cast a [DItem](./../data-type/item-class/Class_DItem.md) object to [DNode](./../data-type/item-class/Class_DNode.md) object
        
        ## Inputs
        
        1. DItem object (DItem class)
        
        ## Return Code
        
        DNode object (DNode class)
        
        ## Sample Code
        
        ```python
        listDItemObject = JPT.GetAllByType(JPT.DItemType.NODE)
        ditemObject = listDItemObject[0]
        JPT.CastDItemToDNode(ditemObject)
        ```
        
        """
        message = "JPT.CastDItemToDNode({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDCoord(Input1):
        r"""
        undefined
        """
        message = "JPT.CastDItemToDCoord({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDConnect(Input1):
        r"""
        undefined
        """
        message = "JPT.CastDItemToDConnect({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CastDItemToDLoadBC(Input1):
        r"""
        undefined
        """
        message = "JPT.CastDItemToDLoadBC({})".format(Input1)
        return JPT_RUN_LINE(message)

    def DItemToMacroTCursorPair(Input1,Input2):
        r"""
        ## Description
        
        Convert pair of DItem object to cursor pair macro string
        
        ## Inputs
        
        1. DItem object 1 (DItem class)
        
        2. DItem object 2 (DItem class)
        
        ## Return Code
        
        Cursor pair macro string (string)
        
        ## Sample Code
        
        ```python
        listDNodeObject = JPT.GetAllNodes()
        ditemObject1 = JPT.CastToDItem(listDNodeObject[0])
        ditemObject2 = JPT.CastToDItem(listDNodeObject[1])
        strElemEdge = JPT.DItemToMacroTCursorPair(ditemObject1, ditemObject2) # 10:1-10:2
        ```
        
        """
        message = "JPT.DItemToMacroTCursorPair({},{})".format(Input1,Input2)
        return JPT_RUN_LINE(message)

    def ListDoubleToMacroVector(Input1,Input2,Input3):
        r"""
        ## Description
        
        Convert list of double value to vector3d macro string
        
        ## Inputs
        
        1. Input1: value1 (double)
        
        2. Input2: value2 (double)
        
        3. Input2: value3 (double)
        
        ## Return Code
        
        vector3d macro string (string)
        
        ## Sample Code
        
        ```python
        JPT.ListDoubleToMacroVector(1.0, 1.0, 1.0) # [1.0,1.0,1.0]
        JPT.ListDoubleToMacroVector(1, 2, 3) # [1,2,3]
        ```
        
        """
        message = "JPT.ListDoubleToMacroVector({},{},{})".format(Input1,Input2,Input3)
        return JPT_RUN_LINE(message)

    def DTVector3dToMacroVector(Input1):
        r"""
        ## Description
        
        Convert Vector3d object to vector3d macro string
        
        ## Inputs
        
        1. Vector3d object (DTVector3d class)
        
        ## Return Code
        
        vector3d macro string (string)
        
        ## Sample Code
        
        ```python
        listDNodeObject = JPT.GetAllNodes()
        posNode1 = listDNodeObject[0].pos
        JPT.DTVector3dToMacroVector(posNode1)
        ```
        
        """
        message = "JPT.DTVector3dToMacroVector({})".format(Input1)
        return JPT_RUN_LINE(message)

    def DItemToMacroTCursor(Input1):
        r"""
        ## Description
        
        Convert a DItem object to cursor macro string
        
        ## Inputs
        
        1. DItem object (DItem class)
        
        ## Return Code
        
        cursor macro string (string)
        
        ## Sample Code
        
        ```python
        listnode1 = JPT.GetEntitiesByID(JPT.DItemType.NODE, 435)
        listnode2 = JPT.GetEntitiesByID(JPT.DItemType.NODE, 434)
        node1 = JPT.DItemToMacroTCursor(listnode1[0]) # 10:1
        node2 = JPT.DItemToMacroTCursor(listnode2[0]) # 10:2
        JPT.Exec('Collapse({0}, {1})'.format(node1, node2))
        ```
        
        """
        message = "JPT.DItemToMacroTCursor({})".format(Input1)
        return JPT_RUN_LINE(message)

    def DItemListToMacroListTCursor(Input1):
        r"""
        ## Description
        
        Convert list of DItem objects to cursor list macro string
        
        ## Inputs
        
        1. list of DItem objects (ItemVector)
        
        ## Return Code
        
        cursor list macro string (string)
        
        ## Sample Code
        
        ```python
        listface1 = JPT.GetAllFaces()
        JPT.DItemListToMacroListTCursor(listface1) # [10:1, 10:1, ...]
        ```
        
        """
        message = "JPT.DItemListToMacroListTCursor({})".format(Input1)
        return JPT_RUN_LINE(message)

    def DItemToMacroListTCursor(Input1):
        r"""
        ## Description
        
        Convert a DItem object to cursor list macro string
        
        ## Inputs
        
        1. DItem objects (DItem class)
        
        ## Return Code
        
        cursor list macro string (string)
        
        ## Sample Code
        
        ```python
        listnode = JPT.GetEntitiesByID(JPT.DItemType.NODE, 434)
        node = JPT.DItemToMacroTCursor(listnode[0]) # 10:1
        JPT.DItemToMacroListTCursor(node) # [10:1]
        ```
        
        """
        message = "JPT.DItemToMacroListTCursor({})".format(Input1)
        return JPT_RUN_LINE(message)

    def MacroResultParser(Input1_str,Input2_str):
        r"""
        undefined
        """
        message = "JPT.MacroResultParser('{}','{}')".format(Input1_str,Input2_str)
        return JPT_RUN_LINE(message)

    def MacroListTCursorToListDItem(Input1_str):
        r"""
        ## Description
        
        Convert a macro cursor list string to list of DItem objects
        
        ## Inputs
        
        1. macro cursor list string (string)
        
        ## Return Code
        
        list of DItem objects (ItemVector)
        
        ## Sample Code
        
        ```python
        listDItemObject = JPT.MacroListTCursorToListDItem('\[10:1, 10:1, ...\]')
        ```
        
        """
        message = "JPT.MacroListTCursorToListDItem('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def MacroTCursorToDItem(Input1_str):
        r"""
        ## Description
        
        Convert a macro cursor string to DItem object
        
        ## Inputs
        
        1. macro cursor string (string)
        
        ## Return Code
        
        DItem object (DItem class)
        
        ## Sample Code
        
        ```python
        ditemObject = JPT.MacroTCursorToDItem('3:1')
        ```
        
        """
        message = "JPT.MacroTCursorToDItem('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def ConvertRGBToJPTColor(Input1):
        r"""
        ## Description
        
        Convert a RGB (red,green,blue) value to JPT color number
        
        ## Inputs
        
        1.  RGB (red,green,blue)
        
        ## Return Code
        
        JPT color number (int)
        
        ## Sample Code
        
        ```python
        newcolor = JPT.ConvertRGBToJPTColor(RGB(255,0,0)) # red color
        listbody = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube_1", 1)
        listbody[0].color = newcolor
        ```
        
        """
        message = "JPT.ConvertRGBToJPTColor({})".format(Input1)
        return JPT_RUN_LINE(message)

    def CopyToClipBoard(Input1_str):
        r"""
        undefined
        """
        message = "JPT.CopyToClipBoard('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def CheckLicense(Input1_str):
        r"""
        ## Description
        
        Check feature license whether active or not
        
        ## Syntax
        
        `CheckLicense(string strJPTLic)`
        
        ## Inputs
        
        1. String
        
        Jupiter feature license: Home \> Preference \> License
        
        ## Return Code
        
        _Python Output_
        
        - Boolean
        
        True
        
        - Boolean
        
        False
        
        ## Sample Code
        
        _Input:_
        
        ```python
        lic = JPT.CheckLicense("JPT_BASE")
        print(str(lic))
        ```
        
        _Output:_
        
        \> `True`
        
        """
        message = "JPT.CheckLicense('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def IsDefaultDouble(Input1):
        r"""
        undefined
        """
        message = "JPT.IsDefaultDouble({})".format(Input1)
        return JPT_RUN_LINE(message)

    def IsDefaultInt(Input1):
        r"""
        undefined
        """
        message = "JPT.IsDefaultInt({})".format(Input1)
        return JPT_RUN_LINE(message)

    def ConvertFromDocUnit(Input1,Input2):
        r"""
        ## Description
        
        Converts units in the document to SI\[m\] units (Jupiter macro units). The return value will be the value after conversion.
        
        ## Syntax
        
        `ConvertFromDocUnit(float inputValue, enum UnitType)`
        
        ## Inputs
        
        1. Float
        
        Conversion source value
        
        2. Enum
        
        Unit system conversion type
        
        ## Return Code
        
        _Python Output_
        
        - float
        
        Converted Value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        convFromDoc = JPT.ConvertFromDocUnit(1, JPT.UnitType.Unit_Length)
        print(str(convFromDoc))
        ```
        
        _Output:_
        
        \> `0.001`
        
        """
        message = "JPT.ConvertFromDocUnit({},{})".format(Input1,Input2)
        return JPT_RUN_LINE(message)

    def ConvertValueToDocUnit(Input1,Input2):
        r"""
        ## Description
        
        Convert value from SI unit system to JPT user setup unit
        
        ## Syntax
        
        ConvertValueToDocUnit(float inputValue, enum UnitTypeunit)
        
        ## Inputs
        
        1. Float
        
        Conversion source value
        
        2. Enum
        
        Unit system conversion type
        
        ## Return Code
        
        _Python Output_
        
        - float
        
        Converted value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        convToDoc = JPT.ConvertValueToDocUnit(1, JPT.UnitType.Unit_Length)
        print(str(convToDoc))
        ```
        
        _Output:_
        
        \> `1000.0`
        
        """
        message = "JPT.ConvertValueToDocUnit({},{})".format(Input1,Input2)
        return JPT_RUN_LINE(message)

    def ConvertFromMacroUnit(Input1,Input2,Input3_str):
        r"""
        ## Description
        
        Convert unit system from user input unit to macro SI unit
        
        ## Syntax
        
        ConvertFromMacroUnit(float inputValue, enum UnitType, string strUnit)
        
        ## Inputs
        
        1. Float
        
        Conversion source value
        
        2. Enum
        
        Unit system conversion type
        
        3. String
        
        Unit abbreviation
        
        ## Return Code
        
        _Python Output_
        
        - float
        
        Converted value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        convFromMacr = JPT.ConvertFromMacroUnit(1, JPT.UnitType.Unit_Length, 'mm')
        print(str(convFromMacr))
        ```
        
        _Output:_
        
        \> `0.001`
        
        """
        message = "JPT.ConvertFromMacroUnit({},{},'{}')".format(Input1,Input2,Input3_str)
        return JPT_RUN_LINE(message)

    def ConvertValueToMacroUnit(Input1,Input2,Input3_str):
        r"""
        ## Description
        
        Convert unit system from macro SI unit to user input unit
        
        ## Syntax
        
        ConvertValueToMacroUnit(float inputValue, enum UnitType, string strUnit)
        
        ## Inputs
        
        1. Float
        
        Conversion source value
        
        2. Enum
        
        Unit system conversion type
        
        3. String
        
        Unit abbreviation
        
        ## Return Code
        
        _Python Output_
        
        - float
        
        Converted value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        convToMacr = JPT.ConvertValueToMacroUnit(1, JPT.UnitType.Unit_Length, 'mm')
        print(str(convToMacr))
        ```
        
        _Output:_
        
        \> `1000.0`
        
        """
        message = "JPT.ConvertValueToMacroUnit({},{},'{}')".format(Input1,Input2,Input3_str)
        return JPT_RUN_LINE(message)

    def GetJPTTempPath():
        r"""
        ## Description
        
        Get temporary document path
        
        ## Syntax
        
        GetJPTTempPath()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - String
        
        Temp Document Path
        
        ## Sample Code
        
        _Input:_
        
        ```python
        path=JPT.GetJPTTempPath()
        print(str(path))
        ```
        
        _Output:_
        
        \> `C:\Users\TECHNOSTAR\AppData\Local\Temp\TechnoStar\`
        
        """
        message = "JPT.GetJPTTempPath()".format()
        return JPT_RUN_LINE(message)

    def GetProgramPath():
        r"""
        ## Description
        
        Get application installation directory
        
        ## Syntax
        
        GetProgramPath()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - String
        
        Program Path
        
        ## Sample Code
        
        _Input:_
        
        ```python
        path=JPT.GetProgramPath()
        print(str(path))
        ```
        
        _Output:_
        
        \> `C:\Program Files\TechnoStar\Jupiter-Pre_4.1\`
        
        """
        message = "JPT.GetProgramPath()".format()
        return JPT_RUN_LINE(message)

    def GetCurrentDocumentPath():
        r"""
        ## Description
        
        Get current document path
        
        ## Syntax
        
        GetCurrentDocumentPath()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - String
        
        Current Document Path
        
        ## Sample Code
        
        _Input:_
        
        ```python
        path=JPT.GetCurrentDocumentPath()
        print(str(path))
        ```
        
        _Output:_
        
        \> `C:\Users\TechnoStar\Desktop\Model\test_python_1.jtdb`
        
        """
        message = "JPT.GetCurrentDocumentPath()".format()
        return JPT_RUN_LINE(message)

    def QuitApplication():
        r"""
        undefined
        """
        message = "JPT.QuitApplication()".format()
        return JPT_RUN_LINE(message)

    def GetAppPathInfo(Input1):
        r"""
        ## Description
        
        Get a JPT path string (Program, Temp, Appdata, Document)
        
        ## Inputs
        
        1. PathType enum type (JPT.PathType)
        
        ## Return Code
        
        path (string)
        
        ## Sample Code
        
        ```python
        JPT.GetAppPathInfo()
        ```
        
        """
        message = "JPT.GetAppPathInfo({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetSelectedNodes():
        r"""
        ## Description
        
        Get selected node information
        
        ## Syntax
        
        GetSelectedNodes()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - NodeVector
        
        Selected node information (typeID, id, key, pos)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        nodes= JPT.GetSelectedNodes()
        for n in nodes:
            print('type="{0}", id="{1}", key="{2}"'.format(n.typeID, n.id, n.key))
        ```
        
        _Output:_
        
        \> `type="10", id="93", key="93"`
        
        \> `type="10", id="486", key="486"`
        
        \> `type="10", id="480", key="480"`
        
        """
        message = "JPT.GetSelectedNodes()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedElems():
        r"""
        ## Description
        
        Get selected element information
        
        ## Syntax
        
        GetSelectedElems()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - ElemVector
        
        Selected element information (typeID, type, id, key, kind)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        elems = JPT.GetSelectedElems()
        for e in elems:
            print(str(e.typeID)+' '+str(e.type)+' '+str(e.id)+' '+str(e.key)+' '+str(e.kind))
        ```
        
        _Output:_
        
        \> `11 ELEMTYPE_TRI3 1161 1161 ELEMKIND_2D`
        
        \> `11 ELEMTYPE_TRI3 1171 1171 ELEMKIND_2D`
        
        \> `11 ELEMTYPE_TRI3 1173 1173 ELEMKIND_2D`
        
        """
        message = "JPT.GetSelectedElems()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedFaces():
        r"""
        ## Description
        
        Get selected face information
        
        ## Syntax
        
        GetSelectedFaces()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - FaceVector
        
        Selected face information (typeID, id, key)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        faces = JPT.GetSelectedFaces()
        for f in faces:
            print(str(f.id)+' '+str(f.key)+' '+str(f.typeID))
        ```
        
        _Output:_
        
        \> `22 22 6`
        
        \> `26 26 6`
        
        \> `31 31 6`
        
        """
        message = "JPT.GetSelectedFaces()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedEdges():
        r"""
        ## Description
        
        Get all of selected edge information
        
        ## Syntax
        
        GetSelectedEdges()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - EdgeVector
        
        Selected edge information (typeID, id, key)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        edges = JPT.GetSelectedEdges()
        for e in edges:
            print(str(e.typeID)+' '+str(e.id)+' '+str(e.key))
        ```
        
        _Output:_
        
        \> `5 19 19`
        
        \> `5 27 27`
        
        \> `5 18 18`
        
        """
        message = "JPT.GetSelectedEdges()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedParts():
        r"""
        ## Description
        
        Get selected part information
        
        ## Syntax
        
        GetSelectedParts()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - BodyVector
        
        Selected part information (typeID, id, key, name)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        part = JPT.GetSelectedParts()
        for p in part:
            print('type="{0}", id="{1}", key="{2}", name="{3}"'.format(p.typeID, p.id, p.key, p.name))
        ```
        
        _Output:_
        
        \> `type="3", id="1", key="1", name="Cube_1"`
        
        \> `type="3", id="2", key="2", name="Cube_2"`
        
        """
        message = "JPT.GetSelectedParts()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedGroups():
        r"""
        ## Description
        
        Get selected group information (Entity information inside group)
        
        ## Syntax
        
        GetSelectedGroups()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - GroupVector
        
        Selected group information ( id, key, name, targets, typeID)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        groups=JPT.GetSelectedGroups()
        for g in groups:
            for e in g.targets:
                print(str(e.typeID)+' '+str(e.id)+' '+str(e.key)+' '+str(e.name))
        ```
        
        _Output:_
        
        \> `3 2 2 Cylinder_1`
        
        \> `3 1 1 Cube_1`
        
        """
        message = "JPT.GetSelectedGroups()".format()
        return JPT_RUN_LINE(message)

    def GetAllParts():
        r"""
        ## Description
        
        Get information of all parts
        
        ## Syntax
        
        GetAllParts()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - BodyVector
        
        Part information (typeID, id, key, name)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        part = JPT.GetAllParts()
        for p in part:
            print('type="{0}", id="{1}", key="{2}", name="{3}"'.format(p.typeID, p.id, p.key, p.name))
        ```
        
        _Output:_
        
        \> `type="3", id="1", key="1", name="Cube_1"`
        
        \> `type="3", id="2", key="2", name="Cylinder_1"`
        
        """
        message = "JPT.GetAllParts()".format()
        return JPT_RUN_LINE(message)

    def GetAllFaces():
        r"""
        ## Description
        
        Get information of faces
        
        ## Syntax
        
        GetAllFaces()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - FaceVector
        
        Face information (id, key, typeID)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        faces = JPT.GetAllFaces()
        for f in faces:
            print(str(f.id)+' '+str(f.key)+' '+str(f.typeID))
        ```
        
        _Output:_
        
        \> `21 21 6`
        
        \> `22 22 6`
        
        \> `23 23 6`
        
        \> `24 24 6`
        
        \> `25 25 6`
        
        \> `...`
        
        """
        message = "JPT.GetAllFaces()".format()
        return JPT_RUN_LINE(message)

    def GetAllEdges():
        r"""
        ## Description
        
        Get information of edges
        
        ## Syntax
        
        GetAllEdges()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - EdgeVector
        
        Edge information (id, key, typeID)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        edges= JPT.GetAllEdges()
        for ed in edges:
            print(str(ed.typeID)+' '+str(ed.id)+' '+str(ed.key))
        ```
        
        _Output:_
        
        \> `5 35 35`
        
        \> `5 18 18`
        
        \> `5 36 36`
        
        \> `...`
        
        """
        message = "JPT.GetAllEdges()".format()
        return JPT_RUN_LINE(message)

    def GetAllElems():
        r"""
        ## Description
        
        Get information of elements
        
        ## Syntax
        
        GetAllElems()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - ElemVector
        
        Element information (id, key, type, typeID)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        elem= JPT.GetAllElems()
        for e in elem:
            print(str(e.typeID)+' '+str(e.type)+' '+str(e.id)+' '+str(e.key))
        ```
        
        _Output:_
        
        \> `11 ELEMTYPE_TRI3 772 772`
        
        \> `11 ELEMTYPE_TRI3 1878 1878`
        
        \> `11 ELEMTYPE_TRI3 251 251`
        
        \> `...`
        
        """
        message = "JPT.GetAllElems()".format()
        return JPT_RUN_LINE(message)

    def GetAllNodes():
        r"""
        ## Description
        
        Get information of all nodes
        
        ## Syntax
        
        GetAllNodes()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - NodeVector
        
        Node information (typeID, id, key, pos)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        nodes= JPT.GetAllNodes()
        for n in nodes:
            print('type="{0}", id="{1}", key="{2}"'.format(n.typeID, n.id, n.key))
        ```
        
        _Output:_
        
        \> `type="10", id="772", key="772"`
        
        \> `type="10", id="251", key="251"`
        
        \> `type="10", id="609", key="609"`
        
        \> `...`
        
        """
        message = "JPT.GetAllNodes()".format()
        return JPT_RUN_LINE(message)

    def GetAllGroups():
        r"""
        ## Description
        
        Get all entities' information inside groups
        
        ## Syntax
        
        GetAllGroups()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - GroupVector
        
        Group information (id, key, name, targets, typeID)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        groups=JPT.GetAllGroups()
        for g in groups:
            for e in g.targets:
                    print(str(e.typeID)+' '+str(e.id)+' '+str(e.key)+' '+str(e.name))
        ```
        
        _Output:_
        
        \> `6 26 26`
        
        \> `6 22 22`
        
        \> `6 24 24`
        
        \> `3 2 2 Cylinder_1`
        
        \> `3 1 1 Cube_1`
        
        """
        message = "JPT.GetAllGroups()".format()
        return JPT_RUN_LINE(message)

    def GetAllByTableTypeID(Input1):
        r"""
        undefined
        """
        message = "JPT.GetAllByTableTypeID({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetAllByType(Input1):
        r"""
        undefined
        """
        message = "JPT.GetAllByType({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetCountByType(Input1):
        r"""
        ## Description
        
        Get count of entities by type
        
        ## Syntax
        
        GetCountByType(JPT.DItemType.TYPE)
        
        ## Inputs
        
        1. enum
        
        DItem Type: BODY, VERTEX, EDGE, FACE, SOLID, ELEM,...
        
        ## Return Code
        
        _Python Output_
        
        - int
        
        Number of entities
        
        ## Sample Code
        
        _Input:_
        
        ```python
        count = JPT.GetCountByType(JPT.DItemType.BODY)
        print(str(count))
        ```
        
        _Output:_
        
        \> `2`
        
        """
        message = "JPT.GetCountByType({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetAllSelected():
        r"""
        ## Description
        
        Get entity information from the selected entity (Connections, Contacts, Parts, ...)
        
        ## Syntax
        
        GetAllSelected()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - DItemVector
        
        Entity information (name, type, typeID, id, info, key, masters, slaves, targets, children, parent )
        
        ## Sample Code
        
        _Input:_
        
        ```python
        sel = JPT.GetAllSelected()
        for s in sel:
            print('name = "{}"'.format(s.name))
            print('type = {}'.format(s.type))
            print('typeID = {}'.format(s.typeID))
            print('info = {}'.format(s.info))
            print('key = {}'.format(s.key))
            for m in s.masters:
                print('masters ID = {}'.format(m.id))
            for s in s.slaves:
            print('slaves ID = {}'.format(s.id))
        ```
        
        _Output:_
        
        \> `name="MPC_3"`
        
        \> `type=CONNECT_MPC`
        
        \> `typeID=96`
        
        \> `info={}`
        
        \> `key=3`
        
        \> `masters ID=20`
        
        \> `slaves ID=44`
        
        """
        message = "JPT.GetAllSelected()".format()
        return JPT_RUN_LINE(message)

    def GetLastCreatedCursor():
        r"""
        ## Description
        
        Get the latest id of created entity
        
        ## Syntax
        
        GetLastCreatedCursor()
        
        ## Inputs
        
        1. NONE
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - DItemVector
        
        Last created Object
        
        ## Sample Code
        
        _Input:_
        
        ```python
        for i in JPT.GetLastCreatedCursor():
            print('{0}, {1}'.format(i.type, i.id))
        ```
        
        _Output:_
        
        \> `BODY, 2`
        \> `EDGE, 27`
        \> `EDGE, 28`
        \> `FACE, 29`
        \> `FACE, 30`
        \> `FACE, 31`
        \> `BODYLINK, 27`
        \> `BODYLINK, 28`
        \> `BODYLINK, 29`
        \> `BODYLINK, 30`
        \> `BODYLINK, 31`
        \> `SHAPELINK, 49`
        \> `SHAPELINK, 50`
        \> `SHAPELINK, 51`
        \> `SHAPELINK, 52`
        \> `NODE, 489`
        \> `NODE, 490`
        \> `...`
        
        """
        message = "JPT.GetLastCreatedCursor()".format()
        return JPT_RUN_LINE(message)

    def GetCenterOfEntities(Input1):
        r"""
        ## Description
        
        Get center coordinate of selected entities
        
        ## Syntax
        
        GetCenterOfEntities(vector DItem)
        
        ## Inputs
        
        1. DItemVector
        
        Vector DItem
        
        ## Return Code
        
        _Python Output_
        
        - DoubleVector
        
        Coordinate\[x,y,z\] of selected entities
        
        ## Sample Code
        
        _Input:_
        
        ```python
        entity = JPT.GetAllSelected()
        center = JPT.GetCenterOfEntities(entity)
        for c in center:
            print(str(float(c)))
        ```
        
        _Output:_
        
        \> `0.004999999999999999`
        
        \> `0.004999999999999999`
        
        \> `0.010000000000000007`
        
        """
        message = "JPT.GetCenterOfEntities({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetSharedFaces(Input1):
        r"""
        ## Description
        
        Get shared face information
        
        ## Syntax
        
        GetSharedFaces(DItemVector DItems)
        
        ## Inputs
        
        1. DItemVector
        
        Vector DItem
        
        ## Return Code
        
        _Python Output_
        
        - DItemVector
        
        Shared face information (typeID, id, key)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        shareFace = JPT.GetAllSelected()
        share = JPT.GetSharedFaces(shareFace)
        for s in share:
            print('typeID="{0}", id="{1}", key="{2}"'.format(s.typeID, s.id, s.key))
        ```
        
        _Output:_
        
        \> `typeID="6", id="115", key="115"`
        
        """
        message = "JPT.GetSharedFaces({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetSharedElements(Input1):
        r"""
        ## Description
        
        Get shared element information
        
        ## Syntax
        
        GetSharedElements(DItemVector DItems)
        
        ## Inputs
        
        1. DItemVector
        
        Vector DItem
        
        ## Return Code
        
        _Python Output_
        
        - DItemVector
        
        Shared element information (type, typeID, id, info, key, masters, slave, targets, children, parent )
        
        ## Sample Code
        
        _Input:_
        
        ```python
        bodies = JPT.GetAllByType(JPT.DItemType.BODY)
        share = JPT.GetSharedElements(bodies)
        for s in share:
            print(str(s.id))
        ```
        
        _Output:_
        
        \> `1170`
        
        \> `1255`
        
        \> `1202`
        
        \> `...`
        
        """
        message = "JPT.GetSharedElements({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetSharedNodes(Input1):
        r"""
        ## Description
        
        Get shared node information
        
        ## Syntax
        
        GetSharedNodes(DItemVector DItems)
        
        ## Inputs
        
        1. DItemVector
        
        Vector DItem
        
        ## Return Code
        
        _Python Output_
        
        - DItemVector
        
        Shared node information (typeID, id, key)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        shareNodes = JPT.GetAllSelected()
        share = JPT.GetSharedNodes(shareNodes)
        for s in share:
            print('typeID="{0}", id="{1}", key="{2}"'.format(s.typeID, s.id, s.key))
        ```
        
        _Output:_
        
        \> `typeID="10", id="585", key="585"`
        
        \> `typeID="10", id="493", key="493"`
        
        \> `typeID="10", id="536", key="536"`
        
        """
        message = "JPT.GetSharedNodes({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetAllLoadsBCs():
        r"""
        ## Description
        
        Get information of all loads and BCs
        
        ## Syntax
        
        GetAllLoadsBCs()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - DItemVector
        
        Load information (type, type ID, id, key, name, info, targets, isValid, masters, slaves, parent, children)
        
        ## Sample Code
        
        _Input:_
        
        ```python
        lbc= JPT.GetAllLoadsBCs()
        for bc in lbc:
            for e in g.targets:
                    print('type="{0}", typeID="{1}", name="{2}", id="{3}", key="{4}", info="{5}", isValid="{6}"'.format(bc.type, bc.typeID, bc.name, bc.id, bc.key, bc.info, bc.isValid))
        ```
        
        _Output:_
        
        \> `type="LBC_CONSTRAINT", typeID="37", name="Constraint1", id="1", key="1", info="{}", isValid="True"`
        
        \> `type="LBC_G\_PRESSURE", typeID="40", name="Pressure1", id="1", key="1", info="{}", isValid="True"`
        
        """
        message = "JPT.GetAllLoadsBCs()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedNodesCr():
        r"""
        undefined
        """
        message = "JPT.GetSelectedNodesCr()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedElemsCr():
        r"""
        undefined
        """
        message = "JPT.GetSelectedElemsCr()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedFacesCr():
        r"""
        undefined
        """
        message = "JPT.GetSelectedFacesCr()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedEdgesCr():
        r"""
        undefined
        """
        message = "JPT.GetSelectedEdgesCr()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedPartsCr():
        r"""
        undefined
        """
        message = "JPT.GetSelectedPartsCr()".format()
        return JPT_RUN_LINE(message)

    def GetSelectedGroupsCr():
        r"""
        undefined
        """
        message = "JPT.GetSelectedGroupsCr()".format()
        return JPT_RUN_LINE(message)

    def GetUndoCount():
        r"""
        ## Description
        
        Get number of undo action which is capable of running
        
        ## Syntax
        
        GetUndoCount()
        
        ## Inputs
        
        1. NONE
        
        No arguments
        
        ## Return Code
        
        _Python Output_
        
        - int
        
        Number of undo action
        
        ## Sample Code
        
        _Input:_
        
        ```python
        undo = JPT.GetUndoCount()
        print(str(undo))
        ```
        
        _Output:_
        
        \> `2`
        
        """
        message = "JPT.GetUndoCount()".format()
        return JPT_RUN_LINE(message)

    def ClearUndo():
        r"""
        ## Description
        
        Clear Undo list
        
        ## Syntax
        
        `ClearUndo()`
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.ClearUndo()
        ```
        
        _Output:_
        
        None
        
        """
        message = "JPT.ClearUndo()".format()
        return JPT_RUN_LINE(message)

    def GetRedoCount():
        r"""
        ## Description
        
        Get number of redo action which is capable of running
        
        ## Syntax
        
        GetRedoCount()
        
        ## Inputs
        
        1. NONE
        
        No arguments
        
        ## Return Code
        
        _Python Output_
        
        - int
        
        Number of redo action
        
        ## Sample Code
        
        _Input:_
        
        ```python
        redo = JPT.GetRedoCount()
        print(str(redo))
        ```
        
        _Output:_
        
        \> `2`
        
        """
        message = "JPT.GetRedoCount()".format()
        return JPT_RUN_LINE(message)

    def ClearRedo():
        r"""
        ## Description
        
        Clear Redo list
        
        ## Syntax
        
        ClearRedo()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.ClearRedo()
        ```
        
        _Output:_
        
        None
        
        """
        message = "JPT.ClearRedo()".format()
        return JPT_RUN_LINE(message)

    def GetOpnList():
        r"""
        ## Description
        
        Get list of Launch Operation
        
        ## Syntax
        
        GetOpnList()
        
        ## Inputs
        
        1. NONE
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - String
        
        List of Launch Operation
        
        ## Sample Code
        
        _Input:_
        
        ```python
        get = JPT.GetOpnList()
        for s in get:
            print(s)
        ```
        
        _Output:_
        
        \> `MESH_EDIT_GEOM_EDIT_FCIRC_VERTEX_ADJUST`
        
        \> `MMC_MUFFLER_MANUAL_PIPE_MERGE_FACES_CIRCUMFERENTIAL`
        
        \> `ENG_NVH_AUTO_BUSH`
        
        \> `THICKNESS_DISTRIBUTION`
        
        \> `....`
        
        """
        message = "JPT.GetOpnList()".format()
        return JPT_RUN_LINE(message)

    def GetMacroLog():
        r"""
        ## Description
        
        Get all of the macro in Macro Window
        
        ## Syntax
        
        GetMacroLog()
        
        ## Inputs
        
        1. NONE
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - String
        
        List of previous Macro in Macro Window
        
        ## Sample Code
        
        _Input:_
        
        ```python
        print(JPT.GetMacroLog())
        ```
        
        _Output:_
        
        \> `LaunchOperation("GEOMETRY_CREATE_ENTITY_PARTS_CUBE", 0)`
        \> `CreateCube(\[0, 0, 0\], \[0.01, 0.01, 0.01\], \[10, 10, 10\], "Cube_1", 7105764, 0:0)`
        \> `LaunchOperation("GEOMETRY_CREATE_ENTITY_PARTS_CYLINDER", 0)`
        \> `CreateCylinderFrustum(\[0, 0, 0\], 0.01, 0.01, 0.01, 36, 10, "Cylinder_1", 6409934, 0:0)`
        
        """
        message = "JPT.GetMacroLog()".format()
        return JPT_RUN_LINE(message)

    def GetPythonAPILog():
        r"""
        undefined
        """
        message = "JPT.GetPythonAPILog()".format()
        return JPT_RUN_LINE(message)

    def ShowHideEntitiesByID(Input1,Input2,Input3):
        r"""
        ## Description
        
        Show or hide an entity by id in view
        
        ## Inputs
        
        1. DTable enum type (JPT.DTableType)
        
        2. entity id (int)
        
        3. show/hide option (1,0 or JPT.BoolType)
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        - show a part
        
        ```python
        JPT.ShowHideEntitiesByID(JPT.DTableType.DTABLE_BODY, 1, JPT.BoolType.TRUE_VAL)
        ```
        
        - hide a part
        
        ```python
        JPT.ShowHideEntitiesByID(JPT.DTableType.DTABLE_BODY, 1, JPT.BoolType.FALSE_VAL)
        ```
        
        """
        message = "JPT.ShowHideEntitiesByID({},{},{})".format(Input1,Input2,Input3)
        return JPT_RUN_LINE(message)

    def ShowHideAllParts(Input1):
        r"""
        ## Description
        
        Show or hide all parts in view
        
        ## Inputs
        
        1. show/hide option (1,0 or JPT.BoolType)
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        - show all parts
        
        ```python
        JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)
        ```
        
        - hide all parts
        
        ```python
        JPT.ShowHideAllParts(JPT.BoolType.FALSE_VAL)
        ```
        
        """
        message = "JPT.ShowHideAllParts({})".format(Input1)
        return JPT_RUN_LINE(message)

    def InverseHideBodies(Input1):
        r"""
        ## Description
        
        Inverse hide parts in view
        
        ## Inputs
        
        1. id of part (int)
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        listbody = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube1", 1)
        idbody = listbody[0].id
        JPT.InverseHideBodies(idbody)
        ```
        
        """
        message = "JPT.InverseHideBodies({})".format(Input1)
        return JPT_RUN_LINE(message)

    def ViewFitToModel():
        r"""
        ## Description
        
        Fit models to current view
        
        ## Inputs
        
        1. idbody
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        JPT.ViewFitToModel()
        ```
        
        """
        message = "JPT.ViewFitToModel()".format()
        return JPT_RUN_LINE(message)

    def Exec(Input1_str):
        r"""
        ## Description
        
        Run Jupiter macro
        
        ## Syntax
        
        Exec(string macroCommand)
        
        ## Inputs
        
        1. string
        
        Macro command
        
        ## Return Code
        
        _Python Output_
        
        - Refer each macro command
        
        ## Sample Code
        
        _Input:_
        
        ```python
        res = JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0) ')
        print(res)
        ```
        
        _Output:_
        
        \> `1`
        
        """
        message = "JPT.Exec('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def GetMaxIDEntity(Input1):
        r"""
        ## Description
        
        Get max id entity from DItem type
        
        ## Inputs
        
        1. DItem enum type (JPT.DItemType)
        
        ## Return Code
        
        max id entity (int)
        
        ## Sample Code
        
        ```python
        JPT.GetMaxIDEntity(JPT.DItemType.BODY)
        ```
        
        """
        message = "JPT.GetMaxIDEntity({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetMinIDEntity(Input1):
        r"""
        ## Description
        
        Get min id entity from DItem type
        
        ## Inputs
        
        1. DItem enum type (JPT.DItemType)
        
        ## Return Code
        
        min id entity (int)
        
        ## Sample Code
        
        ```python
        JPT.GetMinIDEntity(JPT.DItemType.BODY)
        ```
        
        """
        message = "JPT.GetMinIDEntity({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetEntitiesByName(Input1,Input2_str,Input3):
        r"""
        ## Description
        
        Get list of object entity by name
        
        ## Inputs
        
        1. DTableType enum type (JPT.DItemType)
        
        2. name of entity (string)
        
        3. match with name option (1,0 or JPT.BoolType)
        
        ## Return Code
        
        list of object entity (ItemVector)
        
        ## Sample Code
        
        ```python
        listbody = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, "Cube1", 1)
        ```
        
        """
        message = "JPT.GetEntitiesByName({},'{}',{})".format(Input1,Input2_str,Input3)
        return JPT_RUN_LINE(message)

    def GetEntitiesByID(Input1,Input2):
        r"""
        ## Description
        
        Get list of object entity by id
        
        ## Inputs
        
        1. DItem enum type (JPT.DItemType)
        
        2. id entity (int)
        
        ## Return Code
        
        list of object entity (ItemVector)
        
        ## Sample Code
        
        ```python
        listbody = JPT.GetEntitiesByID(JPT.DItemType.BODY, 1)
        ```
        
        """
        message = "JPT.GetEntitiesByID({},{})".format(Input1,Input2)
        return JPT_RUN_LINE(message)

    def GetEntitiesByPosition(Input1,Input2,Input3,Input4):
        r"""
        ## Description
        
        Get list of entity object by positionn
        
        ## Inputs
        
        1. AssociateType enum type (JPT.AssociateType)
        
        2. x (double)
        
        3. y (double)
        
        4. z (double)
        
        ## Return Code
        
        list of Entity object (EntityVector)
        
        ## Sample Code
        
        ```python
        JPT.GetEntitiesByPosition(JPT.AssociateType.AS_BODY, 1, 2, 3)
        ```
        
        """
        message = "JPT.GetEntitiesByPosition({},{},{},{})".format(Input1,Input2,Input3,Input4)
        return JPT_RUN_LINE(message)

    def GetEntitiesByAssociation(Input1,Input2,Input3):
        r"""
        ## Description
        
        Get list of entity object by association
        
        ## Inputs
        
        1. DItem enum type (JPT.DItemType)
        
        2. AssociateType type (JPT.AssociateType)
        
        3. id entity (int)
        
        ## Return Code
        
        list of DItem object (ItemVector)
        
        ## Sample Code
        
        ```python
        JPT.GetEntitiesByAssociation(JPT.DItemType.BODY, JPT.AssociateType.AS_BODY, 1)
        ```
        
        """
        message = "JPT.GetEntitiesByAssociation({},{},{})".format(Input1,Input2,Input3)
        return JPT_RUN_LINE(message)

    def GetEntitiesByAdjacent(Input1,Input2,Input3):
        r"""
        ## Description
        
        Get list of entity object by adjacency
        
        ## Inputs
        
        1. DItem enum type (JPT.DItemType)
        
        2. id entity (int)
        
        3. stop angle (int)
        
        ## Return Code
        
        list of DItem object (ItemVector)
        
        ## Sample Code
        
        ```python
        JPT.GetEntitiesByAdjacent(JPT.DItemType.BODY, 1, 30)
        ```
        
        """
        message = "JPT.GetEntitiesByAdjacent({},{},{})".format(Input1,Input2,Input3)
        return JPT_RUN_LINE(message)

    def MsgOut(Input1_str):
        r"""
        ## Description
        
        Display string in Python Output.
        
        ## Syntax
        
        MsgOut()
        
        ## Inputs
        
        1. None
        
        No input value
        
        ## Return Code
        
        _Python Output_
        
        - No return value
        
        ## Sample Code
        
        _Input:_
        
        ```python
        JPT.MsgOut('Hello!!!')
        ```
        
        _Output:_
        
        \> `Hello!!!`
        
        """
        message = "JPT.MsgOut('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def PrintAppPathInfo():
        r"""
        ## Description
        
        Print all JPT path information (Program, Temp, Appdata, Document)
        
        ## Inputs
        
        1.  None
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        JPT.PrintAppPathInfo()
        ```
        
        """
        message = "JPT.PrintAppPathInfo()".format()
        return JPT_RUN_LINE(message)

    def PrintPSJUtilityManual():
        r"""
        ## Description
        
        Print PSJ Utility Manual Information
        
        ## Inputs
        
        1. None
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        JPT.PrintPSJUtilityManual()
        ```
        
        """
        message = "JPT.PrintPSJUtilityManual()".format()
        return JPT_RUN_LINE(message)

    def Debugger(Input1):
        r"""
        ## Description
        
        Console debugger for PSJ
        
        - debug enum list
        - debug python standard type
        - debug Jupiter data type
        
        ## Inputs
        
        1. any type, any argument number
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        """
        message = "JPT.Debugger({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetElemsByKind(Input1):
        r"""
        ## Description
        
        Get list of element object by kind
        
        ## Inputs
        
        1. element enum kind (JPT.ElemKind)
        
        ## Return Code
        
        list of DElem object (ElemVector)
        
        ## Sample Code
        
        ```python
        listElemObject = JPT.GetElemsByKind(JPT.ElemKind.ELEMKIND_2D)
        ```
        
        """
        message = "JPT.GetElemsByKind({})".format(Input1)
        return JPT_RUN_LINE(message)

    def GetRandomJPTColor():
        r"""
        ## Description
        
        Get a random color
        
        ## Inputs
        
        1. None
        
        ## Return Code
        
        random color number (int)
        
        ## Sample Code
        
        ```python
        color = JPT.GetRandomJPTColor()
        ```
        
        """
        message = "JPT.GetRandomJPTColor()".format()
        return JPT_RUN_LINE(message)

    def ConvertJPTColorToRGB(Input1):
        r"""
        ## Description
        
        Convert JPT color to string RGB (red, green, blue)
        
        ## Inputs
        
        1. JPT color (int)
        
        ## Return Code
        
        string RGB (string)
        
        ## Sample Code
        
        ```python
        stringRGB = JPT.ConvertJPTColorToRGB(255)
        ```
        
        """
        message = "JPT.ConvertJPTColorToRGB({})".format(Input1)
        return JPT_RUN_LINE(message)

    def ClearLog():
        r"""
        ## Description
        
        clear all log on Python API Window
        
        ## Inputs
        
        1. None
        
        ## Return Code
        
        None
        
        ## Sample Code
        
        ```python
        JPT.ClearLog()
        ```
        
        """
        message = "JPT.ClearLog()".format()
        return JPT_RUN_LINE(message)

    def SetSelectMethod(Input1):
        r"""
        undefined
        """
        message = "JPT.SetSelectMethod({})".format(Input1)
        return JPT_RUN_LINE(message)

    def MacroTCursorPairToDItemPair(Input1_str):
        r"""
        undefined
        """
        message = "JPT.MacroTCursorPairToDItemPair('{}')".format(Input1_str)
        return JPT_RUN_LINE(message)

    def MessageBoxPSJ(Input1_str,Input2):
        r"""
        undefined
        """
        message = "JPT.MessageBoxPSJ('{}',{})".format(Input1_str,Input2)
        return JPT_RUN_LINE(message)

    def GetProgramVersion(Input):
        r"""
        undefined
        """
        message = "JPT.GetProgramVersion({})".format(Input)
        return JPT_RUN_LINE(message)

    def GetMaterialFromProperty(Input):
        r"""
        undefined
        """
        message = "JPT.GetMaterialFromProperty({})".format(Input)
        return JPT_RUN_LINE(message)

    def GetAllCoordinates(Input):
        r"""
        undefined
        """
        message = "JPT.GetAllCoordinates({})".format(Input)
        return JPT_RUN_LINE(message)

    def GetAllConnections(Input):
        r"""
        undefined
        """
        message = "JPT.GetAllConnections({})".format(Input)
        return JPT_RUN_LINE(message)

    def GetAllLoadBoundaryConditions(Input):
        r"""
        undefined
        """
        message = "JPT.GetAllLoadBoundaryConditions({})".format(Input)
        return JPT_RUN_LINE(message)

    def GetThicknessOfEntity(Input1,Input2):
        r"""
        undefined
        """
        message = "JPT.GetThicknessOfEntity({},{})".format(Input1,Input2)
        return JPT_RUN_LINE(message)
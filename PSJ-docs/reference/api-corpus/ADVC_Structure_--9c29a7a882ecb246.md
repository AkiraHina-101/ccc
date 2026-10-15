# ADVC_Structure()

ADVC_Structure()

Description​

Create ADVC job (Structure)

Syntax​

ADVC_Structure(string Name, string Description, int JobType, cursor[] processSequence,
    cursor[] elemLocationGroup, cursor[] nodeLocationGroup, bool WriteGroup,
    cursor Edit, bool ResultReference, int iSeparateFile, bool ExportRelatedAllLBCs,
    bool UseEntityName, bool MatrixSloverParam, int PreconditionType,
    int MatrixStructure, cursor[] Target, int LoadType,bool SameOutputOnAllProcess,
    bool DeleteFloatingNode, bool BC, bool CheckBCDuplicate, bool AutoAssignDummyProp,
    cursor crDummyPropMaterial, bool ReferenceRestartData, string ReferenceRestartDataPath,
    int ReferenceRestartDataProcessNum, int ReferenceRestartDataStepNum,
    int ReferenceRestartDataCoordType, int ReferenceRestartDataUpdateContactSearch,
    LoadNodeData[] LoadData, int HeatConvection, bool bCreateProcessForBoltFixedLength, string Path, 
    int NumType, int UiWidth, int UiWidth, bool ExportGeometryID, bool SeparatePartInfoFile,
    string ADVCTemplateFilePath, bool OutputDefinition, int DetaFormatType,
    List ObjectiveFunction, List ConstraintFunction, List NonDesignableArea, List ShapeTopology, List OptimizationOutput)

Inputs​

1. String​

Name of ADVC Job

2. String​

Description of ADVC Job

'3. Int'​

Job type [0: Structural]

4. Cursor[]​

Advc process sequence

5. Cursor[]​

Element location group

6. Cursor[]​

Node location group

7. Bool​

Write group flag true = 1, false = 0

8. Cursor​

Edit ADVC Job

9. Bool​

Result reference flag true = 1, flase = 0

10. Int​

Separated file type[0:None; 1:By Model; 2:By Body; 3:By Selected Body, 4:Select LBCs]

11. Bool​

Export all related LBCs flag true = 1, false = 0

12. Bool​

Use entity name flag true = 1, false = 0

13. Bool​

Define matrix solver parameter flag true = 1, false = 0

14. Int​

Precondition type[0:Scaling; 1:CGCG; 2:CGCG2; 3:CGCG2_Diag; 4:CGCG2-SOR]

15. Int​

Matrix structure [0:Symmetry; 1:Asymmetry]

16. Cursor[]​

Target list

17. Int​

Load type [0:Load Case; 1:Load]

18. Bool​

All outputs are same flag true = 1, false = 0

19. Bool​

Delete floating node flag true = 1, false = 0

20. Bool​

Boundary condition flag true = 1, false = 0

21. Bool​

Check Boundary condition Duplicate flag true = 1, false = 0

22. Bool​

Auto Assign Dummy Property

23. Cursor​

Dummy Property Material

24. Bool​

Reference Restart Data flag true = 1, false = 0

25. String​

Reference Restart Data Path

26. Int​

Reference Restart Data Process Num

27. Int​

Reference Restart Data Step Num

28. Int​

Reference Restart Data Coord Type

29. Int​

Reference Restart Data Update Contact Search

30. LoadNodeData[]​

LoadNodeData list

31. Int​

Heat convection  (not used for Structural), set 0.

32. Bool​

Create process for bolt fixed lentgh flag true = 1, false = 0

33. String​

Exported adx file path

34. Int​

Numric type.  [0:Real; 1:Power, 2:Auto]

35. Int​

UI Width

36. Int​

UI Precision

37. Bool​

Export geometry id flag true = 1, false = 0

38. Bool​

Separate part info file flag true = 1, false = 0

39. String​

ADVC Template file path

40. Bool​

Output definition flag true = 1, false = 0

41. Bool​

Data format type. [0:Single, 1:Double]

42. ObjectiveFunction​

A Vector specifying Objective Function.

Defined by Optimization_ObjectiveConstraint_Parameter. Members are as follows:
### ` enFunctionType` - An _Integar_ specifying the function type.
 | ID | Function | Description

 | -1 | Unknown_Function | No selection

 | 0 | Compliance_Function | Compliance Function

 | 1 | Displacement_Function | Displacement Function

 | 2 | Eigen_Frequency_Function | Eigen Frequency Function

 | 3 | Mass_Function | Mass Function

 | 4 | Maximum Displacement Function | Maximum Displacement Function

 | 5 | Maximum_Mises_Stress_Function | Maximum Mises Stress Function

 | 6 | Maximum_Principal_Stress_Function | Maximum Principal Stress Function

 | 7 | Minimum_Principal_Stress_Function | Minimum Principal Stress Function

 | 8 | Surface_Area_Function | Surface Area Function

 | 9 | Volume_Function | Volume Function

 | 10 | Optimization_Frozen_Node | Optimization Frozen Node

 | 11 | Optimization_Frozen_Element | Optimization_Frozen Element

 | 12 | Shape_Optimization_Fixed_Node | Shape Optimization Fixed Node

 | 13 | Shape_Optimization | Shape Optimization

 | 14 | Shape_Optimization_Contact_pair | Shape Optimization Contact pair

 | 15 | Shape_Optimization_Die_Drawing | Shape Optimization Die Drawing

 | 16 | Shape_Optimization_Interference_Node | Shape Optimization Interference Node

 | 17 | Shape_Optimization_Thickness | Shape Optimization Thickness

 | 18 | Topology_Optimization | Topology Optimization

 | 19 | Topology_Optimization_Die_Drawing | Topology Optimization Die Drawing

 | 20 | Optimization_Function_Type_Count | Optimization Function Type Count

This is a required input.

 strFunctionName​

A String specifying the name of function.

This is a required input.

iDisplacementRelation​

A Int specifying to set Displacement Relation or not.

The default value is -1.

strDegreeOfFreedomNum​

A String specifying to set Degree Of Freedom Number.

dDisplacementCoefficient​

A Double specifying to set Displacement Coefficient.

iConstraint​

A Int specifying type of Constraint.
If iConstraint=0: Equality

If iConstraint=1: Inequality

dConstraintTol​

A Double specifying Constraint Tolerance.

iTargetType​

An Int specifying Target Type.
If iTargetType=0: Ratio

If iTargetType=1: Value

dRatioOrValue​

A Double specifying Ratio or Value.

dCoefficient​

A Double specifying to set Coefficient.

crNodeSet​

A Cursor specifying Node Set.

crPropOrElemSet​

A Cursor specifying Element Set.

crSurfaceSet​

A Cursor specifying Surface Set.

iKSKernel​

A Int specifying type of KS Kernel.
If iKSKernel=0: Exponential

If iKSKernel=1: Monomial

dRHO​

A Double specifying RHO.

dExponent​

A Double specifying Exponent.

iEigenNumber;​

An Int specifying Eigen Number.

43 ConstraintFunction​

A Vector specifying Constraint Function.

Defined by Optimization_ObjectiveConstraint_Parameter. 

44 NonDesignableArea​

A Vector specifying Non-Designable Area.

Defined by Optimization_NonDesignableArea_Parameter. Members are as follows:
enFunctionType​

An Integar specifying the function type..

This is a required input.

strFunctionName​

A String specifying the name of function.

This is a required input.

iOptimization = -1​

An Int specifying type of Optimization.

If iOptimization=0: Shape

If iOptimization=1: Topology

strDegreeOfFreedomNum​

A String specifying Degree of Freedom Number.

crNodeSet​

A Cursor specifying Node Set.

crPropOrElemSet​

A Cursor specifying Element Set.

vecShapeTopology​

A Vector specifying Shape/Topology.

Defined by Optimization_ShapeTopology_Parameter. Members are as follows:
enFunctionType = Unknown_Function;​

An Integar specifying the function type..

This is a required input.

strFunctionName​

A String specifying the name of function.

This is a required input.

dInitialDensity​

A Double specifying Initial Density.

dDensityRandom​

A Double specifying Density Random.

dAlpha​

A Double specifying Alpha.

dDraftAngle​

A Double specifying Draft Angle.

dGap​

A Double specifying Gap.

dDepth​

A Double specifying Depth.

dAngle​

A Double specifying Angle.

dClearance​

A Double specifying Clearance.

dThicknessDepth​

A Double specifying Thickness Depth.

dMaxThickness​

A Double specifying Max Thickness.

dMinThickness​

A Double specifying Min Thickness.

iMaxIteration​

An Int specifying Max Iteration.

dMaxStrain​

A Double specifying Max Strain.

dMaxTheta​

A Double specifying Max Theta.

dH1Tolerance​

A Double specifying H1 Tolerance.

iOutputLast​

An Int specifying selection of Output Last.

If iOutputLast=0: No

If iOutputLast=1: Yes

iOutputInterval​

An Int specifying Output Interval.

iResoutLast​

An Int specifying selection of Resout Last.

If iResoutLast=0: No

If iResoutLast=1: Yes

iResoutInterval​

An Int specifying Resout Interval.

iArmijoCheck​

An Int specifying selection of Armijo Check.

If iArmijoCheck=0: No

If iArmijoCheck=1: Yes

dArmijoParam​

A Double specifying Armijo Param.

strDirection​

A String specifying Direction.

iPunchingOneSide​

An Int specifying selection of Punching|Outside.

If iPunchingOneSide=0: Punching

If iPunchingOneSide=1: Oneside

iAutoIncrement​

An Int specifying selection of Auto Increment.

If iAutoIncrement=0: No

If iAutoIncrement=1: Yes

dStabilizationFactor​

A Double specifying Stabilization Factor.

dPoissonRatio​

A Double specifying Poisson Ratio.

iAutoFrozen​

An Int specifying selection of Auto Frozen.

If iAutoFrozen=0: No

If iAutoFrozen=1: Yes

iKeyCoordinate​

An Int specifying selection of Coodinate.

crNodeSet​

A Cursor to specifying Node Set.

crPropOrElemSet​

A Cursor to specifying Element Set.

crSurfaceSetNonInterferingArea​

A Cursor to specifying Non-Interfering Area.

crSurfaceSetOptimizedArea​

A Cursor to specifying Optimized Area.

iWolfeCheck​

An Int specifying selection of Wolfe Check.

If iWolfeCheck=0: No

If iWolfeCheck=1: Yes

dWolfeParam​

A Double specifying Wolfe Param.

iMatrix​

An Int specifying selection of Matrix.

If iMatrix=0: StiffnessLinear

If iMatrix=1: Stiffness

iElementDStiffness​

An Int specifying selection of Element D.Stiffness.

If iElementDStiffness=0: No

If iElementDStiffness=1: Yes

iConstraintMethod​

An Int specifying selection of Constraint Method.

If iConstraintMethod=0: No

If iConstraintMethod=1: Yes

dGrayScaleRatio​

A Double specifying gray scale ratio.

iOutputGrayScaleRatio​

An Int Specifing whether or not output gray scale ratio.

45. OptimizationOutput​

A list of Boolean specifying the optimization output paramters. Output if it set 1. From left to right, 

NodalShapeVariation

ShapeVariation

NodalDensityRation

DensityRation

Sensitivity

Sensitivity_Of_Objective

Sensitivity_Of_Constraint

Sensitivities

Return Code​

"1": The function can be executed

"FAILED": The function cannot be executed

Sample Code​

ADVC_Structure("Job_1", "", 0, [119:1], [], [], 0, 0:0, 0, 0, 0, 0, 0, 0, 0, [3:2], 1, 1, 1, 1, 0, 1, 22:1, 0, "", 2147483647, 2147483647, 0, 1, [], 0, 0, "C:/Temp/Export.adx", 0, 10, 6, 0, 0, "", 1, 0, [(0, "Compliance_1", 0, "", 1.79769e+308, [119:1], -1, 1.79769e+308, -1, 1.79769e+308, 1, 0:0, 0:0, 0:0, -1, 1.79769e+308, 1.79769e+308, 2147483647)], [(9, "Volume_1", 0, "", 1.79769e+308, [], 0, 1.79769e+308, -1, 0.4, 1, 0:0, 0:0, 0:0, -1, 1.79769e+308, 1.79769e+308, 2147483647)], [], [(13, "ShapeOptimization_1", 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 100, 0.1, 1.79769e+308, 0.01, 1, 1, -1, 2147483647, -1, 1.79769e+308, "", -1, -1, 1.79769e+308, 1.79769e+308, 1, -1, 0:0, 0:0, 0:0, 0:0, [], -1, 1.79769e+308, -1, -1, -1, 1, 1)], (0, 1, 0, 0, 1, 1, 1, 1))

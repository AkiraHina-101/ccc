# Property1DBeamN()

Property1DBeamN()

Description​

1D Beam property

Syntax​

Property1DBeam(string Name, int Id, color propertyColor, Cursor Section, int ShapeDataType,
    Cursor Material, double Area, double[3] Orient, double[3] Inertia,
    double TorConst, double NSM, double NSM_A, double NSM_B, double NSM_NodeAy,
    double NSM_NodeAz, double NSM_NodeBy, double NSM_NodeBz, double ShearStiffnessK1,
    double ShearStiffnessK2, double AreaReliefS1, double AreaReliefS2,
    double WrapCoefficientA, double WrapCoefficientB, double Y_NA_NodeA,
    double Z_NA_NodeA, double Y_NA_NodeB, double Z_NA_NodeB, double StressRevoceryCoeff_Cy,
    double StressRevoceryCoeff_Cz, double StressRevoceryCoeff_Dy,
    double StressRevoceryCoeff_Dz, double StressRevoceryCoeff_Ey,
    double StressRevoceryCoeff_Ez, double StressRevoceryCoeff_Fy,
    double StressRevoceryCoeff_Fz, bool PinA0, bool PinA1, bool PinA2, bool PinA3,
    bool PinA4, bool PinA5, bool PinB0, bool PinB1, bool PinB2, bool PinB3, bool PinB4,
    bool PinB5, double[3] OffsetPointA, double[3] OffsetPointB, int LocalLengthUnit,
    int LocalMassUnit, Cursor[] Target, Cursor credit, bool Tapped, int IntePtNum)

Inputs​

1. string​

Name

2. Int​

ID

3. Color​

Color of the property.

4. Cursor​

Section

5. int​

Shape data type [SHAPE_TYPE_UNKNOWN = 0, SHAPE_TYPE_M3 = 1, SHAPE_TYPE_M4 =2, SHAPE_TYPE_M6 = 3, SHAPE_TYPE_M8 = 4, SHAPE_TYPE_M10 = 5, SHAPE_TYPE_M12 = 6, SHAPE_TYPE_M14 = 7, SHAPE_TYPE_M16 = 8, SHAPE_TYPE_M18 = 9, SHAPE_TYPE_M20 = 10, SHAPE_TYPE_M22 = 11, SHAPE_TYPE_M24 = 12, SHAPE_TYPE_M26 = 13, SHAPE_TYPE_M28 = 14, SHAPE_TYPE_M30 = 15, SHAPE_TYPE_M32 = 16, SHAPE_TYPE_M34 = 17, SHAPE_TYPE_M36 = 18, SHAPE_TYPE_CIRC = 19]

6. cursor​

Material

7. double​

Area

8. double[3]​

Orient Vector double list [x,y,z]

9. Double[3]​

Inertia double list [Izz,Iyy,Izy]

10. double​

Tor const

11. double​

NSM

12. double​

NSM_A

13. double​

NSM_B

14. Double​

NSM_NodeAy

15. Double​

NSM_NodeAz

16. Double​

NSM_NodeBy

17. Double​

NSM_NodeBz

18. Double​

Shear stiffness K1

19. Double​

Shear stiffness K2

20. Double​

Shear area relief S1

21. Double​

Shear area relief S2

22. Double​

Wrap Coefficient A

23. Double​

Wrap Coefficient B

24. double​

Y/NA@NodeA

25. double​

Y/NA@NodeA

26. double​

Z/NA@NodeB

27. double​

Z/NA@NodeB

28. double​

Stress recovery coefficient Cy

29. Double​

Stress recovery coefficient Cz

30. Double​

Stress recovery coefficient Dy

31. Double​

Stress recovery coefficient Dz

32. Double​

Stress recovery coefficient Ey

33. Double​

Stress recovery coefficient Ez

34. Double​

Stress recovery coefficient Fy

35. Double​

Stress recovery coefficient Fz

36. Bool​

Pin flag at A1 true = 1, false = 0

37. Bool​

Pin flag at A2 true = 1, false = 0

38. Bool​

Pin flag at A3 true = 1, false = 0

39. Bool​

Pin flag at A4 true = 1, false = 0

40. Bool​

Pin flag at A5 true = 1, false = 0

41. Bool​

Pin flag at A6 true = 1, false = 0

42. Bool​

Pin flag at B1 true = 1, false = 0

43. Bool​

Pin flag at B2 true = 1, false = 0

44. Bool​

Pin flag at B3 true = 1, false = 0

45. Bool​

Pin flag at B4 true = 1, false = 0

46. Bool​

Pin flag at B5 true = 1, false = 0

47. Bool​

Pin flag at B6 true = 1, false = 0

48. Double[3]​

Offset PointA double list

49. Double[3]​

Offset PointB double list

50. Int​

Local Unit Length

51. Int​

Local Unit mass

52. Cursor[]​

Target list

53. Cursor​

Edit 1D Beam

54. Bool​

Tapered flag true = 1, false = 0

55. double​

Taper Area

56. double[3]​

Taper Inertia [Inertia I1/Izz, Inertia I2/Iyy, Inertia I1,2]

57. double​

Taper Torsional Const

58. double​

Taper Non Struct MassL

59. double​

Taper Stress Recovery Coeff Cy

60. double​

Taper Stress Recovery Coeff Cz

61. double​

Taper Stress Recovery Coeff Dy

62. double​

Taper Stress Recovery Coeff Dz

63. double​

Taper Stress Recovery Coeff Ey

64. double​

Taper Stress Recovery Coeff Ez

65. double​

Taper Stress Recovery Coeff Fy

66. double​

Taper Stress Recovery Coeff Fz

67. int​

Integration Points Num

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property1DBeamN("BEAM1", 5, 13478620, 0:0, 0, 22:1, 1e-06, [0, 1, 0], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 
    [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, [5:19], 0:0, 0, 1.79769e+308, 
    [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647)

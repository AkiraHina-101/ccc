# Property1DBeam()

Property1DBeam()

Description​

1D Beam property

Syntax​

Property1DBeam(string Name, int Id, Cursor Section, int ShapeDataType,
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

3. Int​

Shape data type [SHAPE_TYPE_UNKNOWN = 0, SHAPE_TYPE_M3 = 1, SHAPE_TYPE_M4 =2, SHAPE_TYPE_M6 = 3, SHAPE_TYPE_M8 = 4, SHAPE_TYPE_M10 = 5, SHAPE_TYPE_M12 = 6, SHAPE_TYPE_M14 = 7, SHAPE_TYPE_M16 = 8, SHAPE_TYPE_M18 = 9, SHAPE_TYPE_M20 = 10, SHAPE_TYPE_M22 = 11, SHAPE_TYPE_M24 = 12, SHAPE_TYPE_M26 = 13, SHAPE_TYPE_M28 = 14, SHAPE_TYPE_M30 = 15, SHAPE_TYPE_M32 = 16, SHAPE_TYPE_M34 = 17, SHAPE_TYPE_M36 = 18, SHAPE_TYPE_CIRC = 19]

4. Cursor​

Material

5. Double​

Area

6. Double[3]​

Orient Vector double list [x,y,z]

7. Double[3]​

Inertia double list [Izz,Iyy,Izy]

8. Double​

Tor const

9. Double​

NSM

10. Double​

NSM_A

11. Double​

NSM_B

12. Double​

NSM_NodeAy

13. Double​

NSM_NodeAz

14. Double​

NSM_NodeBy

15. Double​

NSM_NodeBz

16. Double​

Shear stiffness K1

17. Double​

Shear stiffness K2

18. Double​

Shear area relief S1

19. Double​

Shear area relief S2

20. Double​

Wrap Coefficient A

21. Double​

Wrap Coefficient B

22. Double​

Stress recovery coefficient Cy

23. Double​

Stress recovery coefficient Cz

24. Double​

Stress recovery coefficient Dy

25. Double​

Stress recovery coefficient Dz

26. Double​

Stress recovery coefficient Ey

27. Double​

Stress recovery coefficient Ez

28. Double​

Stress recovery coefficient Fy

29. Double​

Stress recovery coefficient Fz

30. Bool​

Pin flag at A3 true = 1, false = 0

31. Bool​

Pin flag at A4 true = 1, false = 0

32. Bool​

Pin flag at A5 true = 1, false = 0

33. Bool​

Pin flag at B0 true = 1, false = 0

34. Bool​

Pin flag at B1 true = 1, false = 0

35. Bool​

Pin flag at B2 true = 1, false = 0

36. Bool​

Pin flag at B3 true = 1, false = 0

37. Bool​

Pin flag at B4 true = 1, false = 0

38. Bool​

Pin flag at B5 true = 1, false = 0

39. Double[3]​

Offset PointA double list

40. Double[3]​

Offset PointB double list

41. Int​

Local Unit Length

42. Int​

Local Unit mass

43. Cursor[]​

Target list

44. Cursor​

Edit 1D Beam

45. Bool​

Tapped flag true = 1, false = 0

46. Int​

Integration Points Num

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property1DBeam("BEAM2", 2, 93:1, 0, 22:2, 1.25664e-07, [1, 3, 3], [1.257e-15, 1.257e-15, 0],
    2.513e-15, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 0.9, 0.9, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 1.79769e+308, 1.79769e+308, 0.0002, -0, 0, 0.0002, -0.0002, 0, -0, -0.0002,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308],
    [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, [5:1], 0:0, 0, 2147483647)

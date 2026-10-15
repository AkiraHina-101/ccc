# Property1DBar()

Property1DBar()

Description​

1D Bar property

Syntax​

Property1DBar(string Name, int Id, color propertyColor, Cursor Section, int ShapeDataType, Cursor Material,
    double Area, double[3] Orient, double[3] Inertia, double TorConst, double NSM,
    double ShearAreaFactor1, double ShearAreaFactor2, double StressRevoceryCoeff_Cy,
    double StressRevoceryCoeff_Cz, double StressRevoceryCoeff_Dy, double StressRevoceryCoeff_Dz,
    double StressRevoceryCoeff_Ey, double StressRevoceryCoeff_Ez, double StressRevoceryCoeff_Fy,
    double StressRevoceryCoeff_Fz, bool PinA0, bool PinA1, bool PinA2, bool PinA3,
    bool PinA4, bool PinA5, bool PinB0, bool PinB1, bool PinB2, bool PinB3, bool PinB4,
    bool PinB5, double[3] PointA, double[3] PointB, int LocalLengthUnit, int LocalMassUnit,
    Cursor[] Target, Cursor crEdit)

Inputs​

1. string​

Name

2. Int​

ID

3. Color​

Color of the property.

4. Int​

Shape data type [SHAPE_TYPE_UNKNOWN = 0, SHAPE_TYPE_M3 = 1, SHAPE_TYPE_M4 =2, SHAPE_TYPE_M6 = 3, SHAPE_TYPE_M8 = 4, SHAPE_TYPE_M10 = 5, SHAPE_TYPE_M12 = 6, SHAPE_TYPE_M14 = 7, SHAPE_TYPE_M16 = 8, SHAPE_TYPE_M18 = 9, SHAPE_TYPE_M20 = 10, SHAPE_TYPE_M22 = 11, SHAPE_TYPE_M24 = 12, SHAPE_TYPE_M26 = 13, SHAPE_TYPE_M28 = 14, SHAPE_TYPE_M30 = 15, SHAPE_TYPE_M32 = 16, SHAPE_TYPE_M34 = 17, SHAPE_TYPE_M36 = 18, SHAPE_TYPE_CIRC = 19]

5. Cursor​

Material

6. Double​

Area

7. Double[3]​

Orient Vector double list [x,y,z]

8. Double[3]​

Inertia double list [Izz,Iyy,Izy]

9. Double​

Tor const

10 Double​

NSM

11. Double​

Shear area factor K1

12. Double​

Shear area factor K2

13. Double​

Stress recovery coefficient Cy

14. Double​

Stress recovery coefficient Cz

15. Double​

Stress recovery coefficient Dy

16. Double​

Stress recovery coefficient Dz

17. Double​

Stress recovery coefficient Ey

18. Double​

Stress recovery coefficient Ez

19. Double​

Stress recovery coefficient Fy

20. Double​

Stress recovery coefficient Fz

21. Bool​

Pin flag at A0 true = 1, false = 0

22. Bool​

Pin flag at A1 true = 1, false = 0

23. Bool​

Pin flag at A2 true = 1, false = 0

24. Bool​

Pin flag at A3 true = 1, false = 0

25. Bool​

Pin flag at A4 true = 1, false = 0

26. Bool​

Pin flag at A5 true = 1, false = 0

27. Bool​

Pin flag at B0 true = 1, false = 0

28. Bool​

Pin flag at B1 true = 1, false = 0

29. Bool​

Pin flag at B2 true = 1, false = 0

30. Bool​

Pin flag at B3 true = 1, false = 0

31. Bool​

Pin flag at B4 true = 1, false = 0

32. Bool​

Pin flag at B5 true = 1, false = 0

33. Double[3]​

Offset PointA double list

34. Double[3]​

Offset PointB double list

35. Int​

Local Unit Length

36. Int​

Local Unit mass

37. Cursor[]​

Target list

38. Cursor​

Edit 1D Bar

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property1DBar("BAR3", 1, 14572863, 93:1, 0, 22:2, 3.14159e-06, [0, 1, 0], [7.85398e-13, 7.85398e-13, 0],
    1.5708e-12, 1.79769e+308, 0.9, 0.9, 0.001, -0, 0, 0.001, -0.001, 0, -0, -0.001, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308],
    [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, [5:1], 0:0)

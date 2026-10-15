# SearchTargetFacesInModel()

SearchTargetFacesInModel()

Description​

Search target faces in model

Syntax​

SearchTargetFacesInModel(int BodyType, double[3] OriginPoint, double[3] LengthXYZ,
    double[3] CenterPoint, double[3] MajorPoint, double[3] MinorPoint, bool Enclosed)

Inputs​

1. Int​

Body Type

0: Cube

1: Spheroid

2. Double[3]​

Origin Point

3. Double[3]​

Length X, Y, Z

4. Double[3]​

Center point

5. Double[3]​

Major point

6. Double[3]​

Minor point

7. Bool​

Enclosed bool flag 0: False, 1: True

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SearchTargetFacesInModel(0, [0, 0, 0], [0.01, 0.01, 0.01], [0, 0, 0], [0, 0, 0.01], [0.005, 0, 0], 0)

# Geom_FindFeatures()

Geom_FindFeatures()

Description​

Face/Edge selected of grouped by its feature

Syntax​

Geom_FindFeatures(int taItems, int nType, int nOption, TKey taEdgeItems, int bCylinder, bool bDisc,
    bool bFourCorners, double dMinThickness, double dMaxThickness, double dDiameterMin,
    double dDiameterMax, TKey taFaceItems)

Inputs​

1. Int[]​

Items ID

2. Int​

If Type == 1 find faces, if type == 2 find edges

3. Int​

Option

4. Int[]​

Edge ID

5. Bool​

Cylinder flag true = 1, false = 0

6. Bool​

Disc flag true = 1, false = 0

7. Bool​

Four corners flag true = 1, false = 0

8. Double​

Min thickness value

9. Double​

Max thickness value

10. Double​

Min Diameter value

11. Double​

Max diameter value

12. Int[]​

Face ID

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Geom_FindFeatures([1], 1, 0, [], 1, 0, 1, 0.1, 2, 1, 2, [])

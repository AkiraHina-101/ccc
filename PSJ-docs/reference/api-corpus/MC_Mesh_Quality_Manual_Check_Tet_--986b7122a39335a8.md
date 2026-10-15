# MC_Mesh_Quality_Manual_Check_Tet()

MC_Mesh_Quality_Manual_Check_Tet()

Description​

Mesh_Quality_Manual_Check_Tet

Syntax​

MC_Mesh_Quality_Manual_Check_Tet(Cursor[] targetBody, Cursor[] targetFace,
    Cursor[] targetElements, int nElemType, int nElemQuality, int nCheckCondition,
    double dLimitValue, double dSafeFactor, 0)

Inputs​

1. Cursor[]​

Part Cursor([3:Part ID])

2. Cursor[]​

Face Cursor([6:Face ID])

3. Cursor[]​

Element Cursor([11:Element ID])

4. Int​

Elements type, default elements Tet = 2

5. Int​

Elemenets Quality: Stretch = 0, Aspect Ratio = 1, Volume = 2, Jacob = 3. Factor = 4, Tet Collapse = 5, Tet Skew = 6,Edge Length = 7, Unstable = 8,Time Step (Abaqus) = 9

6. Int​

Check condition "<=" = 0, "<" = 1, ">=" = 2, ">" = 3

7. Double​

Limit value

8. Double​

Safe factor value

Return Code​

It returns a string separated by commas contains 6 values.

1. Succeeded:1 Failed: 0​

2. Final Min Value displayed in dialog​

3. Final Max Value displayed in dialog​

4. Final AVG Value displayed in dialog​

5. Total number of entities calculated​

6. Number of failed elements within limit value​

Sample Code​

result = JPT.Exec('MC_Mesh_Quality_Manual_Check_Tet([3:1], [], [], 2, 3, 0, 0, 1, 0)')
splitted = re.split(r',\s*(?![^(\[\]]*\])', result)
if splitted[0] == '1':
    print('{} error elements'.format(splitted[5]))

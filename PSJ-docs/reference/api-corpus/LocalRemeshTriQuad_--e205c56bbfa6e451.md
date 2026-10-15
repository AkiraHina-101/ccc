# LocalRemeshTriQuad()

LocalRemeshTriQuad()

Description​

After creating the surface mesh, you can create the surface mesh again.

Syntax​

LocalRemeshTriQuad(cursor[] target_items, meshSizeParameters param, bool meshSetting,
    bool keepConnection, bool projectCAD, bool tinyFacMerge, double minWidth, double maxWidth)

Inputs​

1. Cursor[]​

Target Item Cursor([*:**],*=Items Type 3=Parts 6=Faces 5=Edges ,**=Items ID)

2. MeshSizeParameters::double​

Avg_Element_Size

3. MeshSizeParameters::double​

Max_Element_Size

4. MeshSizeParameters::double​

Min_Element_Size

5. MeshSizeParameters::double​

Reduction Factor, default=1

6. MeshSizeParameters::double​

Geometry Angle, default=pi/4 radian

7. MeshSizeParameters::double​

Geometry Min Size, default=0.001

8. MeshSizeParameters::double​

Grading Factor, default=1.25

9. MeshSizeParameters::double​

Min Stretch Value, default=0.1

`10. MeshSizeParameters::double​

Geometry Edge Deviation, default=0.1

11. MeshSizeParameters::double​

Geometry Quality Ratio, default=0.7

12. MeshSizeParameters::double​

Geometry Count Ratio, default=0.5

13. MeshSizeParameters::int​

Performance Mode 0 = Fastest, 1 = Good Quality, 2 = Best Quality

14. MeshSizeParameters::int​

Optimization Level 0 = Disable, 1 = Level1, 2 = Level2, 3= Level3, 4 = Level4, 5 = Level5

15. MeshSizeParameters::bool​

Auto Merge Edges flag true = 1, false = 0

16. MeshSizeParameters::bool​

Auto Merge Faces flag true = 1, false = 0

17. MeshSizeParameters::bool​

Output Quad Mesh flag true = 1, false = 0

18. MeshSizeParameters::bool​

Pure Quad Mesh flag true = 1, false = 0

19. MeshSizeParameters::bool​

Bad Input Model flag true = 1, false = 0

20. MeshSizeParameters::bool​

Close Gaps flag true = 1, false = 0

21. MeshSizeParameters::bool​

Local Remesh flag true = 1, false = 0

22. MeshSizeParameters::bool​

Geometry Approximation flag true = 1, false = 0

23. MeshSizeParameters::bool​

Curvature Control flag true = 1, false = 0

24. MeshSizeParameters::bool​

Delete Circle Chamfer flag true = 1, false = 0

25. MeshSizeParameters::int​

Next Entity Offset ID

26. MeshSizeParameters::int​

Next Elem Offset ID

27. MeshSizeParameters::int​

Next Node Offset ID

28. bool​

Mesh Setting flag true = 1, false = 0

29. bool​

Grading flag true = 1, false = 0

30. bool​

Keep connection flag true = 1, false = 0

31. bool​

Project CAD flag true = 1, false = 0

32. bool​

Tiny face merge flag true = 1, false = 0

33. double​

Min Face Width

34. double​

Max Face Width

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

LocalRemeshTriQuad([3:2, 6:31], {0.001, 0.01, 0.0005, 1, 0.7853981853, 0.001, 1.25,
    0.1, 0.1, 0.7, 0.5, 1, 3, 0, 0, 0, 0.5235987902, 1, 1, 0, 0, 1, 0, 0, 0, 10000004,
    12369, 1901}, 1, 1, 0, 0, 0, 0, 0, 0, 0.001)

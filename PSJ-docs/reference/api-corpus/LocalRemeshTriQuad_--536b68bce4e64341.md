# LocalRemeshTriQuad()

LocalRemeshTriQuad()

説明​

指定サーフェースのみをメッシングします。

構文​

LocalRemeshTriQuad(cursor[] target_items, meshSizeParameters param, bool meshSetting,
    bool use_setting, bool grading, bool fmesher, bool override_type, bool keepConnection, bool projectCAD, bool id_check, bool tinyFacMerge, double minWidth, double maxWidth, bool keep_remesh_edge, int grading_elem)

入力​

1. Cursor[]​

対象アイテムカーソル（[*:**],*=アイテムタイプ3=パート6=フェース5=エッジ ,**=アイテムID）

2. MeshSizeParameters::double​

Avg_Element_Size

3. MeshSizeParameters::double​

Max_Element_Size

4. MeshSizeParameters::double​

Min_Element_Size

5. MeshSizeParameters::double​

Reduction Factor、デフォルト=1

6. MeshSizeParameters::double​

Geometry Angle、デフォルト=π/4 ラジアン

7. MeshSizeParameters::double​

Geometry Min Size、デフォルト=0.001

8. MeshSizeParameters::double​

Grading Factor、デフォルト=1.25

9. MeshSizeParameters::double​

Min Stretch Value、デフォルト=0.1

10. MeshSizeParameters::double​

Geometry Edge Deviation、デフォルト=0.1

11. MeshSizeParameters::double​

Geometry Quality Ratio、デフォルト=0.7

12. MeshSizeParameters::double​

Geometry Count Ratio、デフォルト=0.5

13. MeshSizeParameters::int​

Performance Mode 0 = 最速、1 = 良質、2 = 最高品質

14. MeshSizeParameters::int​

Optimization Level 0 = 無効、1 = レベル1、2 = レベル2、3= レベル3、4 = レベル4、5 = レベル5

15. MeshSizeParameters::bool​

Auto Merge Edges flag true = 1, false = 0

16. MeshSizeParameters::bool​

Auto Merge Faces flag true = 1, false = 0

17. MeshSizeParameters::double​

Auto mesh pattern minimum elem angle.

18. MeshSizeParameters::double​

Auto merge tiny faces angle.

19. MeshSizeParameters::bool​

Output Quad Mesh flag true = 1, false = 0

20. MeshSizeParameters::bool​

Pure Quad Mesh flag true = 1, false = 0

21. MeshSizeParameters::bool​

Bad Input Model flag true = 1, false = 0

22. MeshSizeParameters::bool​

Close Gaps flag true = 1, false = 0

24. MeshSizeParameters::bool​

Local Remesh flag true = 1, false = 0

22. MeshSizeParameters::bool​

Geometry Approximation flag true = 1, false = 0

25. MeshSizeParameters::bool​

Curvature Control flag true = 1, false = 0

24. MeshSizeParameters::bool​

Delete Circle Chamfer flag true = 1, false = 0

26. MeshSizeParameters::bool​

Delete Circle Chamfer flag true = 1, false = 0

27. MeshSizeParameters::bool​

Tiny Cylinder Mesh option flag true = 1, false = 0

28. MeshSizeParameters::int​

Next Entity Offset ID

29. MeshSizeParameters::int​

Next Elem Offset ID

30. MeshSizeParameters::int​

Next Node Offset ID

31. bool​

Mesh Setting flag true = 1, false = 0

32. bool​

Grading flag true = 1, false = 0

33. bool​

Use FMesher 0=No 1=Yes

34. bool​

Override Type 0=IsoMesh 1=FreeMesh

35. bool​

Project CAD flag true = 1, false = 0

36. bool​

Keep connection flag true = 1, false = 0

37. bool​

Tiny face merge flag true = 1, false = 0

38. double​

Min Face Width

39. double​

Max Face Width

40. bool​

ID Check true = 1, false = 0

41. bool​

Keep Remesh Edge true = 1, false = 0

42. int​

The number of adjacent layers to be locally remeshed.

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

LocalRemeshTriQuad([6:26], {0.01, 0.02, 0.001, 1, 0.7853981853, 0.001, 1.25, 0.1, 0.1, 0.7, 0.5, 1, 3, 0, 0, 0, 0.5235987902, 0, 0, 0, 0, 1, 0, 0, 0, 0, 27, 1233, 513}, 1, 1, 0, 0, 1, 1, 0, 0, 0.001, 0, 0, 1)

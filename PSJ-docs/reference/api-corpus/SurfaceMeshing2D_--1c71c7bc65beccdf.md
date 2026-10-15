# SurfaceMeshing2D()

SurfaceMeshing2D()

Description​

Surface Meshing 2D

Syntax​

SurfaceMeshing2D(cursor[] body, meshParam param, bool use_local_setting, bool use_FMesher,
    int thread_num, bool keep_ref_data, bool mesh_color, COLOR color)

Inputs​

1. Cursor[]​

body List

2. MeshParam::double​

Avg_Element_Size

3. MeshParam::double​

Max_Element_Size

4. MeshParam::double​

Min_Element_Size

5. MeshParam::double​

Reduction_Factor

6. MeshParam::double​

Geom_Angle

7. MeshParam::double​

Geom_MinSize

8. MeshParam::double​

Grading_Factor

9. MeshParam::double​

Min_Stretch_Val

10. MeshParam::double​

Geom_Edge_Deviation

11. MeshParam::double​

Geom_Quality_Ratio

12. MeshParam::double​

Geom_Count_Ratio

13. MeshParam::int​

Performance_Mode 0=Fastest,1=Good Quality,2=Best Quality

14. MeshParam::int​

Optimization_Level 0=Disable,1=Level1,2=Level2,3=Level3,4=Level4,5=Level5

15. MeshParam::bool​

Auto_Merge_Edges 0=No 1=Yes

16. MeshParam::bool​

Auto_Merge_Faces 0=No 1=Yes

17. MeshParam::double​

Auto_MeshPattern_MinElemAngle

18. MeshParam::double​

Auto_MergeTinyFaces_Angle

19. MeshParam::bool​

Output_Quad_Mesh 0=No 1=Yes

20. MeshParam::bool​

Pure_Quad_Mesh 0=No 1=Yes

21. MeshParam::bool​

Bad_Input_Model 0=No 1=Yes

22. MeshParam::bool​

Close_Gaps 0=No 1=Yes

23. MeshParam::bool​

Local_Remesh 0=No 1=Yes

24. MeshParam::bool​

Geom_Approximation 0=No 1=Yes

25. MeshParam::bool​

Curvature_Control 0=No 1=Yes

26. MeshParam::bool​

Delete_CircChamfer 0=No 1=Yes

27. MeshParam::int​

Next_Entity_Offset_Id

28. MeshParam::int​

Next_Elem_Offset_Id

29. MeshParam::int​

Next_Node_Offset_Id

30. bool​

Use Local Settings 0=No 1=Yes

31. bool​

Use FMesher 0=No 1=Yes

32. int​

Thread Number

33. bool​

Keep Reference Data 0=No 1=Yes

34. bool​

Use mesh color 0=No 1=Yes

35. COLOR​

Mesh Color

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

SurfaceMeshing2D([3:1], {0.005, 0.01, 0.001, 1, 0.785398, 0.001, 1.25, 0.1, 0.1, 0.7, 0.5,
    1, 3, 0, 0, 0, 0.523599, 0, 0, 0, 0, 0, 0, 0, 0, 10000000, 0, 0}, 1, 0, 4, 1, 0, 65280)

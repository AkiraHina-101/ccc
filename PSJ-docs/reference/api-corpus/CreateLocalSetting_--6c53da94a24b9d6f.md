# CreateLocalSetting()

CreateLocalSetting()

Description​

Create Local Settings

Syntax​

CreateLocalSetting(string name, MeshLocalParam param, cursor[] target, int[] hard_point_id,
    point[] hard_Point_xyz, cursor[] hard_point_target, cursor edit_target)

Inputs​

1. String​

Node List

2. MeshLocalParam::int​

Entity Type 0=NONE,1=BODY,2=FACE,3=EDGE,8=FACE_POINT,9=EDGE_POINT

3. MeshLocalParam::bool​

Enable Size Param 0=No 1=Yes

4. MeshLocalParam::double​

Avg_Element_Size

5. MeshLocalParam::double​

Max_Element_Size

6. MeshLocalParam::double​

Min_Element_Size

7. MeshLocalParam::bool​

Enable Trim Angle 0=No 1=Yes

8. MeshLocalParam::double​

Trim Angle

9. MeshLocalParam::bool​

Enable Mesh Count 0=No 1=Yes

10. MeshLocalParam::int​

Node Count

11. MeshLocalParam::int​

Bias Node Id

12. MeshLocalParam::double​

Bias Factor

13. MeshLocalParam::int​

Bias Method 0=LINEAR,1=BIAS,2=BIAS_CENTER,3=BIAS_SIDE

14. MeshLocalParam::int​

Bias Progression 0=GEOMETRY,1=ARITHMETIC

15. MeshLocalParam::bool​

Enable Mesh Pattern 0=No 1=Yes

16. MeshLocalParam::int​

Mesh Pattern Type 0=UNSTRUCTURED,1=STRUCTURED_ISO,2=IMPRINTING_ISO

17. MeshLocalParam::bool​

Enable Keep Entity 0=No 1=Yes

18. MeshLocalParam::double​

Hard Point X

19. MeshLocalParam::double​

Hard Point Y

20. MeshLocalParam::double​

Hard Point Z

21. MeshLocalParam::int​

Hard Point Id

22. MeshLocalParam::bool​

Enable Freeze Mesh 0=No 1=Yes

23. Cursor[]​

Target List(Body/Face/Edge)

24. int[]​

Hard Point Id list

25. Point[]​

Hard Point XYZ list

26. Cursor[]​

Hard Point Target list

27. Cursor​

Edit Target

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

CreateLocalSetting("MeshParam_1", {2, 1, 0.005, 0.01, 0.001, 0, 0, 0, 0, 0,
    0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0}, [6:8], [], [], [], 0:0)

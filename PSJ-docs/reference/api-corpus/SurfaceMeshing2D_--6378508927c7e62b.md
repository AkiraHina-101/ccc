# SurfaceMeshing2D()

SurfaceMeshing2D()

説明​

サーフェースメッシング

構文​

SurfaceMeshing2D(cursor[] body, meshParam param, bool use_local_setting, bool use_FMesher,
    int thread_num, bool keep_ref_data, bool mesh_color, COLOR color, bool reserved)

入力​

1. Cursor[]​

パートリスト

2. MeshParam::double​

平均要素サイズ

3. MeshParam::double​

最大要素サイズ

4. MeshParam::double​

最小要素サイズ

5. MeshParam::double​

減少係数

6. MeshParam::double​

Geom_Angle

7. MeshParam::double​

Geom_MinSize

8. MeshParam::double​

グラデーション係数

9. MeshParam::double​

メッシュストレッチ

10. MeshParam::double​

Geom_Edge_Deviation

11. MeshParam::double​

Geom_Quality_Ratio

12. MeshParam::double​

Geom_Count_Ratio

13. MeshParam::int​

速度対品質 0=最速,1=高品質,2=最高品質

14. MeshParam::int​

最適化 0=無効,1=レベル1,2=レベル2,3=レベル3,4=レベル4,5=レベル5

15. MeshParam::bool​

エッジをマージ 0=いいえ 1=はい

16. MeshParam::bool​

フェースをマージ 0=いいえ 1=はい

17. MeshParam::double​

マップドメッシュ最小角度

18. MeshParam::double​

Auto_MergeTinyFaces_Angle

19. MeshParam::bool​

Output_Quad_Mesh 0=いいえ 1=はい

20. MeshParam::bool​

純Quadメッシュ 0=いいえ 1=はい

21. MeshParam::bool​

不正なCADモデル 0=いいえ 1=はい

22. MeshParam::bool​

穴を閉じる 0=いいえ 1=はい

23. MeshParam::bool​

Local_Remesh 0=いいえ 1=はい

24. MeshParam::bool​

Geom_Approximation 0=いいえ 1=はい

25. MeshParam::bool​

曲率コントロール 0=いいえ 1=はい

26. MeshParam::bool​

チャンファー面を削除 0=いいえ 1=はい

27. MeshParam::bool​

微小円筒面メッシングオプション

28. MeshParam::int​

Next_Entity_Offset_Id

29. MeshParam::int​

Next_Elem_Offset_Id

30. MeshParam::int​

Next_Node_Offset_Id

31. bool​

Use Local Settings 0=いいえ 1=はい

32. bool​

Use FMesher 0=いいえ 1=はい

33. int​

複数CPUメッシュ

34. bool​

Keep Reference Data 0=いいえ 1=はい

35. bool​

Use mesh color 0=いいえ 1=はい

36. COLOR​

Mesh Color

37. bool​

現在は使用されていません.

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SurfaceMeshing2D([3:1], {0.005, 0.01, 0.001, 1, 0.785398, 0.001, 1.25, 0.1, 0.1, 0.7, 0.5,
    1, 3, 0, 0, 0, 0.523599, 0, 0, 0, 0, 0, 0, 0, 0, 10000000, 0, 0}, 1, 0, 4, 1, 0, 65280)

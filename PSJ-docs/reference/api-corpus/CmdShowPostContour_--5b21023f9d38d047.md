# CmdShowPostContour()

CmdShowPostContour()

説明​

輪郭を表示します

構文​

CmdShowPostContour(Cursor crPostJob,
	PostResultKey& resKey, PostDataOp& opOut,
	bool hasResult2, PostResultKey resKey2, PostDataOp opOut2,
	bool hasResult3, PostResultKey resKey3, PostDataOp opOut3,
	bool enableMidNode, bool bApplyAll)

入力​

1. Cursor​

ポスト ジョブのカーソル。

2. PostResultKey::int​

解析タイプ。

3. PostResultKey::int​

解析 ID。

4. PostResultKey::int​

結果セット

5. PostResultKey::int​

タイム ステップ

6. PostResultKey::string ​

結果の名前

7. PostResultKey::string ​

コンポーネントの名前

8. PostResultKey::int  ​

結果の位置

9. PostDataOp::int  ​

表示位置

10. PostDataOp::int  ​

座標

11. PostDataOp::int  ​

1D データ

12. PostDataOp::int  ​

2D データ

13. PostDataOp::int  ​

変換

14. PostDataOp::int  ​

接続の表示

15. PostDataOp::int  ​

複雑さ

16. PostDataOp::double  ​

位相角

17. PostDataOp::int  ​

座標の ID

18. bool  ​

2 番目の結果を使用するかどうか。

19. PostResultKey::int​

2 番目の結果の解析タイプ。

20. PostResultKey::int​

2 番目の結果の結果セット。

21. PostResultKey::int​

2 番目の結果の時間ステップ。

22. PostResultKey::string ​

2 番目の結果の名前

23. PostResultKey::string ​

2 番目の結果のコンポーネントの名前

24. PostResultKey::int  ​

2 番目の結果の位置。

25. PostDataOp::int  ​

2 番目の結果の表示。

26. PostDataOp::int  ​

2 番目の結果の座標のタイプ。

27. PostDataOp::int  ​

2 番目の結果の 1D データ。

28. PostDataOp::int  ​

2 番目の結果の 2D データ。

29. PostDataOp::int  ​

2 番目の結果の変換。

30. PostDataOp::int  ​

2 番目の結果の接続の表示。

31. PostDataOp::int  ​

2 番目の結果の複雑さ。

32. PostDataOp::double  ​

2 番目の結果の位相角。

33. PostDataOp::int  ​

2 番目の結果の座標の ID。

34. bool​

3 番目の結果を使用するかどうか。

35. PostResultKey::int​

3 番目の結果の解析タイプ。

36. PostResultKey::int​

3 番目の結果の結果セット。

37. PostResultKey::int​

3 番目の結果の時間ステップ。

38. PostResultKey::string ​

3 番目の結果の名前

39. PostResultKey::string ​

3 番目の結果のコンポーネントの名前

40. PostResultKey::int  ​

3 番目の結果の位置。

41. PostDataOp::int  ​

3 番目の結果の表示。

42. PostDataOp::int  ​

3 番目の結果の座標の種類。

43. PostDataOp::int  ​

3 番目の結果の 1D データ。

44. PostDataOp::int  ​

3 番目の結果の 2D データ。

45. PostDataOp::int  ​

3 番目の結果の変換。

46. PostDataOp::int  ​

3 番目の結果の接続の表示。

47. PostDataOp::int  ​

3 番目の結果の複雑さ。

48. PostDataOp::double  ​

3 番目の結果の位相角。

49. PostDataOp::int  ​

3 番目の結果の座標の ID。

50. bool  ​

MidNode の使用の有効化。

51. bool  ​

すべてのドキュメントに適用の有効化。

戻り値​

なし。

サンプル コード​

CmdShowPostContour(183:1, {2, 0, 1, 1, Displacement, Translational, 1}, {1, 1, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)

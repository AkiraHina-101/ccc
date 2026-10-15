# CloseHoles()

CloseHoles()

説明​

穴を埋める

構文​

CloseHoles(Cursor[] edge_list, double area_min, double area_max, bool merge_faces, bool merge_edges)

入力​

1. Cursor[]​

エッジリスト

2. Double​

最小面積

3. Double​

最大面積

4. Bool​

フェースをマージ。True=1、False=0

5. Bool​

エッジをマージ。True=1、False=0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CloseHoles([5:31, 5:35, 5:39, 5:45], 0, 0.54321, 0, 0)

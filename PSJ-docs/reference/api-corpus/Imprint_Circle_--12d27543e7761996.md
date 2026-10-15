# Imprint_Circle()

Imprint_Circle()

説明​

インプリントサークルラインを作成します

構文​

Imprint_Circle(double[] Point_xyz,int[] Face_ID,double Inner_Radius,double Outer_Radius,
    int No_of_Layers,int No_of_Divisions,bool BreakFace,Cursor[] bodyCursor)

入力​

1. Double[]​

ポイントxyz [[x1,y1,z1]]

2. Int[]​

フェースID配列

3. Double​

内半径

4. Double​

外半径

5. Int​

レイヤー数

6. Int​

分割数

7. Bool​

フラグ true = 1,false=0

8. Cursor[]​

パートカーソル([3:*]*= パートID)

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Imprint_Circle([[0.00555556, 0.00444444, 0.01]], [26], 0.001, 0.002, 1, 30, 1, [3:1])

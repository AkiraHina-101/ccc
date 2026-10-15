# MeasureAngleBy2Axis()

MeasureAngleBy2Axis()

説明​

2つの軸によって作成される角度を測定します。

構文​

MeasureAngleBy2Axis(Axis xyz1,Axis xyz2,String Target,Integer N)

入力​

1. Axis​

単位ベクトル([x,y,z])

2. Axis​

単位ベクトル([x,y,z])

3. String​

対象（角度またはXYまたはYZまたはZXまたはALL）

4. Integer N​

小数点以下の桁数を指定します（0<=N<=30）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MeasureAngleBy2Axis([0,0,1],[1,1,1],"ALL",6)

あるいは

MeasureAngleBy2Axis([0,0,1],[1,1,1],"Angle",6)

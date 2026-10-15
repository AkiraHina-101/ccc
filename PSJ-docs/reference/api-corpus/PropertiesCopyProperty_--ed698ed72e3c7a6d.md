# PropertiesCopyProperty()

PropertiesCopyProperty()

説明​

プロパティのコピー

構文​

PropertiesCopyProperty(String strPathSource,String strPathTarget,int[] keyTarget,int axis,
    Cursor crCoord,Vector transVec,double dMag,double dOffset,double dTol)

入力​

1. String​

ソースファイルのパス

2. String​

ターゲットファイルのパス

3. int[]​

コピーする必要のあるプロパティキー

4. int​

軸 [0:任意の軸; 1:X軸; 2:Y軸; 3:Z軸; 4:2節点; 5:エッジ]

5. Cursor​

座標系

6. Vector​

変換ベクトル

7. double​

マグニチュード

8. double​

オフセット

9. double​

許容差

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

PropertiesCopyProperty("D:/Source","D:/Target",[1,2],1,1:11,,0.001,0.001,0.001)

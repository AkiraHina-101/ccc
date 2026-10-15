# CentrifugalForceCoordinateSystem()

CentrifugalForceCoordinateSystem()

説明​

座標系による遠心力を作成します

構文​

CentrifugalForceCoordinateSystem(String m_strName,double fVelocity,double fAcceleration,
    int iAxisDirection,int iVelocityUnit,int iAccelerationUnit,Cursor curCoord,
    Cursor[] m_taTarget,Cursor m_crEdit)

入力​

1. String​

遠心力の名前

2. Double​

回転速度

3. Double​

回転加速度

4. Int​

軸[0:X; 1:Y; 2:Z]

5. Int​

速度の単位

6. Int​

加速度の単位

7. Cursor​

座標系

8. Cursor[]​

ターゲット

9. Cursor​

編集カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CentrifugalForceCoordinateSystem("Test",0.001,0.001,1,1,1,1:11,[1:11,2:12],1:11)

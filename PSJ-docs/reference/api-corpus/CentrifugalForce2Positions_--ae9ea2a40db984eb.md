# CentrifugalForce2Positions()

CentrifugalForce2Positions()

説明​

2つの位置によって遠心力を作成します

構文​

CentrifugalForce2Positions(String m_strName,double fBasePoint[0],double fBasePoint[1],
    double fBasePoint[2],double fTipPoint[0],double fTipPoint[1],double fTipPoint[2],
    double fVelocity,double fAcceleration,int iVelocityUnit,int iAccelerationUnit,
    cursor[] m_taTarget,cursor m_crEdit)

入力​

1. String​

遠心力の名前

2. Double​

基準点 x

3. Double​

基準点 y

4. Double​

基準点 z

5. Double​

先端点 x

6. Double​

先端点 y

7. Double​

先端点 z

8. Double​

回転速度

9. Double​

回転加速度

10. Int​

速度の単位

11. Int​

加速度の単位

12. Cursor[]​

対象

13. Cursor​

編集カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CentrifugalForce2Positions("CentrifugalForce1", 0.01, 0.0022222, 0.01, 0.01,
    0.0044444, 0.01, 0.174533, 0.0872665, 0, 0, [3:1, 10:82, 10:84], 0:0)

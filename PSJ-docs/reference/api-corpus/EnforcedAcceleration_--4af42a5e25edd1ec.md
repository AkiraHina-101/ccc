# EnforcedAcceleration()

EnforcedAcceleration()

説明​

強制加速度を作成します

構文​

EnforcedAcceleration(String m_strName,int dwDof,double fVel[0],double fVel[1],double fVel[2],
    double fVel[3],double fVel[4],double fVel[5],Cursor curCoord,int enArrowDir,Cursor crTable,
    Cursor crNodeSet,double m_fPhase,double m_fDelay,Cursor crPhaseTable,BOOL bExport,
    Cursor crMEExport[0],Cursor crMEExport[1],Cursor crMEExport[2],Cursor crMEExport[3],
    Cursor crMEExport[4],Cursor crMEExport[5],int iAcUnit,int iRotUnit,Cursor[] m_taTarget,Cursor m_crEdit)

入力​

1. String​

強制加速度の名前

2. Int​

dof

3. Double​

x 軸方向の移動

4. Double​

y 軸方向の移動

5. Double​

z 軸方向の移動

6. Double​

x 軸方向の回転

7. Double​

y 軸方向の回転

8. Double​

z 軸方向の回転

9. Cursor​

座標系

10. Int​

矢印の方向[0:節点から始まる; 1:節点に到達する]

11. Cursor​

選択テーブル

12. Cursor​

節点セットテーブル

13. Double​

位相

14. Double​

遅延

15. Cursor​

位相テーブル

16. Bool​

定義された場合はエクスポート

17. Cursor​

x 軸方向の移動

18. Cursor​

y 軸方向の移動

19. Cursor​

z 軸方向の移動

20. Cursor​

x 軸方向の回転

21. Cursor​

y 軸方向の回転

22. Cursor​

z 軸方向の回転

23. Int​

加速度の単位

24. Int​

回転の単位

25. Cursor[]​

対象

26. Cursor​

編集カーソル

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

EnforcedAcceleration("EnforcedAcceleration1", 63, 0.001, 0.002, 0.003, 3, 2, 1,0:0, 0, 0:0,
    0:0, 1.79769e+308, 1.79769e+308, 0:0, 0, 0:0, 0:0, 0:0, 0:0, 0:0, 0:0, 0, 0, [6:26], 0:0)

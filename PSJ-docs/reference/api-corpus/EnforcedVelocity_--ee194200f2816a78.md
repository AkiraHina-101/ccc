# EnforcedVelocity()

EnforcedVelocity()

説明​

強制速度を作成します

構文​

強制速度(String m_strName,int dwDof,double fVel[0],double fVel[1],double fVel[2],
    double fVel[3],double fVel[4],double fVel[5],Cursor curCoord,int enArrowDir,
    Cursor crTable,Cursor crNodeSet,double m_fPhase,double m_fDelay,Cursor crPhaseTable,
    int m_iVelUnit,int m_iRotUnit,bool bExport,Cursor iExportData[0],Cursor iExportData[1],
    Cursor iExportData[2],Cursor iExportData[3],Cursor iExportData[4],Cursor iExportData[5],
    Cursor[] m_taTarget,Cursor m_crEdit,bool m_bIfCreate2ADVCStaticProcessForBoltFixLength)

入力​

1. String​

強制速度の名前

2. Int​

dof

3. Double​

x方向の移動

4. Double​

y方向の移動

5. Double​

z方向の移動

6. Double​

x軸の回転

7. Double​

y軸の回転

8. Double​

z軸の回転

9. Cursor​

座標系

10. Int​

矢印の向き[0:節点で開始; 1:節点で終了]

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

16. Int​

速度の単位

17. Int​

回転の単位

18. Bool​

エクスポートが定義されているかどうか

19. Cursor​

x方向の移動

20. Cursor​

y方向の移動

21. Cursor​

z方向の移動

22. Cursor​

x軸の回転

23. Cursor​

y軸の回転

24. Cursor​

z軸の回転

25. Cursor[]​

対象

26. Cursor​

編集カーソル

27. Bool​

ボルトの固定長に対する2つのADVCスタティックプロセスを作成する場合

戻り値​

"1": 関数が実行可能です

"0": 関数を実行できません

サンプルコード​

EnforcedVelocity("EnforcedVelocity1", 63, 0.001, 0.002, 0.003, 1, 2, 3, 0:0, 0,0:0, 0:0,
    1.79769e+308, 1.79769e+308, 0:0, 0, 0, 0, 0:0, 0:0, 0:0, 0:0, 0:0, 0:0, [6:26], 0:0, 0)

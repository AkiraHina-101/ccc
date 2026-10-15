# Lbc_Bolt_Modeling_Type_C_Edge()

Lbc_Bolt_Modeling_Type_C_Edge()

説明​

Lbc TypeC ボルト エッジ メソッドを作成します。

構文​

Lbc_Bolt_Modeling_Type_C_Edge(Cursor taEdgeCur1,Cursor taEdgeCur2,string strRbeName,
    double dPlaneTol,double dMaxBoltHeight,int nConnectionType, int nCoincidentNodes,
    double dTolerance, int nGround,double dStiffnessX,double dStiffnessY,double dStiffnessZ,
    int nLocalStiffUnit,double dRotateStiffX,double dRotateStiffY,double dRotateStiffZ,
    int nLocalRotateStiffUnit, double dDampCoef, double dStressCoef,Cursor curCoord,
    int nTopRbeType,double dTopPitch,double dTopRemoveDepth,int nBotRbeType,double dBotPitch,
    double dBotRemoveDepth)

入力​

1. Cursor[]​

上側に円形エッジを持つフェース

2. Cursor[]​

下側に円形エッジを持つフェース

3. String​

RBE の名前

4. Double​

選択されたエッジ周囲の平面許容角度

5. Double​

上部と下部 RBE の最大距離

6. Int​

接続タイプ、0 = スプリング、1 = Rbe2

7. Int​

一致節点

8. Double​

許容誤差

9. Int​

グラウンド

10. Double​

剛性 X 値

11. Double​

剛性 Y 値

12. Double​

剛性 Z 値

13. Int​

ローカル剛性ユニット

14. Double​

回転剛性 X 値

15. Double​

回転剛性 Y 値

16. Double​

回転剛性 Z 値

17. Int​

ローカル回転剛性ユニット

18. Double​

減衰係数

19. Double​

応力係数

20. Cursor​

参照座標系、NULL はグローバル

21. Int​

上部 Rbe のタイプ、0=RBE3、1=Rbe2

22. Double​

上部ボルト穴 RBE 範囲

23. Double​

この範囲内の上部スレーブ節点は考慮されません

24. Int​

下部 Rbe のタイプ、0=RBE3、1=Rbe2

25. Double​

下部ボルト穴 RBE 範囲

26. Double​

この範囲内の下部スレーブ節点は考慮されません

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプル コード​

Lbc_Bolt_Modeling_Type_C_Edge([5:66319], [5:10000031], "RBE", 20, 0.1, 0, 1, 2.22507e-308,
    0, 1.79769e+308, 1.79769e+308, 1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    0, 1.79769e+308, 1.79769e+308, 0:0, 0, 0.01, 0, 0, 0.01, 0)

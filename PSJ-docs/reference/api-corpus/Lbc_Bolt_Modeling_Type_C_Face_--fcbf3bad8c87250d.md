# Lbc_Bolt_Modeling_Type_C_Face()

Lbc_Bolt_Modeling_Type_C_Face()

説明​

Lbc TypeC ボルトフェースを作成するメソッド()

構文​

Lbc_Bolt_Modeling_Type_C_Face(Cursor taFaceCur1,Cursor taFaceCur2,string strRbeName,
    double dPlaneTol,double dMaxBoltHeight,double dMaxDiameter,double dMinDiameter,
    int nConnectionType,int nCoincidentNodes, double dTolerance, int nGround,double dStiffnessX,
    double dStiffnessY,double dStiffnessZ, int nLocalStiffUnit, double dRotateStiffX,
    double dRotateStiffY,double dRotateStiffZ, int nLocalRotateStiffUnit, double dDampCoef,
    double dStressCoef,Cursor curCoord,int nTopRbeType,double dTopPitch,double dTopRemoveDepth,
    int nBotRbeType,double dBotPitch,double dBotRemoveDepth)

入力​

1. Cursor[]​

上側の円形エッジ

2. Cursor[]​

下側の円形エッジ

3. String​

Rbeの名前

4. Double​

選択したエッジの周囲の平面許容角

5. Double​

上下のRbe間の最大距離

6. Double​

上下のRbe間の最大距離

7. Double​

ボルト穴の最大直径範囲

8. Int​

接続タイプ, 0=Spring, 1=Rbe2

9. Int​

一致節点

10. Double​

許容差

11. Int​

グラウンド

12. Double​

剛性 X 値

13. Double​

剛性 Y 値

14. Double​

剛性 Z 値

15. Int​

16. Double​

回転剛性 X 値

17. Double​

回転剛性 Y 値

18. Double​

回転剛性 Z 値

19. Int​

ローカル回転剛性ユニット

20. Double​

減衰係数

21. Double​

応力係数

22. Cursor​

参照する座標系、NULL はグローバル

23. Int​

上部 Rbe タイプ, 0=RBE3, 1=Rbe2

24. Double​

上部ボルト穴 rbe 範囲

25. Double​

この範囲内の上部スレーブ節点は考慮されません

26. Int​

下部 Rbe タイプ, 0=RBE3, 1=Rbe2

27. Double​

下部ボルト穴 rbe 範囲

28. Double​

この範囲内の下部スレーブ節点は考慮されません

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Lbc_Bolt_Modeling_Type_C_Face([6:60], [6:49], "RBE", 20.0002, 0.1, 0.1, 0.001,
    0, 1, 2.22507e-308, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, 0, 1.79769e+308,
    1.79769e+308, 1.79769e+308, 0, 1.79769e+308, 1.79769e+308, 0:0, 0, 0.01, 0, 0, 0.01, 0)

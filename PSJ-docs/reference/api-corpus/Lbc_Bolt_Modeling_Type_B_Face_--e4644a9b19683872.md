# Lbc_Bolt_Modeling_Type_B_Face()

Lbc_Bolt_Modeling_Type_B_Face()

説明​

Lbc TypeB のボルトフェースメソッドを作成します

構文​

Lbc_Bolt_Modeling_Type_B_Face(Cursor taFaceCur1,Cursor taFaceCur2,string strRbeName,
    string strBarName,int nShaftType,Cursor curBarProperty,double dPlaneTol,
    double dMaxBoltHeight,double dMaxDiameter,double dMinDiameter,bool bPretensionLoad,
    int nSolverType,double dForceValue,int nPreTenDof,Cursor curCoord,
    int nBoltFixLength,int nTopSlot,double dRBE1,double dRBE2,double dBotDtDia,
    double dPitch,int nBotRbeConnType,double dScale1, bool IsCreate2ADVCStaticProcessForFixLength)

入力​

1. Cursor[]​

上部に円形エッジを持つ面

2. Cursor[]​

下部に円形エッジを持つ面

3. String​

RBE の名前

4. String​

BarBody の名前

5. Int​

接続タイプ、0: cbar, 1: rbe2

6. Cursor​

バーのプロパティ・カーソル

7. Double​

選択されたエッジ周りの平面許容角度。選択されたエッジ周りのスレーブ節点を見つける際に使用します

8. Double​

上部と下部の RBE 間の最大距離

9. Double​

ボルト穴の最大直径範囲

10. Double​

ボルト穴の最小直径範囲

11. Bool​

プリテンション荷重フラグ、0=なし、1=あり

12. Int​

プリテンションソルバーの種類、0=オプション選択、1=Abaqus プリテンション

13. Double​

荷重値。プリテンション接続に使用

14. Int​

対象のプリテンション DoF

15. Cursor​

参照する座標系、NULL はグローバル

16. Int​

プリテンションで使用されるボルト固定長

17. Int​

上部スロットボルトフラグ、0=なし、1=あり

18. Double​

上部 RBE スレーブ節点直径範囲

19. Double​

常にゼロ。ここでは考慮する必要はありません

20. Double​

下部のボルト穴の直径。デフォルトではゼロで動作します。ユーザーは値を指定できます。

21. Double​

下部 RBE ピッチ距離

22. Int​

下部 RBE 接続タイプ、0=down、1=up、2=center

23. Double​

表示範囲のスケール値、プレビューで使用

24. Bool​

オプション ADVC 静的プロセス、0: いいえ、1: はい

戻り値​

"1": 関数が実行可能

"0": 関数が実行不可

サンプルコード​

Lbc_Bolt_Modeling_Type_B_Face([6:60], [6:49], "RBE", "Bar_1", 0, 0:0, 20.0002, 0.1, 0.1,
    0.001, 0, 0, 0, 0, 0:0, 0, 1, 0.06, 0, 0, 0.01, 0, 3, 0)

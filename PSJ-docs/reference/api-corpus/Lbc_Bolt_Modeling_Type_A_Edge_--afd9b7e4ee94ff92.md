# Lbc_Bolt_Modeling_Type_A_Edge()

Lbc_Bolt_Modeling_Type_A_Edge()

説明​

Lbc TypeA ボルト エッジ メソッドの作成

構文​

Lbc_Bolt_Modeling_Type_A_Edge(Cursor taEdgeCur1, TCursor taEdgeCur2, string strRbeName,
    string strBarName, int nShaftType, Cursor curBarProperty, double dPlaneTol,
    double dMaxBoltHeight, bool bPretensionLoad, int nSolverType, double dForceValue,
    int nPreTenDof, Cursor curCoord, int nBoltFixLength, int nTopSlot, double dRBE1,
    int nBotSlot, double dRBE2, bool IsCreate2ADVCStaticProcessForFixLength)

入力​

1. Cursor[]​

上部の円形エッジ

2. Cursor[]​

下部の円形エッジ

3. String​

Rbeの名前

4. String​

BarBodyの名前

5. Int​

接続タイプ、0: cbar、1: rbe2

6. Cursor​

バーの特性のカーソル

7. Double​

選択されたエッジ周囲の平面許容角度。選択されたエッジ周囲のスレーブ 節点を見つける際に使用します

8. Double​

上部と下部の RBE 間の最大距離

9. Bool​

プリテンション ロード フラグ、0=オフ、1=オン

10. Int​

プリテンション ソルバーのタイプ、0=全オプションプリテンション、1=Abaqus プリテンション

11. Double​

フォース値。プリテンション接続で使用

12. Int​

ターゲットのプリテンション DoF

13. Cursor​

参照座標系、NULL の場合はグローバル

14. Int​

プリテンションで使用されるボルト固定長

15. Int​

上側スロット ボルト フラグ、0=オフ、1=オン

16. Double​

上部 RBE スレーブ 節点の直径範囲

17. Int​

下側スロット ボルト フラグ、0=オフ、1=オン

18. Double​

下部 RBE スレーブ 節点の直径範囲

19. Bool​

オプション ADVC 静的プロセス、0: いいえ、1: はい

戻り値​

"1": 関数は実行可能です

"0": 関数は実行不可です

サンプル コード​

Lbc_Bolt_Modeling_Type_A_Edge([5:66319], [5:10000031], "RBE", "Bar_2", 0, 0:0, 20,
    0.1, 0, 0, 0, 0, 0:0, 0, 0, 0.0081206, 0, 0.0081206, 0)

# ContactMSCNastran()

ContactMSCNastran()

説明​

Nastranの接触を作成します。

構文​

ContactMSCNastran(String m_strName,int iType,int iAlg,double dRROR,double dFNTOL,
    double dFRIC,double dCINTERF,int iISEARCH,int iICOORD,double dFRLIM,double dBIAS,
    int iISTYP,int faceSlave, int faceMaster, int slaveEdge,int masterEdge,
    Cursor[] m_taTarget,Cursor m_crEdit,int m_Color,int m_iMethod)

入力​

1. String​

接触の名前

2. Int​

接触タイプ[0:一般; 1:結合; 2:結合およびギャップを維持; 3:結合および全モーメント; 4:結合および全モーメントおよびギャップを維持]

3. Int​

アルゴリズム[0:フェース間]

4. Double​

接触距離範囲

5. Double​

分離力

6. Double​

摩擦係数

7. Double​

干渉クロージャ

8. Int​

探索順序[0:ダブル; 1:Slave to Master; 2:プログラム決定]

9. Int​

座標修正[0:なし; 1:位置変更; 2:スライディング遅延; 3:両方の効果]

10. Double​

摩擦応力限界

11. Double​

許容バイアスファクタ

12. Int​

条件チェック[0:両側; 1:最適化]

13. Int​

シェル要素フェースのスレーブ[1:上下厚さオフセット; 2:下部厚さオフセットあり; 3:下部厚さオフセットなし; 4:上部厚さオフセットあり; 5:上部厚さオフセットなし; 6:上下厚さオフセットなし]

14. Int​

シェル要素フェースのマスター[1:上下厚さオフセット; 2:下部厚さオフセットあり; 3:下部厚さオフセットなし; 4:上部厚さオフセットあり; 5:上部厚さオフセットなし; 6:上下厚さオフセットなし]

15. Int​

ビーム/バー シェル要素エッジ スレーブ[1:ビーム/バーエッジのみ; 10:フリー＆ハードエッジのみ; 11:両方]

16. Int​

ビーム/バー シェル要素エッジ マスター[1:ビーム/バーエッジのみ; 10:フリー＆ハードエッジのみ; 11:両方]

17. Cursor[]​

ターゲット

18. Cursor​

編集カーソル

19. Int​

接触メーカーの色

20. Int​

メソッドタイプ[0:MANUAL_FACE; 1:MANUAL_GROUP; 2:BY_GROUP_MATRIX; 3:SHARE_FACE; 4:AUTO_SETTING; 5:METHOD_UNKNOWN]

戻り値​

"1": 関数は実行できます

"0": 関数は実行できません

サンプルコード​

ContactMSCNastran("ContactMSCNastran_1", 0, 0, 0.0005, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 2147483647, 2147483647, 1.79769e+308, 1.79769e+308, 2147483647,
    0, 0, 0, 0, [79:1-79:2], 0:0, 16711680, 1)

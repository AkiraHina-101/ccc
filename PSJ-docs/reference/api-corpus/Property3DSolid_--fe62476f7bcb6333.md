# Property3DSolid()

Property3DSolid()

説明​

3Dソリッドのプロパティを作成します

構文​

Property3DSolid(string 名前, int ID, color プロパティの色, Cursor 素材, int CordM, int iN, int OutLoc,
    int ISOP, int iFLflag, int ModifiedElem, int ModifiedElemADVC, bool HasDynaRemesh,
    double DynaRemeshValMin, double DynaRemeshValMax, int HGType, int DispHG,
    Cursor[] ターゲット, Cursor クレジット, int FLG)

入力​

1. string​

名前 3Dソリッドのプロパティ

2. Int​

ID

3. Color​

プロパティの色

4. Cursor​

素材

5. Int​

素材座標 [0:空白; 1:要素CS; 2:グローバル]

6. Int​

積分ネットワーク [0:空白; 1:TWO; 2:THREE; 3:BUBBLE]

7. Int​

出力場所 [0:空白; 1:GAUSS; 2:GRID]

8. Int​

積分スキーマ[0:空白; 1:REDUCED; 2:FULL]

9. Int​

流体要素フラグ[0:空白; 1:PFLUID; 2:SMECH]

10. Int​

Modified Elem = 1, ABAQUS のHybrid/Incompatible/Modified/Reduced Integration/Coupled Temp-Disp/Acousticがtrueの場合

11. Int​

Modified Elem ADVC = 1, ADVC においてIncompatible/Modified/Reduced Integration;Selective Reduced Integrationがtrueの場合

12. Bool​

Dyna Remeshフラグ true = 1, false = 0

13. Double​

リメッシュ [最小エッジ長]

14. Double​

リメッシュ [最大エッジ長]

15. Int​

ハウガラスタイプ [デフォルト使用;強化;剛性]

16. double​

変位ハウガラス

17. Cursor[]​

ターゲットリスト

18. Cursor​

1Dビームを編集

19. Int​

FLG

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Property3DSolid("Solid Property 1", 1, 16131973, 22:1, -2, 0, 0, 0, 0, 0, 0, 0,
    1.79769e+308, 1.79769e+308, 0, 1.79769e+308, [3:1], 0:0, -1)

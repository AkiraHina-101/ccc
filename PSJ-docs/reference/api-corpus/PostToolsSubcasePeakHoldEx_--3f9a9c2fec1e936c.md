# PostToolsSubcasePeakHoldEx()

PostToolsSubcasePeakHoldEx()

説明​

サブケース - ピークホールド。

構文​

PostToolsSubcasePeakHoldEx(int analysisType, bool Fatigue, float Qb, float Qw, float Qy, string SubcaseName, int SubcaseID, map[] SubcaseMap)

入力​

1. int ​

解析タイプ。

2. bool ​

疲労パラメーターフラグ。

3. float ​

Qy

4. float ​

Qb

5. float ​

Qw

6. string ​

名前

7. int​

ID

8. map[] ​

ソース結果。

マップの内容は次のとおりです：

int - 結果セット,

サブケースアイテム。
2-1. int - ID
2-1. string - 名前,
2-2. int - ステータス,
2-4. bool - 有効 / 無効.

戻り値​

なし。

サンプルコード​

PostToolsSubcasePeakHoldEx(1, 0, 270, 130, 165, "サブケース 101 ピークホールド", 101, [(0, [(0, "Step=0, Time=1.000000e-02", 1,1), (1, "Step=1, Time=2.000000e-02", 1,1), (2, "Step=2, Time=3.000000e-02", 1,1), (3, "Step=3, Time=4.000000e-02", 1,1), (4, "Step=4, Time=5.000000e-02", 1,1), (5, "Step=5, Time=6.000000e-02", 1,0)])])

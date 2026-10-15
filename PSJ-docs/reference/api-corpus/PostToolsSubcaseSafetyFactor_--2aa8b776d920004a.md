# PostToolsSubcaseSafetyFactor()

PostToolsSubcaseSafetyFactor()

説明​

サブケース - 安全率。

構文​

PostToolsSubcaseSafetyFactor(int AnaType, int RltSet, SubcaseItem[] SubCases, SafetyItem[] SafetyItems, int ThresholdType, string RltName)

入力​

1. int ​

解析タイプ。

2. int ​

結果セット。

3. SubcaseItem [] ​

対象のサブケース。SubcaseItemの内容は次の通りです：

int - ID,

string - 名前,

double - 係数,

bool - ステータス。

4. SafetyItem [] ​

対象アイテム。SafetyItemの内容は次の通りです：

cursor - パート,

double - 閾値。

5. int ​

閾値タイプ

6. string ​

結果名。

戻り値​

なし。

サンプルコード​

PostToolsSubcaseSafetyFactor(1, 0, [(0, "ステップ=0、時間=1.000000e-02", 1,1), (1, "ステップ=1、時間=2.000000e-02", 1,1), (2, "ステップ=2、時間=3.000000e-02", 1,1)], [(3:1, 0)], 0, "安全性収量")

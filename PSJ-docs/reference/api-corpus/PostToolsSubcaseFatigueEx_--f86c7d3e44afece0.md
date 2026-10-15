# PostToolsSubcaseFatigueEx()

PostToolsSubcaseFatigueEx()

説明​

サブケース - 疲労。

構文​

PostToolsSubcaseFatigueEx(int AnaType, string Name, bool FromMaterial, float Qb, float Qw, float Qy, float Angle, string SubcaseName, int SubcaseID, Smap[] SubcaseMap, cursor[] target)

入力​

1. int ​

解析タイプ。

2. string ​

名称

3. bool ​

素材からのフラグ。

4. float ​

Qy

5. float ​

Qb

6. float ​

Qw

7. float ​

角度

8. string ​

新しいサブケース名。

9. int ​

新しいサブケースID

10. SubcaseItem [] ​

対象のサブケース。SubcaseItemの内容は次のとおりです：

int - ID、

string - 名前、

double - 係数、

bool - ステータス。

11. cursor [] ​

ターゲット。

戻り値​

なし。

サンプルコード​

PostToolsSubcaseFatigueEx(1, "サブケース疲労", 0, 270, 130, 165, 15, "サブケース疲労", 104, [(0, [(0, "Process= 0-Step=0, Time=1.000000e-02", 1,1), (1, "Process= 0-Step=1, Time=2.000000e-02", 1,1), (2, "Process= 0-Step=2, Time=3.000000e-02", 1,1), (3, "Process= 0-Step=3, Time=4.000000e-02", 1,1), (4, "Process= 0-Step=4, Time=5.000000e-02", 1,0), (5, "Process= 0-Step=5, Time=6.000000e-02", 1,0)])], [3:1])

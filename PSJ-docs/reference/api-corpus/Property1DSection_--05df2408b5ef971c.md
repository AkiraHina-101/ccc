# Property1DSection()

Property1DSection()

説明​

1D 1Dセクションプロパティ

構文​

Property1DSection(string Name, int SectionType, int SectionGenerateType, double SizeA,
    double SizeB, double SizeH, double SizeT1, double SizeT2, double SizeT3, bool Tapered,
    double A_tap, double B_tap, double H_tap, double T1_tap, double T2_tap, double T3_tap)

入力​

1. String​

名前セクション

2. Int​

セクションタイプ [一般セクション = 0, ライブラリセクション = 1]

3. Int​

セクション生成タイプ [PROP_SECTION_GEN_RECT = 0, PROP_SECTION_GEN_RECT_TUBE = 1, PROP_SECTION_GEN_CIRCLE = 2, PROP_SECTION_GEN_CIRCLE_TUBE = 3, PROP_SECTION_GEN_C = 4, PROP_SECTION_GEN_IH = 5, PROP_SECTION_GEN_L = 6, PROP_SECTION_GEN_T =7]

4. Double​

セクションサイズA

5. Double​

セクションサイズB

6. Double​

セクションサイズH

7. Double​

セクションサイズT1

8. Double​

セクションサイズT2

9. Double​

セクションサイズT3

10. Bool​

先細りフラグ true = 1, false = 0

11. Double​

テープサイズA

12. Double​

テープサイズB

13. Double​

テープサイズH

14. Double​

テープサイズT1

15. Double​

テープサイズT2

16. Double​

テープサイズT3

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

Property1DSection("T", 0, 7, 0, 0.0005, 0.0005, 0.0001, 0.0001, 0, 0, 0, 0, 0, 0, 0, 0)

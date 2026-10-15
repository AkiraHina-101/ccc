# Property1DSection()

Property1DSection()

Description​

1D 1D section property

Syntax​

Property1DSection(string Name, int SectionType, int SectionGenerateType, double SizeA,
    double SizeB, double SizeH, double SizeT1, double SizeT2, double SizeT3, bool Tapered,
    double A_tap, double B_tap, double H_tap, double T1_tap, double T2_tap, double T3_tap)

Inputs​

1. String​

Name Section

2. Int​

Section Type [General Section = 0, Library Section = 1]

3. Int​

Section Generate Type [PROP_SECTION_GEN_RECT = 0, PROP_SECTION_GEN_RECT_TUBE = 1, PROP_SECTION_GEN_CIRCLE = 2, PROP_SECTION_GEN_CIRCLE_TUBE = 3, PROP_SECTION_GEN_C = 4, PROP_SECTION_GEN_IH = 5, PROP_SECTION_GEN_L = 6, PROP_SECTION_GEN_T =7]

4. Double​

Section size A

5. Double​

Section size B

6. Double​

Section size H

7. Double​

Section size T1

8. Double​

Section size T2

9. Double​

Section size T3

10. Bool​

Tapered flag true = 1,false = 0

11. Double​

Tap size A

12. Double​

Tap size B

13. Double​

Tap size H

14. Double​

Tap size T1

15. Double​

Tap size T2

16. Double​

Tap size T3

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property1DSection("T", 0, 7, 0, 0.0005, 0.0005, 0.0001, 0.0001, 0, 0, 0, 0, 0, 0, 0, 0)

# Property1DRod()

Property1DRod()

Description​

1D Rod property

Syntax​

Property1DRod(string strName, int ID, color propertyColor, cursor crSection, cursor DataMat,
    double dAreaVal, double dTorsConst, double dTorsStress, double dNonstMass,
    int dLocalLengthUnit, int iLocalMassUnit, cursor[] taTarget, cursor crEdit)

Inputs​

1. String​

Property 1D rod name

2. Int​

Property 1D ID input

3. Color​

Color of the property.

4. Cursor​

Section cursor(93:SectionGeneral ID)

5. Cursor​

Data material cursor(22:Material ID)

6. Double​

Area value

7. Double​

Torsional const value

8. Double​

Torsional stress coefficient

9. Double​

Nonstruct Mass

10. Int​

Input length unit

0: Mm

1: M

2: Ft

3: In

4: Cm

11. Int​

Input mass unit

1: blank

0: T

1: kg

2: kgf*s^2/mm

3: Lbf*s^2/in

12. Cursor[]​

Target entities cursor

13. Cursor​

Edit cursor

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property1DRod("ROD10", 8, 10239814, 93:1, 22:6, 1e-05, 2e-12, 4, 3e+06, 0, 0, [5:53], 0:0)

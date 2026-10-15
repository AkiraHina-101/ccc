# Prop3DGasket()

Prop3DGasket()

Description​

Create property 3d gasket

Syntax​

Prop3DGasket(string strName, color propertyColor, cursor crMaterial, double dThickX, double dThickY,
    double dThickZ, cursor taTarget, cursor crEdit, bool bUniAxial, int FLG)

Inputs​

1. String​

Prop3DGasket name

2. Color​

Color of the property.

3. Cursor​

Material cursor(22:Material ID)

4. Double​

Thickness direction X

5. Double​

Thickness direction Y

6. Double​

Thickness direction Z

7. Cursor​

Target entities cursor

8. Cursor​

Edit cursor

9. Bool​

UniAxial bool flag True = 1, False = 0

10. Int​

FLG

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Prop3DGasket("Gasket Property 1", 13642735, 22:6, 1, 2, 3, [3:1], 0:0, 1, 1)

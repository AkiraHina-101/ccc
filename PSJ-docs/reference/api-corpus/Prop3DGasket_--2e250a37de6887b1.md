# Prop3DGasket()

Prop3DGasket()

Description​

Create property 3d gasket

Syntax​

Prop3DGasket(string strName, cursor crMaterial, double dThickX, double dThickY,
    double dThickZ, cursor taTarget, cursor crEdit, bool bUniAxial, int FLG)

Inputs​

1. String​

Prop3DGasket name

2. Cursor​

Material cursor(22:Material ID)

3. Double​

Thickness direction X

4. Double​

Thickness direction Y

5. Double​

Thickness direction Z

6. Cursor​

Target entities cursor

7. Cursor​

Edit cursor

8. Bool​

UniAxial bool flag True = 1, False = 0

9. Int​

FLG

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Prop3DGasket("Gasket Property 1", 22:6, 1, 2, 3, [3:1], 0:0, 1, 1)

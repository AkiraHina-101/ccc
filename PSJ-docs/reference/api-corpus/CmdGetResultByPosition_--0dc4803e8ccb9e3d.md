# CmdGetResultByPosition()

CmdGetResultByPosition()

Description​

Get result of specific position

Syntax​

CmdGetResultByPosition(Real x, Real y, Real z, Real Tolerance, bool DisplayPartOnly, bool UseMidNode)

Inputs​

1. Real​

X position

2. Real​

Y position

3. Real​

Z potision

4. Real​

Tolerance of search surface.

5 bool​

Restrict search target only displayed parts. true = 1,false = 0

6. bool​

Use mid node data. true = 1,false = 0

Return Code​

Result value of the searched point. The precision is set by Watch Data of Numeric settings in Preferences.

"FAILED": If no position searched.

Sample Code​

CmdGetResultByPosition(10.001400, 8.884620, 1.818100, 0.010000, 0, 1)')

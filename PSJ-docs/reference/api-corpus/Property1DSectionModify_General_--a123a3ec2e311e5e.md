# Property1DSectionModify_General()

Property1DSectionModify_General()

Description​

Modify the existing 1D cross-section.

Syntax​

Property1DSectionModify_General(string strName, cursor crSection,int iSecType, int iGeneralType, double dA, double dB, double dH, double dT1, double dT2, double dT3, bool bTapered, double dDaTap, double dDbTap, double dDhTap, double dDt1Tap, double dDt2Tap, double dDt3Tap, int iDirType)

Inputs​

1. String​

Property name

2.Cursor​

Existing section to modify.

3.Int​

Section type.

4.Int​

General type.

5.Double​

a.

6.Double​

b.

7.Double​

h.

8.Double​

t1.

9.Double​

t2.

10.Double​

t3.

11.Bool​

Tapered or not.

12.Double​

a tapered.

13.Double​

b tapered.

14.Double​

h tapered.

15.Double​

t1 tapered.

16.Double​

t2 tapered.

17.Double​

t3 tapered.

18.Int​

An Integer specifying direction type.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property1DSectionModify_General("Modified", 93:1, 0, 0, 0, 0.002, 0.003, 0.001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)

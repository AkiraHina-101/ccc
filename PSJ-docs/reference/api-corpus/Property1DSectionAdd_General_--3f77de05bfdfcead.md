# Property1DSectionAdd_General()

Property1DSectionAdd_General()

Description​

Create the general properties of 1D section.

Syntax​

Property1DSectionAdd_General(string strName, int iSecType, int iSecGenType, double dDsecGensizeA, double dDsecGensizeB, double dDsecGensizeH, double dDsecGensizeT1, double dDsecGensizeT2, double dDsecGensizeT3, bool bBsecTapered, double dDsecGensizeATap, double dDsecGensizeBTap, double dDsecGensizeHTap, double dDsecGensizeT1Tap, double dDsecGensizeT2Tap, double dDsecGensizeT3Tap, int iDirType)

Inputs​

1. String​

Property name

2. Int​

Section type.

3. Int​

Section general type.

4.Double​

Section general size a.

5.Double​

Section general size b.

6.Double​

Section general size h.

7.Double​

Section general size t1.

8.Double​

Section general size t2.

9.Double​

Section general size t3.

10.Bool​

The bsec tapered.

11.Double​

Section general size a tapered.

12.Double​

Section general size b tapered.

13.Double​

Section general size h tapered.

14.Double​

Section general size t1 tapered.

15.Double​

Section general size t2 tapered.

16.Double​

Section general size t3 tapered.

17.Int​

Y direction type.

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

Property1DSectionAdd_General("NewSection", 0, 2, 0, 0, 0, 0.001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)

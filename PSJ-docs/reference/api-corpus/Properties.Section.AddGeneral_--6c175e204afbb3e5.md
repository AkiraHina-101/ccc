# Properties.Section.AddGeneral()

Properties.Section.AddGeneral()

Description​

The general properties of a one-dimensional section are generated.

Syntax​

Properties.Section.AddGeneral(...)

Ribbon: Properties » Section » AddGeneral

Inputs​

strName​

A String specifying the name.

The default value is "".

iSecType​

An Integer specifying the section type.

The default value is 0.

iSecGenType​

An Integer specifying the section general type.

The default value is 0.

dDsecGensizeA​

A Double specifying the section general size a.

The default value is 0.

dDsecGensizeB​

A Double specifying the section general size b.

The default value is 0.

dDsecGensizeH​

A Double specifying the section general size h.

The default value is 0.

dDsecGensizeT1​

A Double specifying the section general size t1.

The default value is 0.

dDsecGensizeT2​

A Double specifying the section general size t2.

The default value is 0.

dDsecGensizeT3​

A Double specifying the section general size t3.

The default value is 0.

bBsecTapered​

A Boolean specifying the bsec tapered.

The default value is False.

dDsecGensizeATap​

A Double specifying the section general size a tapered.

The default value is 0.

dDsecGensizeBTap​

A Double specifying the section general size b tapered.

The default value is 0.

dDsecGensizeHTap​

A Double specifying the section general size h tapered.

The default value is 0.

dDsecGensizeT1Tap​

A Double specifying the section general size t1 tapered.

The default value is 0.

dDsecGensizeT2Tap​

A Double specifying the section general size t2 tapered.

The default value is 0.

dDsecGensizeT3Tap​

A Double specifying the section general size t3 tapered.

The default value is 0.

iDirType​

An Integer specifying the y direction type.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Properties.Section.AddGeneral(strName="t1", 
                            iSecGenType=2, 
                            dDsecGensizeT1=0.001, 
                            iDirType=1)

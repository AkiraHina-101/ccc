# Properties.Section.ModifyGeneral()

Properties.Section.ModifyGeneral()

Description​

Modify the existing general section for 1D Property.

Syntax​

Properties.Section.ModifyGeneral(...)

Macro: Property1DSectionModify_General

Ribbon: Properties » Section » ModifyGeneral

Inputs​

strName​

A String specifying the section name.

The default value is "".

crSection​

A Cursor specifying the existing section to modify.

The default value is None.

iSecType​

An Integer specifying the section type.

The default value is 0.

iGeneralType​

An Integer specifying the general type.

The default value is 0.

dA​

A Double specifying the a.

The default value is 0.

dB​

A Double specifying the b.

The default value is 0.

dH​

A Double specifying the h.

The default value is 0.

dT1​

A Double specifying the t1.

The default value is 0.

dT2​

A Double specifying the t2.

The default value is 0.

dT3​

A Double specifying the t3.

The default value is 0.

bTapered​

-A Boolean specifying whether or not tapered.

The default value is False.

dDaTap​

A Double specifying the a tapered.

The default value is 0.

dDbTap​

A Double specifying the b tapered.

The default value is 0.

dDhTap​

A Double specifying the h tapered.

The default value is 0.

dDt1Tap​

A Double specifying the t1 tapered.

The default value is 0.

dDt2Tap​

A Double specifying the t2 tapered.

The default value is 0.

dDt3Tap​

A Double specifying the t3 tapered.

The default value is 0.

iDirType​

An Integer specifying direction type.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Properties.Section.AddGeneral(  strName="t1", 
                                iSecGenType=2, 
                                dDsecGensizeT1=0.001, 
                                iDirType=1)
Properties.Section.ModifyGeneral(strName="t1", 
                                crSection=SectionGeneral(1), 
                                iGeneralType=2, 
                                dT1=0.001, 
                                iDirType=3)

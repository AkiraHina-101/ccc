# Connections.Contacts.Abaqus.ContactGroupByMatrix()

Connections.Contacts.Abaqus.ContactGroupByMatrix()

Description​

Create LBC contact abaqus group by matrix.

Syntax​

Connections.Contacts.Abaqus.ContactGroupByMatrix(...)

Ribbon: Connections » Contacts » Abaqus » ContactGroupByMatrix

Inputs​

strName​

A String specifying the name.

The default value is "".

iContactMethod​

An Integer specifying the contact method.

The default value is 1.

iContactType​

An Integer specifying the contact type.

The default value is 0.

iAlg​

An Integer specifying the algorithm.

The default value is 0.

dAdjustVal​

A Double specifying the adjust value.

The default value is 0.0.

dExtensionZone​

A Double specifying the extension zone.

The default value is 0.0.

dMaxPenetration​

A Double specifying the maximum penetration.

The default value is 0.0.

iSmallSliding​

An Integer specifying the small sliding.

The default value is 0.

dSmooth​

A Double specifying the smooth.

The default value is 0.0.

iFrictionType​

An Integer specifying the friction type.

The default value is 0.

dFrictionCoef1​

A Double specifying the friction coefficient 1.

The default value is 0.0.

dFrictionCoef2​

A Double specifying the friction coefficient 2.

The default value is 0.0.

dShearLimit​

A Double specifying the shear limit.

The default value is 0.0.

dSlipTol​

A Double specifying the slip tolerance.

The default value is 0.0.

dStaticFrictionCoef​

A Double specifying the static friction coefficient .

The default value is 0.0.

dKineticFrictionCoef​

A Double specifying the kinetic friction coefficient .

The default value is 0.0.

dDecayCoef​

A Double specifying the decay coefficient .

The default value is 0.0.

iAdjust​

An Integer specifying the adjust.

The default value is 0.

dPositonTol​

A Double specifying the positon tolerance.

The default value is 0.0.

iFormula​

An Integer specifying the formula.

The default value is 0.

iTie​

An Integer specifying the tie.

The default value is 0.

iPOCType​

An Integer specifying the POC type.

The default value is 0.

iAllowSeparation​

An Integer specifying the allow separation.

The default value is 0.

dSlope​

A Double specifying the slope.

The default value is 0.0.

tshPOCTsheet​

A Table Sheet specifying the POC table sheet.

The default value is [].

iClearanceType​

An Integer specifying the clearance type.

The default value is 0.

iClearanceTypeId​

An Integer specifying the clearance type ID.

The default value is 0.

bTemperatureDependency​

A Boolean specifying the temperature dependency.

The default value is False.

iDependencies​

An Integer specifying the dependencies.

The default value is 0.

tshCDTsheet​

A Table Sheet specifying the CD table sheet.

The default value is [].

iPrsTypeId​

An Integer specifying the pressure type ID.

The default value is 0.

bPrsTemperatureDependency​

A Boolean specifying the pressure temperature dependency.

The default value is False.

iPrsDependencies​

An Integer specifying the pressure dependencies.

The default value is 0.

tshPrsDTsheet​

A Table Sheet specifying the pressure d table sheet.

The default value is [].

crplTarget​

A Cursor Pair List specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

iColor​

An Integer specifying the color.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.Abaqus.ContactGroupByMatrix(strName="", iContactMethod=1, iContactType=0, iAlg=0, dAdjustVal=0.0, dExtensionZone=0.0, dMaxPenetration=0.0, iSmallSliding=0, dSmooth=0.0, iFrictionType=0, dFrictionCoef1=0.0, dFrictionCoef2=0.0, dShearLimit=0.0, dSlipTol=0.0, dStaticFrictionCoef=0.0, dKineticFrictionCoef=0.0, dDecayCoef=0.0, iAdjust=0, dPositonTol=0.0, iFormula=0, iTie=0, iPOCType=0, iAllowSeparation=0, dSlope=0.0, tshPOCTsheet=[], iClearanceType=0, iClearanceTypeId=0, bTemperatureDependency=False, iDependencies=0, tshCDTsheet=[], iPrsTypeId=0, bPrsTemperatureDependency=False, iPrsDependencies=0, tshPrsDTsheet=[], crplTarget=[], crEdit=None, iColor=0)

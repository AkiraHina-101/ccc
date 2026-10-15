# Connections.Contacts.ADVC.ContactShareFace()

Connections.Contacts.ADVC.ContactShareFace()

Description​

Create ADVC Contact Share Face

Syntax​

Connections.Contacts.ADVC.ContactShareFace(crlShareFace=[], strName="ContactADVC", iContactType=0, iSlidingType=0, iInitialState=0, dInitialStateTol=DFLT_DBL, dKineticFrictionCoef=DFLT_DBL, dExponentialCoef=DFLT_DBL, iBehavior=0, dClearance=DFLT_DBL, iAdjust2Clearance=0, dInterference=DFLT_DBL, iAdjust2Interference=0, iAutoShrink=0, iAdvAdjust=0, dAdjustValue=DFLT_DBL, dFrictionCoef=DFLT_DBL, dMaxShear=DFLT_DBL, dElasticSlip=DFLT_DBL, dSlipTolerance=DFLT_DBL, dSearchWidth=DFLT_DBL, dSearchGap=DFLT_DBL, dSearchDepth=DFLT_DBL, dCritialPenetration=DFLT_DBL, iEstimationImpactTime=0, iFormula=0, iConstraintType=0, iDataType=0, iTypeId=0, bTemperatureDependency=False, iNumDependencies=0, tshTableClearance=[], bStabilized=0, iStabilizeType=0, dResidualFactor=DFLT_DBL, dEffectiveDist=DFLT_DBL, dCN=DFLT_DBL, dCT=DFLT_DBL, crlClearance=[], crEdit=None, dSearchAngle=DFLT_DBL, iConstraintTypeExplicit=0, dPenaltyFact=DFLT_DBL, dPenaltyFactExplicit=DFLT_DBL, iColor=16711680, iAlg=0, iMethod=3)

Ribbon: Connections » Contacts » ADVC » ContactShareFace

Inputs​

crlShareFace​

A List of Cursor specifying the share face.

The default value is [].

strName​

A String specifying the name.

The default value is "ContactADVC".

iContactType​

An Integer specifying the contact type.

The default value is 0.

iSlidingType​

An Integer specifying the sliding type.

The default value is 0.

iInitialState​

An Integer specifying the initial state.

The default value is 0.

dInitialStateTol​

A Double specifying the initial state tolerance.

The default value is DFLT_DBL.

dKineticFrictionCoef​

A Double specifying the kinetic friction coefficient .

The default value is DFLT_DBL.

dExponentialCoef​

A Double specifying the exponential coefficient .

The default value is DFLT_DBL.

iBehavior​

An Integer specifying the behavior.

The default value is 0.

dClearance​

A Double specifying the clearance.

The default value is DFLT_DBL.

iAdjust2Clearance​

An Integer specifying the adjust2 clearance.

The default value is 0.

dInterference​

A Double specifying the interference.

The default value is DFLT_DBL.

iAdjust2Interference​

An Integer specifying the adjust2 interference.

The default value is 0.

iAutoShrink​

An Integer specifying the auto shrink.

The default value is 0.

iAdvAdjust​

An Integer specifying the adv adjust.

The default value is 0.

dAdjustValue​

A Double specifying the adjust value.

The default value is DFLT_DBL.

dFrictionCoef​

A Double specifying the friction coefficient .

The default value is DFLT_DBL.

dMaxShear​

A Double specifying the maximum shear.

The default value is DFLT_DBL.

dElasticSlip​

A Double specifying the elastic slip.

The default value is DFLT_DBL.

dSlipTolerance​

A Double specifying the slip tolerance.

The default value is DFLT_DBL.

dSearchWidth​

A Double specifying the search width.

The default value is DFLT_DBL.

dSearchGap​

A Double specifying the search gap.

The default value is DFLT_DBL.

dSearchDepth​

A Double specifying the search depth.

The default value is DFLT_DBL.

dCritialPenetration​

A Double specifying the critial penetration.

The default value is DFLT_DBL.

iEstimationImpactTime​

An Integer specifying the estimation impact time.

The default value is 0.

iFormula​

An Integer specifying the formula.

The default value is 0.

iConstraintType​

An Integer specifying the constraint type.

The default value is 0.

iDataType​

An Integer specifying the data type.

The default value is 0.

iTypeId​

An Integer specifying the type ID.

The default value is 0.

bTemperatureDependency​

A Boolean specifying the temperature dependency.

The default value is False.

iNumDependencies​

An Integer specifying the number dependencies.

The default value is 0.

tshTableClearance​

A Table Sheet specifying the table clearance.

The default value is [].

bStabilized​

A Boolean specifying the stabilized.

The default value is 0.

iStabilizeType​

An Integer specifying the stabilize type.

The default value is 0.

dResidualFactor​

A Double specifying the residual factor.

The default value is DFLT_DBL.

dEffectiveDist​

A Double specifying the effective dist.

The default value is DFLT_DBL.

dCN​

A Double specifying the c n.

The default value is DFLT_DBL.

dCT​

A Double specifying the c t.

The default value is DFLT_DBL.

crlClearance​

A List of Cursor specifying the clearance.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

dSearchAngle​

A Double specifying the search angle.

The default value is DFLT_DBL.

iConstraintTypeExplicit​

An Integer specifying the constraint type explicit.

The default value is 0.

dPenaltyFact​

A Double specifying the penalty fact.

The default value is DFLT_DBL.

dPenaltyFactExplicit​

A Double specifying the penalty fact explicit.

The default value is DFLT_DBL.

iColor​

An Integer specifying the color.

The default value is 16711680.

iAlg​

An Integer specifying the algorithm.

The default value is 0.

iMethod​

An Integer specifying the method.

The default value is 3.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.ADVC.ContactShareFace(crlShareFace=[], strName="ContactADVC", iContactType=0, iSlidingType=0, iInitialState=0, dInitialStateTol=DFLT_DBL, dKineticFrictionCoef=DFLT_DBL, dExponentialCoef=DFLT_DBL, iBehavior=0, dClearance=DFLT_DBL, iAdjust2Clearance=0, dInterference=DFLT_DBL, iAdjust2Interference=0, iAutoShrink=0, iAdvAdjust=0, dAdjustValue=DFLT_DBL, dFrictionCoef=DFLT_DBL, dMaxShear=DFLT_DBL, dElasticSlip=DFLT_DBL, dSlipTolerance=DFLT_DBL, dSearchWidth=DFLT_DBL, dSearchGap=DFLT_DBL, dSearchDepth=DFLT_DBL, dCritialPenetration=DFLT_DBL, iEstimationImpactTime=0, iFormula=0, iConstraintType=0, iDataType=0, iTypeId=0, bTemperatureDependency=False, iNumDependencies=0, tshTableClearance=[], bStabilized=0, iStabilizeType=0, dResidualFactor=DFLT_DBL, dEffectiveDist=DFLT_DBL, dCN=DFLT_DBL, dCT=DFLT_DBL, crlClearance=[], crEdit=None, dSearchAngle=DFLT_DBL, iConstraintTypeExplicit=0, dPenaltyFact=DFLT_DBL, dPenaltyFactExplicit=DFLT_DBL, iColor=16711680, iAlg=0, iMethod=3)

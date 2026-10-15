# Connections.Contacts.NXNastran.ContactTable()

Connections.Contacts.NXNastran.ContactTable()

Description​

Create Contact NXNastran Contact Table

Syntax​

Connections.Contacts.NXNastran.ContactTable(strName="", iType=0, iAlg=0, dNorPenFactor=0, dTanPenFactor=0, dForceConTol=0, dMaxForceIter=0, dMaxStaIter=0, dChangeNum=0, dMinContactPer=0, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=0, dMinSearDist=0, dMaxSearDist=0, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, crplTargetPair=[], crEdit=None, iColor=0, iMethod=1)

Ribbon: Connections » Contacts » NXNastran » ContactTable

Inputs​

strName​

A String specifying the name.

The default value is "".

iType​

An Integer specifying the type.

The default value is 0.

iAlg​

An Integer specifying the algorithm.

The default value is 0.

dNorPenFactor​

A Double specifying the nor pen factor.

The default value is 0.

dTanPenFactor​

A Double specifying the tan pen factor.

The default value is 0.

dForceConTol​

A Double specifying the force con tolerance.

The default value is 0.

dMaxForceIter​

A Double specifying the maximum force iterator.

The default value is 0.

dMaxStaIter​

A Double specifying the maximum sta iterator.

The default value is 0.

dChangeNum​

A Double specifying the change number.

The default value is 0.

dMinContactPer​

A Double specifying the minimum contact per.

The default value is 0.

iShellThickness​

An Integer specifying the shell thickness.

The default value is 0.

iContactStatus​

An Integer specifying the contact status.

The default value is 0.

iInitGapPenetra​

An Integer specifying the initial gap penetra.

The default value is 0.

iRegionRefine​

An Integer specifying the region refine.

The default value is 0.

iEvaluPts​

An Integer specifying the evalu pts.

The default value is 0.

dMinSearDist​

A Double specifying the minimum sear dist.

The default value is 0.

dMaxSearDist​

A Double specifying the maximum sear dist.

The default value is 0.

dFricCoef​

A Double specifying the fric coefficient .

The default value is 0.

dSearchDist​

A Double specifying the search dist.

The default value is 0.

dPenatlyFactor​

A Double specifying the penatly factor.

The default value is 0.

iShellOffset​

An Integer specifying the shell offset.

The default value is 0.

crplTargetPair​

A Cursor Pair List specifying the target pair.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

iColor​

An Integer specifying the color.

The default value is 0.

iMethod​

An Integer specifying the method.

The default value is 1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.NXNastran.ContactTable(strName="", iType=0, iAlg=0, dNorPenFactor=0, dTanPenFactor=0, dForceConTol=0, dMaxForceIter=0, dMaxStaIter=0, dChangeNum=0, dMinContactPer=0, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=0, dMinSearDist=0, dMaxSearDist=0, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, crplTargetPair=[], crEdit=None, iColor=0, iMethod=1)

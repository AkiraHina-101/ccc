# Connections.Contacts.NXNastran.ContactGroupByMatrix()

Connections.Contacts.NXNastran.ContactGroupByMatrix()

Description​

Create Contact NXNastran Contact Group By Matrix

Syntax​

Connections.Contacts.NXNastran.ContactGroupByMatrix(crFaceMaster=None, crFaceSlave=None, strName="ContactNXNastran_1", iContactType=0, iContactAlg=0, dNorPenFactor=10, dTanPenFactor=1, dForceConTol=0.01, dMaxForceIter=10, dMaxStaIter=20, dChangeNum=0.02, dMinContactPer=100, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=1, dMinSearDist=0, dMaxSearDist=0.01, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, iColor=0, iMethod=0, crEdit=None)

Ribbon: Connections » Contacts » NXNastran » ContactGroupByMatrix

Inputs​

crFaceMaster​

A Cursor specifying the face master.

The default value is None.

crFaceSlave​

A Cursor specifying the face slave.

The default value is None.

strName​

A String specifying the name.

The default value is "ContactNXNastran_1".

iContactType​

An Integer specifying the contact type.

The default value is 0.

iContactAlg​

An Integer specifying the contact algorithm.

The default value is 0.

dNorPenFactor​

A Double specifying the nor pen factor.

The default value is 10.

dTanPenFactor​

A Double specifying the tan pen factor.

The default value is 1.

dForceConTol​

A Double specifying the force con tolerance.

The default value is 0.01.

dMaxForceIter​

A Double specifying the maximum force iterator.

The default value is 10.

dMaxStaIter​

A Double specifying the maximum sta iterator.

The default value is 20.

dChangeNum​

A Double specifying the change number.

The default value is 0.02.

dMinContactPer​

A Double specifying the minimum contact per.

The default value is 100.

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

The default value is 1.

dMinSearDist​

A Double specifying the minimum sear dist.

The default value is 0.

dMaxSearDist​

A Double specifying the maximum sear dist.

The default value is 0.01.

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

iColor​

An Integer specifying the color.

The default value is 0.

iMethod​

An Integer specifying the method.

The default value is 0.

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.NXNastran.ContactGroupByMatrix(crFaceMaster=None, crFaceSlave=None, strName="ContactNXNastran_1", iContactType=0, iContactAlg=0, dNorPenFactor=10, dTanPenFactor=1, dForceConTol=0.01, dMaxForceIter=10, dMaxStaIter=20, dChangeNum=0.02, dMinContactPer=100, iShellThickness=0, iContactStatus=0, iInitGapPenetra=0, iRegionRefine=0, iEvaluPts=1, dMinSearDist=0, dMaxSearDist=0.01, dFricCoef=0, dSearchDist=0, dPenatlyFactor=0, iShellOffset=0, iColor=0, iMethod=0, crEdit=None)

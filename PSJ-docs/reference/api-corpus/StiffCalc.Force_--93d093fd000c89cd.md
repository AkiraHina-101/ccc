# StiffCalc.Force()

StiffCalc.Force()

Description​

Create NormalUnityForce

Syntax​

StiffCalc.Force(strName, poslForce, poslMoment, iEnArrowDir, iDistributionMethod, crCurCoord, crTable, crNodeSet, dFPhase, dFDelay, crPhaseTable, strFormula0, strFormula1, strFormula2, strFormula3, strFormula4, strFormula5, crlTargets, crEdit)

Ribbon: StiffCalc » Force

Inputs​

strName​

A String specifying the name.

This is a required input.

poslForce​

A Position List specifying the force.

This is a required input.

poslMoment​

A Position List specifying the moment.

This is a required input.

iEnArrowDir​

An Integer specifying the en arrow direction.

This is a required input.

iDistributionMethod​

An Integer specifying the distribution method.

This is a required input.

crCurCoord​

A Cursor specifying the cur coordinate.

This is a required input.

crTable​

A Cursor specifying the table.

This is a required input.

crNodeSet​

A Cursor specifying the node set.

This is a required input.

dFPhase​

A Double specifying the phase.

This is a required input.

dFDelay​

A Double specifying the delay.

This is a required input.

crPhaseTable​

A Cursor specifying the phase table.

This is a required input.

strFormula0​

A String specifying the formula0.

This is a required input.

strFormula1​

A String specifying the formula1.

This is a required input.

strFormula2​

A String specifying the formula2.

This is a required input.

strFormula3​

A String specifying the formula3.

This is a required input.

strFormula4​

A String specifying the formula4.

This is a required input.

strFormula5​

A String specifying the formula5.

This is a required input.

crlTargets​

A List of Cursor specifying the target.

This is a required input.

crEdit​

A Cursor specifying the edit.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

StiffCalc.Force(strName, poslForce, poslMoment, iEnArrowDir, iDistributionMethod, crCurCoord, crTable, crNodeSet, dFPhase, dFDelay, crPhaseTable, strFormula0, strFormula1, strFormula2, strFormula3, strFormula4, strFormula5, crlTargets, crEdit)

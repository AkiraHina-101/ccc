# Connections.Contacts.ADVC.ContactClearance()

Connections.Contacts.ADVC.ContactClearance()

Description​

Contact clearance for ADVC contact

Syntax​

Connections.Contacts.ADVC.ContactClearance(strName, dClearanceVal, iLocalUnit, iSolverType, crlTargets, crEdit=None)

Macro: ContactClearance

Ribbon: Connections » Contacts » ADVC » ContactClearance

Inputs​

strName​

A String specifying the name.

This is a required input.

dClearanceVal​

A Double specifying the clearance value.

This is a required input.

iLocalUnit​

An Integer specifying the local unit.

This is a required input.

iSolverType​

An Integer specifying the solver type.

This is a required input.

crlTargets​

A List of Cursor specifying the target.

This is a required input.

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.ADVC.ContactClearance(strName, dClearanceVal, iLocalUnit, iSolverType, crlTargets, crEdit=None)

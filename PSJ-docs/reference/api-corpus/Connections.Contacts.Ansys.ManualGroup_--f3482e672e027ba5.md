# Connections.Contacts.Ansys.ManualGroup()

Connections.Contacts.Ansys.ManualGroup()

Description​

Create contact ansys Manual Group

Syntax​

Connections.Contacts.Ansys.ManualGroup(strName="ContactAnsys_1", iMethod=1, iType=0, iContactAlgorithm=0, ansysContact=ANSYS_CONTACT(), crplTarget=[], crEdit=None, iColor=16711680)

Ribbon: Connections » Contacts » Ansys » ManualGroup

Inputs​

strName​

A String specifying the name.

The default value is "ContactAnsys_1".

iMethod​

An Integer specifying the method.

The default value is 1.

iType​

An Integer specifying the type.

The default value is 0.

iContactAlgorithm​

An Integer specifying the contact algorithm.

The default value is 0.

ansysContact​

A ANSYS_CONTACT specifying the contact.

The default value is ANSYS_CONTACT().

crplTarget​

A Cursor Pair List specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

iColor​

An Integer specifying the color.

The default value is 16711680.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.Ansys.ManualGroup(strName="ContactAnsys_1", iMethod=1, iType=0, iContactAlgorithm=0, ansysContact=ANSYS_CONTACT(), crplTarget=[], crEdit=None, iColor=16711680)

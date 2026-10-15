# Connections.Contacts.MSCNastran.ContactTable()

Connections.Contacts.MSCNastran.ContactTable()

Description​

Create contacts of MSC Nastran Contact Table

Syntax​

Connections.Contacts.MSCNastran.ContactTable(strName="", nastranContact=NASTRAN_CONTACT(), crplTarget=[], crEdit=None, iColor=65280, iMethod=1)

Ribbon: Connections » Contacts » MSCNastran » ContactTable

Inputs​

strName​

A String specifying the name.

The default value is "".

nastranContact​

A NASTRAN_CONTACT specifying the contact.

The default value is NASTRAN_CONTACT().

crplTarget​

A Cursor Pair List specifying the target.

The default value is [].

crEdit​

A Cursor specifying the edit.

The default value is None.

iColor​

An Integer specifying the color.

The default value is 65280.

iMethod​

An Integer specifying the method.

The default value is 1.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.MSCNastran.ContactTable(strName="", nastranContact=NASTRAN_CONTACT(), crplTarget=[], crEdit=None, iColor=65280, iMethod=1)

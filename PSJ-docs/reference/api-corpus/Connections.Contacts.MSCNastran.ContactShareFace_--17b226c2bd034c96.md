# Connections.Contacts.MSCNastran.ContactShareFace()

Connections.Contacts.MSCNastran.ContactShareFace()

Description​

Create contacts of MSC Nastran Contact Share Face

Syntax​

Connections.Contacts.MSCNastran.ContactShareFace(crlShareFace=[], strName="", nastranContact=NASTRAN_CONTACT(), crEdit=None, iColor=65280, iMethod=3)

Ribbon: Connections » Contacts » MSCNastran » ContactShareFace

Inputs​

crlShareFace​

A List of Cursor specifying the share face.

The default value is [].

strName​

A String specifying the name.

The default value is "".

nastranContact​

A NASTRAN_CONTACT specifying the contact.

The default value is NASTRAN_CONTACT().

crEdit​

A Cursor specifying the edit.

The default value is None.

iColor​

An Integer specifying the color.

The default value is 65280.

iMethod​

An Integer specifying the method.

The default value is 3.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.Contacts.MSCNastran.ContactShareFace(crlShareFace=[], strName="", nastranContact=NASTRAN_CONTACT(), crEdit=None, iColor=65280, iMethod=3)

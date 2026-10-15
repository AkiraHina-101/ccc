# DContact

DContact

Description​

This is an instance of a DContact class, represents Contact item inside Jupiter.

Properties​

 | Attribute | Description

 | isValid | Determine the validation of the Contact.
 The return value is True if the Connection is valid, False if not (invalid).

 | type | Type name of the Contact.
The return value is Type (string).

 | typeID | Type ID of the Contact.
The return value is an Int notation of DItem Types (int).

 | tableID | Table ID of the Contact.
The return value is an Int notation of DTable Types (int).

 | id | External ID of the Contact.
It can be duplicated, but not recommended.
ID can be changed using the renumbering function.
The return value is ID (int).

 | masters | Master face/edge/node of the Contact.
The return value is a list of DItem.

 | slaves | Slave face/edge/node of the Contact.
The return value is a list of DItem.

 | parent | A sub-assembly that is the parent of Connection in the assembly tree.
The return value is a list of DItem.

 | isHidden | Determine display state of the Contact.
The return value is True if the Connection is hidden, False if the Connection is displayed.

 | name | Name of the Contact.

 | contactMethod | Method of Contact between master and slave.
The return value is contactMethod (string).

 | tieMethod | Method of Contact between master and slave.
The return value is tieMethod (string).

Attribute​

contactMethod​

 | Name | Description

 | MANUAL_FACE | Manual Face method.

 | MANUAL_GROUP | Manual Group method.

 | BY_GROUP_MATRIX | By Group Matrix method.

 | SHARE_FACE | Share Face method.

 | AUTO_SETTING | Auto Setting method.

 | METHOD_UNKNOWN | Undefined Method.

tieMethod​

 | Name | Description

 | CONTACT_TIED | Tied contact.

 | CONTACT_GENERAL | General contact.

 | CONTACT_ALL_SELF | Abaqus' All with self contact.

 | ANSYS_CONTACT_SOLID_SHELL_ASSM | Ansys' Shell-Solid Assy. (Org Mesh) contact.

 | CONTACT_TIED_WITH_FRICTIONLESS_SLIDING | SunShine's Tied w/ Frictionless sliding contact.

 | CONTACT_TIED_MAINTAIN_GAP | MSC Nastran's Tied & Maintain Gap contact.

 | CONTACT_TIED_FULL_MOMENT_MAINTAIN_GAP | MSC Nastran's  Tied & Full moment & Maintain Gap contact.

 | CONTACT_TIED_FULL_MOMENT | MSC Nastran's Tied & Full moment contact.

 | METHOD_UNKNOWN | Undefined Method.

# DItem

DItem

Description​

This is an instance of a DItem class, represents any item (e.g. part, face, edge, node, etc.) inside Jupiter.

Properties​

 | Attribute | Description

 | isValid | Determine the validation of the item.
 The return value is True if the item is valid, False if not (invalid).

 | type | Type name of the item.
The return value is Type (string).

 | typeID | Type ID of the item.
The return value is an Int notation of DItem Types (int).

 | tableID | Table ID of the item.
The return value is an Int notation of Table Types (int).

 | id | External ID of the item.
It can be duplicated, but not recommended.
ID can be changed using the renumbering function.
The return value is ID (int).

 | targets | Hold the contents of the item.
The return value is a list of item.

 | masters | Master face/edge/node of the connection/contact.
The return value is a list of DItem.

 | slaves | Slave face/edge/node of the connection/contact.
The return value is a list of DItem.

 | children | A sub-assembly that is the child of an item in the assembly tree.
The return value is a list of DItem.

 | parent | A sub-assembly that is the parent of an item in the assembly tree.
The return value is a list of DItem.

 | info | Model and mesh information if the item is part or bar.

 | isHidden | Determine display state of the item.
The return value is True if the item is hidden, False if the item is displayed.

 | name | Name of the item.

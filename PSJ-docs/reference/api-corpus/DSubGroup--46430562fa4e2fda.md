# DSubGroup

DSubGroup

Description​

This is an instance of a DSubGroup class, represents a sub group inside Jupiter.

Properties​

 | Attribute | Description

 | name | Name of Sub Group.

 | typeID | Type ID of the Sub Group (ID = 78).
The return value is an Int notation of DItem Types (int).

 | id | External ID of the Sub Group.
ID can be duplicated, but not recommended.
ID can be changed using the renumbering function.
The return value is ID (int).

 | parent | Parent Group. 
The return value is a DItem.

 | children | Child groups and Sub Groups that the Sub Group has.
The return value is a list ofDItemVector.

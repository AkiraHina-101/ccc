# DConnect

DConnect

Description​

This is an instance of a DConnect class, represents Connection item inside Jupiter.

Properties​

 | Attribute | Description

 | isValid | Determine the validation of the Connection.
 The return value is True if the Connection is valid, False if not (invalid).

 | type | Type name of the Connection.
The return value is Type (string).

 | typeID | Type ID of the Connection.
The return value is an Int notation of DItem Types (int).

 | tableID | Table ID of the Connection.
The return value is an Int notation of DTable Types (int).

 | id | External ID of the Connection.
It can be duplicated, but not recommended.
ID can be changed using the renumbering function.
The return value is ID (int).

 | targets | Hold the contents of the Connection.
The return value is a list of DItem.

 | masters | Master face/edge/node of the Connection/Contact.
The return value is a list of DItem.

 | slaves | Slave face/edge/node of the Connection/Contact.
The return value is a list of DItem.

 | parent | A sub-assembly that is the parent of Connection in the assembly tree.
The return value is a list of DItem.

 | isHidden | Determine display state of the Connection.
The return value is True if the Connection is hidden, False if the Connection is displayed.

 | name | Name of the Connection.

 | connectMethod | Method of Connection between master and slave.
The return value is connectMethod (string).

 | connectCoord | Reference Coordinate System of Connection. 
The return value is DCoord (object).

 | color* 1 | Connection color information.
This value can be adjusted.
The return value is a RGB color.

Attribute​

connectMethod​

 | Name | Description

 | NODE_TO_NODE | Node to Node method.

 | EDGE_TO_EDGE | Edge to Edge method.

 | FACE_TO_FACE | Face to Face method.

 | NODE_TO_ANY | Node to an arbitrary entity.

 | GROUND_TO_ANY | Ground to an arbitrary entity.

 | EDGE_TO_FACE | Edge to Face method.

 | SEMI_AUTO | Semi auto method.

 | NODES_TO_NODES | Multi Nodes to multi Nodes method.

 | NODE_TO_EDGE | Node to Edge method.

 | FACE_TO_FACE | Face to Face method.

 | CIRCLE_EDGE_CENTER | Circle Edge center method.

 | CIRCLE_FACE_CENTER | Circle Face center method.

 | FACE_CENTER | Face Center method.

 | FACES_TO_FACES | Multi Faces to multi Faces method.

 | NODE_TO_NODES | Node to multi Nodes method.

 | ANY_ENTITIES | Any entities method.

 | ANY_ENTITIES_1V1 | Any entities 1 to 1 method.

 | CENTER_ANY_ENTITIES | Center of any entities method.

 | CIRCLE_CENTER_CIRCUMFERENCE | Circle Center Circumference method.

 | METHOD_UNKNOWN | Undefined Method.

Notice​

Footnotes​

An asterisk symbol * in attribute name means that attribute can be changed/assigned from the current to the new value. ↩

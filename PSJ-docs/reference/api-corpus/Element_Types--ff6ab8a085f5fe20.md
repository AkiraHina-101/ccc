# Element Types

Element Types

An enumeration that represents element types.
The ID of ElemKind and ElemType which is primarily used in functions can be referred to in the Int Notation column.

However, in order to explicitly describe meaning of ID, user can use JPT.ElemKind.ElemKind or JPT.ElemType.ElemType instead of specifying ID.

For example:

JPT.ElemKind.ELEMKIND_2D is equal to ID = 3.

JPT.ElemType.ELEMTYPE_QUAD4 is equal to ID = 6.

 | ElemKind Int Notation | Kind of Elem | Description | ElemType Int Notation | Type of Elem | Definition

 | 1 | ELEMKIND_0D | An element prepared for a node. | 1 | ELEMTYPE_POINT | Vertex element.

 | 2 | ELEMKIND_1D | 1D element (Bar element). | 2 | ELEMTYPE_LINE2 | 1D element (First order element)

 |  |  |  | 3 | ELEMTYPE_LINE3 | 1D element (Second order element)

 | 3 | ELEMKIND_2D | 2D element (Shell element) | 4 | ELEMTYPE_TRI3 | 3-node Triangular element (First order element)

 |  |  |  | 5 | ELEMTYPE_TRI6 | 6-node Triangular element (Second order element)

 |  |  |  | 6 | ELEMTYPE_QUAD4 | 4-node Rectangular element (First order element)

 |  |  |  | 7 | ELEMTYPE_QUAD8 | 8-node Rectangular element (Second order element)

 |  |  |  | 17 | ELEMTYPE_QUAD6 | 6-node Rectangular element (First order element) (2)

 |  |  |  | 18 | ELEMTYPE_QUAD9 | 9-node Rectangular element (Second order element) (2)

 | 4 | ELEMKIND_3D | 3D element (Solid element) | 8 | ELEMTYPE_TET4 | 4-node Tetrahedral element (First order element)

 |  |  |  | 9 | ELEMTYPE_TET10 | 10-node Tetrahedral element (Second order element)

 |  |  |  | 10 | ELEMTYPE_HEX8 | 8-node Hexahedron element (First order element)

 |  |  |  | 11 | ELEMTYPE_HEX20 | 20-node Hexahedron element (Second order element)

 |  |  |  | 12 | ELEMTYPE_PRISM6 | 6-node Pentahedral element (First order element)

 |  |  |  | 13 | ELEMTYPE_PRISM15 | 15-node Pentahedral element (Second order element)

 |  |  |  | 14 | ELEMTYPE_PYRAMID5 | 5-node Pyramid element (First order element)

 |  |  |  | 15 | ELEMTYPE_PYRAMID13 | 13-node Pyramid element (Second order element)

 |  |  |  | 19 | ELEMTYPE_PRISM12 | 12-node Pentahedral element (Second order element) (3)

 |  |  |  | 20 | ELEMTYPE_HEX18 | 18-node Hexahedron element (Second order element) (4)

 | 5 | ELEMKIND_SP | Special element kind (1) | 16 | ELEMTYPE_PLOT | Plot element

 |  |  |  | 21 | ELEMTYPE_RBE | RBE element

 |  |  |  | 22 | ELEMTYPE_MASS | Mass element

 |  |  |  | 23 | ELEMTYPE_VIRTUAL | Virtual element (only ID)

Notice:​

A special element type differs from processing element, used to describe connection element. For example: RBE, Plot, Mass,...↩

Hexahedron element with middle node and center node on top and bottom surfaces.↩

Pentahedral element with middle node on top and bottom surfaces only.↩

This is the axisymmetric semi-infinite heat transfer element for MARC software.↩

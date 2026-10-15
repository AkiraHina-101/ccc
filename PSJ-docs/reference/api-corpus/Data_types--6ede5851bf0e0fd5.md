# Data types

Data types

PSJ has 3 data types:

Python standard built-in type

PSJ-Command type

PSJ-Utility type

PSJ-GUI type

Below session will briefly introduce their structures and usages.

PSJ-Command type​

Data types used by PSJ-Command functions, including:

Built-in type​

There are 2 built-in types:

1. Python Standard built-in type​

The principal built-in types are numerics, sequences, mappings, classes, instances and exceptions.
For more information, please visit Python official document

2. Jupiter advanced built-in type​

Data types used in all PSJ-Commands functions, including: cursor, position, vector, bool, int list, double list, string list, List of Cursor, List of Cursor list, position list, vector list, bool list, cursor pair, cursor pair list, TSheetd

You can see the detailed information here.

Enumerations type​

This includes enumerations used for:

Representing DItem type

Representing element type

Representing data structure of mesh and analysis

PSJ-Utility type​

Data type used by PSJ-Utility functions, including Pre-Utility and Post-Utility:

Pre-Utility​

Data type used for preprocessing workflow, including:

Built-in type​

Data structure used mainly for storing model database at preprocessing workflow, including: BodyVector, ConnectVector, CoordVector, DBody, DConnect, DCoord, DEdge, DElem, DFace, DGroup, DItem, DItemPair, DItemPairVector, DItemVector, DLoadBC, DSolverJob, DNode, Document, DoubleVector, EdgeVector, ElemVector, FaceVector, GroupVector, LoadBCVector, SolverJobVector, NodeVector, StringVector, TVector3d, VersionInfo

You can see the full list here.

Enumerations type​

This includes data structure used for:

Working with unit

Representing associated pick

Representing full link to the specified path

Representing table

Representing boolean

Representing message box type

Representing message box option type

Representing select method

Post-Utility​

Data type used for postprocessing workflow, including:

Built-in type​

Data structure used mainly for storing model database at postprocessing workflow, including: DPostElem, DPostNode, Post data option and Post time step.

You can see the full list here.

Enumerations type​

This includes data structure used for:

Post job type

Post analysis type

Post data range types

Post data location type

Post data conversion type

Post data continuous type

Post data coordinate

Post data 1D type

Post data 2D type

Post data complex type

PSJ-GUI type​

Data types used by PSJ-GUI functions, including:

Built-in type​

Data structure used mainly for working with Jupiter GUI, including: TableCellID, TableCellVector, TableCellRange, TableCellRangeVector, TableColumnInfo, TableColumnInfoVector, PSJFont, PSJMessageBox.

You can see the full list here.

Enumerations type​

This includes data structure used for PSJMessageBox:

MessageBox Icon Types

MessageBox Button Types

MessageBox Position Types

# SetNoteResultDisp()

SetNoteResultDisp()

Description​

Sets the displacement label to be displayed in the notes for the nodes.

Syntax​

SetNoteResultDisp(bool diplay, bool useDefault, string labelName)

Inputs​

1. bool​

Specify whether diplacement label on the notes or not.

0 : Do not display

1 : Display

2. bool​

Specify whether use default label name or not.

0 : Use default label name (Mat ID)

1 : Use user defined label name

3. string​

Specify user defined label name. It is shown if use User defined label name is selected.

Return Code​

Nothing.

Sample Code​

SetNoteElementMatID(1, 0, ")

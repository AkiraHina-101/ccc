# SetNoteElementPropID()

SetNoteElementPropID()

Description​

Sets the element property ID label to be displayed in the notes for the element.

Syntax​

SetNoteElementPropID(bool diplay, bool useDefault, string labelName)

Inputs​

1. bool​

Specify whether display Type label on the notes or not.

0 : Do not display

1 : Display

2. bool​

Specify whether use default label name or not.

0 : Use default label name (Prop ID)

1 : Use user defined label name

3. string​

Specify user defined label name. It is shown if use User defined label name is selected.

Return Code​

Nothing.

Sample Code​

SetNoteElementPropID(1, 0, ")

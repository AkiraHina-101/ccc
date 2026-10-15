# SetNoteResultTitle()

SetNoteResultTitle()

Description​

Sets the data label to be displayed in the notes.
Also, set whether display labels in the notes or not.

Syntax​

SetNoteResultTitle(bool diplay, bool useDefault, string labelName)

Inputs​

1. bool​

Specify whether display labels on the notes or not.

0 : Do not display

1 : Display

2. bool​

Specify whether use default label name for data or not.

0 : Use default label name (Data)

1 : Use user defined label name

3. string​

Specify user defined label name for data. It is shown if use User defined label name is selected.

Return Code​

Nothing.

Sample Code​

SetNoteResultTitle(1, 0, ")

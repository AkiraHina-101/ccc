# EditCustomNoteWndPosition()

EditCustomNoteWndPosition()

Description​

Move custom note to specified position indicated in screen coordinate system.
The position specifies center position of the note.

*The screen coordinate system is expressed in two-dimensional coordinates with the origin (0,0) at the upper left edge of the main window.

Syntax​

EditCustomNoteWndPosition(cursor customNote, double x, double y)

Inputs​

1. cursor ​

Specify the custom note to move.

2. double ​

Specify the x position by screen coordinate.

3. bool ​

Specify the y position by screen coordinate.

Return Code​

Nothing.

Sample Code​

EditCustomNoteWndPosition(270:1,100,200)

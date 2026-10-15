# CreateCustomNote()

CreateCustomNote()

Description​

Create a custom note or edit an exist custom note.

Syntax​

CreateCustomNote(string noteName, double[] position, bool createNewCollection, cursor entity, cursor customNoteCollection, string collectionName, string[] content, int fontSize, color fontColor, int bold, color bgColor, int width, color outlineColor, int size, color arrowColor, int type, int alignment, cursor customNote)

Inputs​

1. string ​

Specifies the name of the custom note.

2. double[] ​

Specifies the position of the note by coordinate [x,y,z].

3. bool ​

Specifies whether it create a new collection or not.

0 : no

1 : yes

4. cursor ​

Specifies the target entity which the custom note is created on. Set 0:0 if no target.

5. cursor ​

Specifies a custom note collection where the new custom note is append. Set 0:0 if create a new collection.

6. string ​

Specifies the name of new custom note collection if createNewCollection is 1.

7. string[] ​

Describe content in the format of a list of string. When writing multiple lines of content, list multiple strings here.

8. int ​

Specifies the font size of the text of Content.

9. color ​

Specifies the color of the text of Content.

10. int ​

Bold text or not in the Content. Set 1 and bold.

11. color ​

Specifies the ground color of the creating custom note.

12. int ​

Specifies the width of the note border.

13. color ​

Specifies the color of the note border.

14. int ​

Specifies the thickness of the line extending from the note to the coordinate position. Setting it to 0 hides the line.

15. color ​

Specifies the color of the line extending from the note to the coordinate position.

16. int ​

Specifies the shape type that points to the coordinate position.

0: "None"

1: "Arrow"

17. int ​

Specify the alignment type. Currently, no setting is available (always 0).

18. cursor ​

Specify the custom note to edit. Set 0:0 if create a new note.

Return Code​

Nothing.

Sample Code​

CreateCustomNote("CustomNote_1", [0, 0, 0], 0, 0:0, 0:0, "Collection_1", ["1st Line","2nd Line","3rd Line"], 30, 0, 0, 16777215, 1, 0, 1, 0, 1, 0, 0:0)

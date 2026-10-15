# DCustomNote

DCustomNote

Description​

This is an instance of a DCustomNote class, represents a custom note inside Jupiter.

Properties​

 | Attribute | Description

 | typeID | Type ID of the custom note (ID = 270).
The return value is an Int notation of DItem Types (int).

 | tableID | Table ID of the custom note item (ID = 154). The return value is an Int notation of DTable Types(int).

 | id | External ID of the custom note.
The return value is ID (int).

 | name | Name of the custom note.
The return value is a string.

 | target_type | Type of the type of target entity which the custom note is created on. The return value is:
0 (None),
1 (Node),
2 (1D Element),
3 (2D Element),
4 (3D Element),
5 (Face Point),
  6 (Edge Point).

 | target_pos | Position coordinate of the Custom Note.
 The return value is TVector3d.

 | target_item | The target entity which the custom note is created on. The return value is a DItem.

 | parent | The custom note collection where the new custom note is append.
 The return value is DCustomNoteCollection.

 | content | Content of the Custom Note. 
 The return value is the list of strings.

 | font_size | The font size of the text of Content. 
 The return value is int.

 | font_color | The color of the text of Content. 
 The return value is a RGB color.

 | font_bold | Bold text or not in the Content.
 The return value is 0 or 1 (bold)

 | bgcolor | The ground color of the Custom Note.
 The return value is a RGB color.

 | outline_width | The width of the note border.
 The return value is int.

 | outline_color | The color of the note border.
 The return value is a RGB color.

 | arrow_width | The thickness of the line extending from the note to the coordinate position.
The return value is int.

 | arrow_color | The color of the line extending from the note to the coordinate position.
The return value is a RGB color.

 | arrow_type | The shape type that points to the coordinate position.
 The return value is 0 (None) or 1 (Arrow)

 | alignment | The alignment type.
 Currently, no setting is available. The return value is always 0.

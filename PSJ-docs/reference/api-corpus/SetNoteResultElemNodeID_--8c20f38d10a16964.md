# SetNoteResultElemNodeID()

SetNoteResultElemNodeID()

Description​

Set the node ID or element ID of the entity to be displayed in the note window.

Syntax​

SetNoteResultElemNodeID(bool NoteResultElemNodeID, int NoteResultElemNodeID, string NoteResultElemNodeID)

Inputs​

1. bool​

A Boolean specifying whether to display the ID of Elements/Nodes in the note window.

2. int​

An Integer specifying the method to display the Element/Node ID title as default or user-defined name.

3. string​

A String specifying an arbitrary user-defined name for the Element/Node ID title.

Return Code​

"1": Succeeded.

"0": Failed.

Sample Code​

SetNoteResultElemNodeID(True, 0, "ELem/NodeID")

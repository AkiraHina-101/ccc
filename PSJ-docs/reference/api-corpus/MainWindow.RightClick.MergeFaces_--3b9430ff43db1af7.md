# MainWindow.RightClick.MergeFaces()

MainWindow.RightClick.MergeFaces()

Description​

Merge Faces

Syntax​

MainWindow.RightClick.MergeFaces(crlFaces, bIsMergeEdge=False, bRemoveNonBoundEdge=True)

Ribbon: MainWindow » RightClick » MergeFaces

Inputs​

crlFaces​

A List of Cursor specifying the face.

This is a required input.

bIsMergeEdge​

A Boolean specifying the is merge edge.

The default value is False.

bRemoveNonBoundEdge​

A Boolean specifying the remove non boundary edge.

The default value is True.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

MainWindow.RightClick.MergeFaces(crlFaces, bIsMergeEdge=False, bRemoveNonBoundEdge=True)

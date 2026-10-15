# Home.Windows.FrameCancel()

Home.Windows.FrameCancel()

Description​

Reset placement of document windows to the original (full window).

Syntax​

Home.Windows.FrameCancel(...)

Macro: FrameLessCancel

Ribbon: Home » Windows » Cancel

Inputs​

This function does not require any input value.

Return Code​

A Boolean specifying whether the function is executed successfully or not.

True: The function successfully executed.

False: The function cannot be executed.

Sample Code​

# Prepare 2 JPT documents
JPT.CreateNewDocument()
JPT.CreateNewDocument()
Home.Windows.TileHorizontal(iMode=0)

# Cancel to the full window display.
Home.Windows.FrameCancel()

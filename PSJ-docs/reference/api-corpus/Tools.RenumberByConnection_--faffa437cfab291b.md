# Tools.RenumberByConnection()

Tools.RenumberByConnection()

Description​

Renumber by selection

Syntax​

Tools.RenumberByConnection(connectRenumberTool=CONNECT_RENUMBER_TOOL(), crlTargets=[])

Ribbon: Tools » RenumberByConnection

Inputs​

connectRenumberTool​

A CONNECT_RENUMBER_TOOL specifying the renumber tool.

The default value is CONNECT_RENUMBER_TOOL().

crlTargets​

A List of Cursor specifying the target.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Tools.RenumberByConnection(connectRenumberTool=CONNECT_RENUMBER_TOOL(), crlTargets=[])

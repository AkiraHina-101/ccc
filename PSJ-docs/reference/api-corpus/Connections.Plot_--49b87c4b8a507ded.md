# Connections.Plot()

Connections.Plot()

Description​

Create 1D plot connection.

Syntax​

Connections.Plot(...)

Macro: Property1DPlot

Ribbon: Connections » Plot

Inputs​

strName​

A String specifying the name of the 1D plot connection to be created.

The default value is "PLOT_1".

iPID​

An Integer specifying the ID of the 1D plot connection to be created.

The default value is 1.

crlTargets​

A List of Cursor specifying the list of the selected targets to set Nastran data plot. This targets can be bar part, 1D edge, element edge, or node.

This is the require input.

crEdit​

A Cursor specifying an existing connection plot.

If this parameter is used, the specified connection plot will be modified.

If it is left None, a new connection plot will be created.

The default value is None.

Return Code​

A Cursor specifying the created or the modified connection.

Sample Code​

Geometry.Part.Cube()
created_connection = Connections.Plot(crlTargets=[Edge(18)])
JPT.Debugger(created_connection)

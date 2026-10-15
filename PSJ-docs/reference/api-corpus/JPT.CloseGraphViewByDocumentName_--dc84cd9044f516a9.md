# JPT.CloseGraphViewByDocumentName()

JPT.CloseGraphViewByDocumentName()

Description​

Close all the graph views (graph windows) belongs to indicated document.

Syntax​

JPT.CloseGraphViewByDocumentName(...)

Inputs​

documentName​

A value indicates document to close graph views that belongs to.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

path=JPT.GetProgramPath()
sampleFolder=r'\SampleData\PSJ\PSJ-Utility\PostSample'

#Import data and load result
file='/101_solid.op2'
data=path+sampleFolder+file
resultDoc=JPT.GetActiveDocument()
JPT.Exec(f'CmdImportTSVOp2Post({data}, 1, 1.0472, 1.0472, 0, 0, 0)')
JPT.Exec('CmdShowPostContour(183:1, {1, 0, 1, 1, Displacement, Translational, 1}, {1, 1, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')
JPT.Exec('CmdShowPostDeformation(183:1, 1, 0, 1, 1, Displacement, Translational, 0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)')
JPT.Exec('WatchNode([10:62, 10:72, 10:60, 10:114, 10:112, 10:127])')

# Create graph in the new graph view.
JPT.Exec('PostCreateGraph(0:0, 6, "Nodal value for X Y Plot", [1, 2, 3, 4, 5, 6], [0.000737348, 0.000694131, 0.00165532, 0, 0.000768533, 0.00168554], "Nodal value for X Y Plot", "Index", "Data", 0)')
JPT.Exec('CmdDataPaneXYPlot()')
JPT.Exec('CmdDataPaneDeleteAll()')
JPT.Exec('WatchNode([10:5, 10:16, 10:8, 10:15, 10:7, 10:114, 10:109])')

# Create another graph in the new graph view.
JPT.SetActiveDocument(resultDoc.docID, 1)
JPT.Exec('PostCreateGraph(0:0, 7, "Nodal value for X Y Plot", [1, 2, 3, 4, 5, 6, 7], [0.000710007, 0.00165532, 0.000863714, 0.000871377, 0.000812666, 0.000378784, 0], "Nodal value for X Y Plot", "Index", "Data", 0)')
JPT.Exec('CmdDataPaneXYPlot()')

# Import another data and load result.
file='/103_solid.op2'
data=path+sampleFolder+file

#Import another data and load result
JPT.Exec('New Document()')
JPT.Exec(f'CmdImportTSVOp2Post({data}, 1, 1.0472, 1.0472, 0, 0, 0)')
JPT.Exec('CmdShowPostContour(183:1, {2, 0, 1, 1, Stress, YY, 4}, {1, 1, 0, 0, 1, 8, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)')
JPT.Exec('CmdShowPostDeformation(183:1, 2, 0, 1, 1, Stress, YY, 0, 0.000000, 0, 0.070000, 0, 0.070000, 0.070000, 0.070000, 0)')
JPT.Exec('ViewShowMesh(1)')
JPT.Exec('WatchNode([10:131, 10:127, 10:129, 10:45])')

# Create graph in the new graph view.
JPT.Exec('PostCreateGraph(0:0, 4, "Nodal value for X Y Plot", [1, 2, 3, 4], [-5.43454e+06, 5.42161e+06, 3.55735e+06, 5.42161e+06], "Nodal value for X Y Plot", "Index", "Data", 0)')
JPT.Exec('CmdDataPaneXYPlot()')

# Close all the graph views.
JPT.CloseGraphViewByDocumentName('101_solid')

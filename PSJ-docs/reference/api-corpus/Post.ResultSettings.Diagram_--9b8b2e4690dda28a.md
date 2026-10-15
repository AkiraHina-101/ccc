# Post.ResultSettings.Diagram()

Post.ResultSettings.Diagram()

Description​

Set up the result settings for displaying the diagram.

Syntax​

Post.ResultSettings.Diagram(...)

Macro: CmdPostDiagramSettings

Ribbon: Post » ResultSettings » Diagram

Inputs​

postDataVizOptDiagram​

A POST_DATA_VIZ_OPT_DIAGRAM specifying all settings of the diagram display.

The default value is POST_DATA_VIZ_OPT_DIAGRAM.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Post.ResultSettings.Diagram(postDataVizOptDiagram=PostDataVizOptDiagram(dRatioModel=0.05, dRatioScreen=0.05))

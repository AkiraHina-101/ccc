# CmdNStepPlotNode()

CmdNStepPlotNode()

Description​

Execute N-Step Plot (node)

Syntax​

CmdNStepPlotNode(cursor PostJob, int[] nodes, [int analysisType, int resultSet, int timeStep], bool CreateMarkup, string XResult, string XComponent, int XLoc)

Inputs​

3-5 are a set of a plot target list.

1. int  ​

Post job.

2. cursor[]  ​

List of target nodes

3. int  ​

Analysis type

4. int  ​

Result set

5. int  ​

Time Step

6. bool  ​

Create notes on nodes or not

7. string  ​

X Axis Data - Result.

8. int  ​

X Axis Data - Component

9. int  ​

X Axis Data - Data Location

Return Code​

Nothing.

Sample Code​

CmdNStepPlotNode(183:1, [988], [[1,0,0], [1,1,5], [1,2,5], [1,3,5], [1,4,5]], 1)

# PostCreateGraph()

PostCreateGraph()

Description​

Create graph.

Syntax​

PostCreateGraph(cursor RefAnalysis, int np, string curveTitle, float[] xpos, float[] ypos, string graphTitle, string XAxisTitle, string YAxisTitle, bool newChart)

Inputs​

1. cursor ​

Frequency analysis' cursor. If here is not 0:0, from 2 to 5 are omitted.

2. int ​

The number of plot point.

3. string ​

Curve title.

4. float[] ​

X positions.

5. float[] ​

Y positions.

6. string ​

Graph title.

7. string ​

X axis title.

8. string ​

Y axis title.

9. bool ​

Create a new chart flag.

Return Code​

Nothing.

Sample Code​

PostCreateGraph(0:0, 5, "Curve Title", [0, 3, 5, 7, 10], [0, 1, 2, 5, 20], "Main Title", "X Axis Title", "Y Axis Title", 0)
PostCreateGraph(196:1, "Frequency Analysis Displacement", "Frequency", "Amplitude", 1)

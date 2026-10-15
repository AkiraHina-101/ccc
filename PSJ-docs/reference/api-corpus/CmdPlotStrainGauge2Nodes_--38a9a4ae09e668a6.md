# CmdPlotStrainGauge2Nodes()

CmdPlotStrainGauge2Nodes()

Description​

Import

Syntax​

CmdPlotStrainGauge2Nodes(cursor PostJob, int node1, int node2 vector[] Steps, string AxisXName, string AxisYName, float Height, float Width, float Factor, bool MaxPrincipal, int nPhaseType, float PhaseAngle, bool CreateMarkup)

Inputs​

1. cursor  ​

Post Job

2. int ​

ID of node 1.

3. int ​

ID of node 2.

4. vector[]  ​

Step information vector.

1. int ​

Analysis type

2. int ​

Result set

3. int ​

Time Step

5. string  ​

Name of X Axis.

6. string  ​

Name of Y Axis.

7. float  ​

Gauge - Length

8. float  ​

Gauge - Width

9. float  ​

Gauge - Amend Factor

10. bool  ​

Direction

11. int  ​

Phase Setting - Phase

12. float  ​

Phase Setting - Angle

13. bool  ​

Add Note flag

Return Code​

Nothing.

Sample Code​

CmdPlotStrainGauge2Nodes(183:1, 13388, 13226, [[2,1,1], [2,1,2], [2,1,3], [2,1,4], [2,1,5], [2,1,6], [2,1,7], [2,1,8], [2,1,9], [2,1,10]], "Stress(Element)", "Stress(Element)", 0, 0, 1, -1, 0.000000, 1)

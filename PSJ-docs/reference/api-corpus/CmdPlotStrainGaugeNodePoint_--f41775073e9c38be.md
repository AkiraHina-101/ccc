# CmdPlotStrainGaugeNodePoint()

CmdPlotStrainGaugeNodePoint()

Description​

Import

Syntax​

CmdPlotStrainGaugeNodePoint(cursor PostJob, int node, float[] point, vector[] Steps, string AxisXName, string AxisYName, float Height, float Width, float Factor, bool MaxPrincipal, int nPhaseType, float PhaseAngle, bool CreateMarkup)

Inputs​

1. cursor  ​

Post Job

2. int ​

ID of node.

3. float[] ​

Position vector [x,y,z] 

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

CmdPlotStrainGaugeNodePoint(183:1, 10361, [-0.00216074,-0.00044453,0.000788983], [[2,1,1], [2,1,2], [2,1,4], [2,1,6], [2,1,10]], "Time/Freq(Default)", "Stress(Node)", 0.003, 0.003, 1, -1, 0.000000, 1)

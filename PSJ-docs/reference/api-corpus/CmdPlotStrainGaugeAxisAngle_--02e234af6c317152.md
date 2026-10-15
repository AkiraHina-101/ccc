# CmdPlotStrainGaugeAxisAngle()

CmdPlotStrainGaugeAxisAngle()

Description​

Import

Syntax​

CmdPlotStrainGaugeAxisAngle(cursor PostJob, vector[] Steps, int[] nodes, int Axis1, int Axis2, float Angle, string AxisXName, string AxisYName, float Height, float Width, float Factor, int nPhaseType, float PhaseAngle, bool CreateMarkup)

Time/Freq(Default)", "Stress(Node)", 0.005, 0.005, 1, 1, -1, 0.000000, 1)

Inputs​

1. cursor  ​

Post Job

2. vector[]  ​

Step information vector.

1. int ​

Analysis type

2. int ​

Result set

3. int ​

Time Step

3. int[]  ​

Target node IDs.

4. int  ​

First Axis

5. int  ​

Second Axis

6. float  ​

Angle.

7. string  ​

Name of X Axis.

8. string  ​

Name of Y Axis.

9. float  ​

Gauge - Length

10. float  ​

Gauge - Width

11. float  ​

Gauge - Amend Factor

12. int  ​

Phase Setting - Phase

13. float  ​

Phase Setting - Angle

14. bool  ​

Add Note flag

Return Code​

Nothing.

Sample Code​

CmdPlotStrainGaugeAxisAngle(183:1, [[2,1,1], [2,1,2], [2,1,3], [2,1,4], [2,1,5], [2,1,6], [2,1,7], [2,1,8], [2,1,9], [2,1,10]], [2828], 0, 1, 30.000000, "Time/Freq(Default)", "Stress(Node)", 0.003, 0.003, 1, -1, 0.000000, 1)

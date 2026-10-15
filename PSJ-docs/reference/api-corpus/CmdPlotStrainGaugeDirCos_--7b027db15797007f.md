# CmdPlotStrainGaugeDirCos()

CmdPlotStrainGaugeDirCos()

Description​

Import

Syntax​

CmdPlotStrainGaugeDirCos(cursor PostJob, int[] nodes, vector[] Steps, string AxisXName, string AxisYName, float Height, float Width, float Factor, float[] DirCos, int nPhaseType, float PhaseAngle, bool CreateMarkup)

Inputs​

1. cursor  ​

Post Job

2. int[]  ​

Target node IDs.

3. vector[]  ​

Step information vector.

1. int ​

Analysis type

2. int ​

Result set

3. int ​

Time Step

4. string  ​

Name of X Axis.

5. string  ​

Name of Y Axis.

6. float  ​

Gauge - Length

7. float  ​

Gauge - Width

8. float  ​

Gauge - Amend Factor

9. float[]  ​

Direction vector [x,y,z]

10. int  ​

Phase Setting - Phase

11. float  ​

Phase Setting - Angle

12. bool  ​

Add Note flag

Return Code​

Nothing.

Sample Code​

CmdPlotStrainGaugeDirCos(183:1, [13226], [[2,1,1], [2,1,2], [2,1,3], [2,1,4], [2,1,5], [2,1,6], [2,1,7], [2,1,8], [2,1,9], [2,1,10]], "Time/Freq(Default)", "Stress(Node)", 0.005, 0.005, 1, [1,0,0], -1, 0.000000, 1)

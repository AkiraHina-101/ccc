# CmdAddStrainGaugeTangentProject()

CmdAddStrainGaugeTangentProject()

Description​

Execute Strain Gauge - Tangent Project.

Syntax​

CmdAddStrainGaugeTangentProject(int node, double Width, double Height, double AmendFactor, int Dir, double Angle, float VecSize, string GaugeName)

Inputs​

1. int ​

Target node.

2. double ​

Gauge Width.

3. double ​

Gauge Height.

4. double ​

Amend Factor.

5. int ​

Original Dir

6. double ​

Angle

7. double ​

Vector Size

8. string ​

Gauge name.

Return Code​

Nothing.

Sample Code​

CmdAddStrainGaugeTangentProject(9461, 0.006, 0.006, 2, 0, 0, 1, "")

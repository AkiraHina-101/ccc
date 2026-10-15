# CmdAddStrainGaugeAxisAngle()

CmdAddStrainGaugeAxisAngle()

Description​

Execute Strain Gauge - Axis angle.

Syntax​

CmdAddStrainGaugeAxisAngle(int[] nodes, double Width, double Height, double AmendFactor, string GaugeName)

Inputs​

1. int[] ​

Target nodes.

2. double ​

Gauge Width.

3. double ​

Gauge Height.

4. double ​

Amend Factor.

5. string ​

Gauge name.

Return Code​

Nothing.

Sample Code​

CmdAddStrainGaugeAxisAngle([8538], 0, 1, 0, 0.004, 0.004, 1, "")

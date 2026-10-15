# CmdAddStrainGaugeDirCos()

CmdAddStrainGaugeDirCos()

Description​

Execute Strain Gauge - Direction Cosine.

Syntax​

CmdAddStrainGaugeDirCos(int[] nodes, vector DirInput, double Width, double Height, double AmendFactor, string GaugeName)

Inputs​

1. int[] ​

Target nodes.

2. vector ​

Direction vector x, y, z.

3. double ​

Gauge Width.

4. double ​

Gauge Height.

5. double ​

Amend Factor.

6. string ​

Gauge name.

Return Code​

Nothing.

Sample Code​

CmdAddStrainGaugeDirCos([8475], [0, 0, 1], 0.003, 0.003, 1, "")

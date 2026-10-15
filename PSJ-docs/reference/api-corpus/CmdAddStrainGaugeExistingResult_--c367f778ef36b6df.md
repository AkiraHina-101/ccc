# CmdAddStrainGaugeExistingResult()

CmdAddStrainGaugeExistingResult()

Description​

Execute Strain Gauge - Existing result.

Syntax​

CmdAddStrainGaugeExistingResult(int node, int analysisType, int resultSet, int timeStep, int resultType, double Width, double Height, double AmendFactor, string GaugeName)

Inputs​

1. int ​

Target node.

2. int ​

Analysis Type.

3. int ​

Result Set.

4. int ​

Time step.

5. int ​

Result type.

6. double ​

Gauge Width.

7. double ​

Gauge Height.

8. double ​

Amend Factor.

9. string ​

Gauge name.

Return Code​

Nothing.

Sample Code​

CmdAddStrainGaugeExistingResult(23237, 1, 1, 1, 6, 0.003, 0.003, 1, "")

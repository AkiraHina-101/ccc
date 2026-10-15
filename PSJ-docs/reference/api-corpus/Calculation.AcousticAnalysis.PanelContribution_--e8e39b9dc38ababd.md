# Calculation.AcousticAnalysis.PanelContribution()

Calculation.AcousticAnalysis.PanelContribution()

Description​

Create a plot line for each panel property based on Actran's element contribution results.

Syntax​

Calculation.AcousticAnalysis.PanelContribution(...)

Macro: PostToolAcousticPanelContribution

Ribbon: Calculation » AcousticAnalysis » PanelContribution

Inputs​

ilLoadCases​

A List of Integer specifying the selected loadcases for the element contribution plot line.

The default value is [].

crlProperties​

A List of Cursor specifying the property panels for the element contribution plot line.

The default value is [].

iAreaUnit​

An Integer specifying the area unit.

The default value is 0.

bSum​

A Boolean specifying whether to sum the element contributions.

The default value is True.

Return Code​

A List of Cursor specifying the created panel contribution.

Sample Code​

# Please set path to your sample Nastran Vibro-Acoustic file.
filePath="C:/Temp/Sample.op2"

# Prepare result model
Home.ImportResults.Nastran(strPath=filePath, dFaceAngle=60.16, dEdgeAngle=60.16, bIsVibro=True)

# AcousticAnalysis.PanelContribution
Calculation.AcousticAnalysis.PanelContribution(ilLoadCases=[201], 
                                                crlProperties=[Property2DShell(50000), 
                                                Property3DSolid(20000, 40000)], 
                                                iAreaUnit=0)
Calculation.AcousticAnalysis.PanelContributionCreateGraph(crlLoadCases=[PostActranLoadCase(1, 2, 3, 4)])

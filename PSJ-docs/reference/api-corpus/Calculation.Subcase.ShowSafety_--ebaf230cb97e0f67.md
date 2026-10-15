# Calculation.Subcase.ShowSafety()

Calculation.Subcase.ShowSafety()

Description​

Create a subcase by calculating the safety factor from the selected subcases based on the tolerance of each part.

Syntax​

Calculation.Subcase.ShowSafety(...)

Macro: PostToolsSubcaseSafetyFactor

Ribbon: Calculation » Subcase » ShowSafety

Inputs​

iAnalysisType​

An Integer specifying the analysis type.

The default value is 1.

iResultSet​

An Integer specifying result set.

The default value is 1.

listSubcaseIDs​

A List of Integer specifying the IDs of selected subcases.

The default value is [].

listSafetyItems​

A List of SAFETY_ITEM specifying the safety information of each selected target.

The default value is SAFETY_ITEM.

iSafetyType​

An Integer specifying the type of safety calculation.

0: YIELD STRESS

1: BREAK STRESS

2: FATIGUE LIMIT

The default value is 0.

strResultName​

A String specifying the name of subcase to be created.

The default value is "SafetyYield".

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# Subcase.RelativeOffset
showSafety = Calculation.Subcase.ShowSafety(iAnalysisType=2, 
                                            listSubcaseIDs=[1, 2, 3, 4, 5],
                                            listSafetyItems=[SafetyItem(crPart=Part(1), \
                                            dThreshold=1), \
                                            SafetyItem(crPart=Part(2), \
                                            dThreshold=1), \
                                            SafetyItem(crPart=Part(3), \
                                            dThreshold=1)], 
                                            iSafetyType=1, 
                                            strResultName="Safety Break2")
JPT.Debugger(showSafety)

# Post.SetNote.NumericDisplay()

Post.SetNote.NumericDisplay()

Description​

Set the method to display the numerical value in the note window.

Syntax​

Post.SetNote.NumericDisplay(...)

Macro: SetNoteNumericDisplay

Ribbon: Post » SetNote » NumericDisplay

Inputs​

iNumericDisplay​

An Integer specifying the method to display the numerical value.

If iNumericDisplay = 0: Real Type - Display the numerical values in real number format. The precision is five decimal places.

If iNumericDisplay = 1: Power Type - Display the numerical values in exponential/scientific format.

The default value is 1.

iWidth​

An Integer specifying the display width of the numerical value.

The default value is 10.

iPrecision​

An Integer specifying the number of digits in the decimal part.

The default value is 5.

Return Code​

A Boolean specifying whether the process is executed successfully or not.

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Post model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# Plot the result
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=4))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))
Post.Note.Node(crlTargets=[RONode(133)])

# Display the numerical value as Real Type
Post.SetNote.NumericDisplay(iNumericDisplay=0, iPrecision=6)

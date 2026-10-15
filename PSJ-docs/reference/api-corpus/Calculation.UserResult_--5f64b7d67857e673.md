# Calculation.UserResult()

Calculation.UserResult()

Description​

Any desired result can be created and added to the document by treating the results as variables and passing them to functions.

Syntax​

Calculation.UserResult(...)

Macro: PostCreateUserResult

Ribbon: Calculation » UserResult

Inputs​

crPostJob​

A Cursor specifying the target post job.

The default value is None.

iResultVariableType​

An Integer specifying the result type to make a variable.

0: Unknown

1: Step

2: Result

3: Component

The default value is 1.

strResultName​

A String specifying the result name to make a variable.

The default value is "Expr1".

iResultSet​

An Integer specifying the result set.

The default value is 1.

iTimeStep​

An Integer specifying the time step.

The default value is 1.

listResultVariables​

A List of RESULT_VARIABLE specifying the attributes of the selected result to make a variable.

The default value is RESULT_VARIABLE().

bResultExpression​

A Boolean specifying whether to use the expression to display the result.

The default value is True.

bContourExpression​

A Boolean specifying whether to use the expression to display the contour.

The default value is False.

bVectorExpression​

A Boolean specifying whether to use the expression to display the vector.

The default value is False.

bDisplacementExpression​

A Boolean specifying whether to use the expression to display the displacement.

The default value is False.

iVectorType​

An Integer specifying the type to display the vector.

0: Vector

1: Magnitude and Direction

The default value is 0.

strResultExpression​

A String specifying the calculation formula of the result used for the result display.

The default value is "".

strContourExpression​

A String specifying the calculation formula for the result used for the contour display.

The default value is "".

strVectorExpressionMagnitude​

A String specifying the calculation formula for the result used for the vector display in magnitude. This variable was used when iVectorType = 1.

The default value is "".

strVectorExpressionX​

A String specifying the calculation formula for the result used for the vector display in X direction.

The default value is "".

strVectorExpressionY​

A String specifying the calculation formula for the result used for the vector display in Y direction.

The default value is "".

strVectorExpressionZ​

A String specifying the calculation formula for the result used for the vector display in Z direction.

The default value is "".

strDisplacementExpressionX​

A String specifying the calculation formula of the result used for the deformation display in X direction.

The default value is "".

strDisplacementExpressionY​

A String specifying the calculation formula of the result used for the deformation display in Y direction.

The default value is "".

strDisplacementExpressionZ​

A String specifying the calculation formula of the result used for the deformation display in Z direction.

The default value is "".

bIncrementName​

A Boolean specifying whether to input the increment name.

The default value is False.

strIncrementName​

A String specifying the increment name.

The default value is "".

crEdit​

A Cursor specifying an existing user result item

If this parameter is used, the specified user result item will be modified.

If it is left None, a new user result item will be created.

The default value is None.

Return Code​

A Cursor specifying the created user result item.

Sample Code​

# Prepare result model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# User result
result = Calculation.UserResult(crPostJob=TSVPostJob(1), 
                                iResultVariableType=3, 
                                strResultName="Expr_1", 
                                iResultSet=2, 
                                listResultVariables=[RESULT_VARIABLE(crReferencePostJob=TSVPostJob(1), \
                                strName="C1", iAnalysisType=2, iResultSet=1, iTimeStep=1, iResultPos=1), \
                                RESULT_VARIABLE(crReferencePostJob=TSVPostJob(1), strName="C2", \
                                iAnalysisType=2, iResultSet=1, iTimeStep=1, iResultType=1, iResultPos=1)], 
                                bResultExpression=False, 
                                bContourExpression=True, 
                                strContourExpression="C1+C2")
JPT.Debugger(result)

# ViewFitToModel()

ViewFitToModel()

Description​

Fit model to current screen.

Syntax​

View Fit To Model()

Inputs​

This function does not require any input value.

Return Code​

This utility function does not have output value.

Note​

When this command is used within PSJ code, the screen may be in a different state than expected due to the screen refresh function for animation. In that case, use DisableScreenAnimation() to stop the animation and display only the last frame.

Sample Code​

# psj usage with disable screen animation
Geometry.Part.Cube()
JPT.DisableScreenAnimation()
JPT.Exec("View Fit To Model()")
JPT.Exec("ViewPoint(4)")

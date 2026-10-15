# JPT.Exec()

JPT.Exec()

Description​

Run Jupiter macro.

Syntax​

JPT.Exec(macroCommand)

Inputs​

macroCommand​

A String specifying the macro command.

This is a required input.

Return Code​

Based on the output of the inputted macro command.

Sample Code​

# Create a cube and store its cursor
createdCube = JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], \
                        [10, 10, 10], "Cube_1", 12999622, 0:0)')
JPT.Debugger(createdCube) # Return a string object with value = 3:1

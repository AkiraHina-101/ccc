# Assembly.RightClick.ChangeEntityColor()

Assembly.RightClick.ChangeEntityColor()

Description​

Change color of a specific entity/a list of entities (By ID).

Syntax​

Assembly.RightClick.ChangeEntityColor(...)

Ribbon: None

Inputs​

crlEntities​

A List of Cursor specifying a list of entitiy/entities that its/theirs color will be changed.

This is a required input.

iColor​

An Integer specifying the color for entities.

The default value is 0.

Return Code​

A String specifying whether the color of the inputted entity/entities is changed or not:

1: The color of the inputted entity/entities is changed successfully.

0: The color of the inputted entity/entities cannot be changed.

Sample Code​

Geometry.Part.Cube()
changed_color = Assembly.RightClick.ChangeEntityColor(crlEntities=[Face(26, 24, 22)], iColor=16777088)
JPT.Debugger(changed_color)

# Assembly.RightClick.ChangeBodyColor()

Assembly.RightClick.ChangeBodyColor()

Description​

Change the color of the selected part.

Syntax​

Assembly.RightClick.ChangeBodyColor(...)

Ribbon: Assembly » Right Click » Change Random Color » Surface

Inputs​

listPartColorPair​

A List of PART_COLOR_PAIR specifying a list which contains part and its color.

The default value is [].

bResetFaceColor​

A Boolean specifying whether or not reset face color.

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

adding_status = Assembly.RightClick.ChangeBodyColor(listPartColorPair=[PART_COLOR_PAIR(crPart=Part(1),
                                                                                       iColor=6409934)])

JPT.Debugger(adding_status)

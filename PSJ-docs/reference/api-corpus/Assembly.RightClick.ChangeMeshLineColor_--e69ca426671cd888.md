# Assembly.RightClick.ChangeMeshLineColor()

Assembly.RightClick.ChangeMeshLineColor()

Description​

Change the color of the mesh line of the selected part.

Syntax​

Assembly.RightClick.ChangeMeshLineColor(...)

Ribbon: Assembly » Right Click » Change Single Color » Mesh Line

Inputs​

crlFaces​

A List of Cursor specifying the face which mesh line color will be changed.

This is a required input.

iColor​

An Integer specifying the color.

The default value is 0.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

Geometry.Part.Cube()

changed_status = Assembly.RightClick.ChangeMeshLineColor(crlFaces=[Face(21, 
                                                                        22, 
                                                                        23, 
                                                                        24, 
                                                                        25, 
                                                                        26)], 
                                                         iColor=10535167)

JPT.Debugger(changed_status)

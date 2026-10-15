# MainWindow.RightClick.ShowHideFlip()

MainWindow.RightClick.ShowHideFlip()

Description​

Toggle the display of hidden parts or faces on the current document.

Syntax​

MainWindow.RightClick.ShowHideFlip(...)

Macro: ShowHideFlip

Ribbon: MainWindow » RightClick » ShowHideFlip

Inputs​

iType​

An Integer specifying the target type to toggle the displaying. The target is  Part or Face.

The default value is 0.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare models
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7697908)
JPT.ViewFitToModel()

# Show hide flip parts
flipPart = MainWindow.RightClick.ShowHideFlip(iType=0)
print(flipPart)

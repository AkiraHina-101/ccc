# 🆕 PSJ-Command

🆕 PSJ-Command

Introduction​

Equivalent to Macro, but PSJ-Command is polished to be compact, easy to write and fully Python compatible.
This new PSJ feature is introduced from Jupiter version 5.

Special features​

Class-based format​

PSJ-Command's functions are named after Class-based format and Jupiter’s ribbon.

For example, making a cube with default input values:

PSJ-Command

Macro

Geometry.Part.Cube(dlOrigin=[0, 0, 0], dlLength=[0.01, 0.01, 0.01], ilAxialNodes=[10, 10, 10],
  strName="Cube_1", iPartColor=7105764, crLocalCoordinate=None)

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0)

PSJ-Command's arguments follow our standard naming convention

Compact​

PSJ-Command's parameters are neglected if the default values are taken.

For example, making a cube with default input values:

PSJ-Command

Macro

Geometry.Part.Cube()

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0)

Explicit​

PSJ-Command is easier to read thanks to its explicit definitions.

For example, imprinting a line on a face between 2 points:

PSJ-Command

Macro

Geometry.Edge.Line(dllPoints=[[0.0078, 0, 0.01], [0.0023, 0.01, 0.01]], crlFaces=[Face(26)])

ImprintLineS([[7.8, 0, 10], [2.2, 10, 10]], [6:26], 1)

Return value​

PSJ-Command has return value which can make the code looks more Pythonic.

For example, deleting 2 cubes just created:

PSJ-Command

Macro

cube1 = Geometry.Part.Cube()
cube2 = Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.DeleteEntity.Part(crlParts=[cube1, cube2])

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0)
CreateCube([10, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_2", 6409934, 0:0)
DeletePartCr([3:1, 3:2])

Error handling​

PSJ-Command has error handling built-in which can help developer found the bug faster and easier.

For example, inputting a code with a wrong format as below:

# Below input has wrong name in the second parameter
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strame="Cube_1")

After running the above code, the error will be shown in the Python API window:

note

PSJ interpreter will raise error (exception) when it can not find an entity in database (a database query error). With a wrong input argument (entity ID) then it can lead to a query error rather than return a failed result.

IDE supported​

PSJ-Command is fully supported by our customized IDE or VSCode extensions.

Read more

To get the full list of available PSJ-Command, please refer to the Scripting API.

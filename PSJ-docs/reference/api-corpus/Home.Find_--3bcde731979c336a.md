# Home.Find()

Home.Find()

Description​

Search entities in Jupiter by using their IDs or names.

Syntax​

Home.Find(...)

Ribbon: Home » Find

Inputs​

strSearch​

A String specifying the search ID or name of the target you want to search.

The default value is "".

strSelectedType​

A String specifying the searching type. The searching type is one of the following.
"Part": Part Search.

"Face": Face Search.

"Edge": Edge Search.

"Vertex": Vertex Search.

"3D Element": 3D Element Search.

"2D Element": 2D Element Search.

"1D Element": 1D Element Search.

"Node": Node Search.

"Group": Group Search.

"Force": Force Search.

"Pressure": Pressure Search.

"Constraint": Constraint Search.

"DoF Set": DoF Set Search.

"Centrifugal Force": Centrifugal Force Search.

"Gravity": Gravity Search.

"Weld": Weld Search.

"Connection": Connection Search.

"Contact": Contact Search.

"Coordinate": Coordinate Search.

"Local Mesh Settings": Local Mesh Settings Search.

"Property": Property Search.

The default value is "Part".

bFindMatch​

A Boolean enables/disables the find matching option. if this option is turned on, the strSearch need to match the whole string.

The default value is False.

Return Code​

A List of Cursor specifying all found entities.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01,
                             0.0,
                             0.0],
                   strName="Cube_2",
                   iPartColor=6409934)

find_name = Home.Find(strSearch="cube")
find_name_match = Home.Find(strSearch="cube_2",
                            bFindMatch=True)
find_id = Home.Find(strSearch="1")

JPT.Debugger(find_name)

JPT.Debugger(find_name_match)

JPT.Debugger(find_id)

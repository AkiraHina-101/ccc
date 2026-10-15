# Geometry.MergeEntities.TinyFacesMerge()

Geometry.MergeEntities.TinyFacesMerge()

Description​

Merge tiny faces either by extending the user selection or using only the selected faces.

Syntax​

Geometry.MergeEntities.TinyFacesMerge(...)

Ribbon: Geometry » Merge Entities » Tiny Faces Merge

Inputs​

strMethod​

A String specifying the method use to merge. Possible values are AUTO, SELECT, MERGE, RESTORE.

The default value is AUTO.

crlTargets​

A List of Cursor specifying the parts or faces to be merged.

The default value is [].

dMinFaceWidth​

A Double specifying the minimum face width in meter. This argument is used when strMethod has the value AUTO or SELECT.

The default value is 0.0.

dMaxFaceWidth​

A Double specifying the maximum face width in meter. This argument is used when strMethod has the value AUTO or SELECT.

The default value is 0.001.

dFaceAngle​

A Double specifying the angle between faces in degree. This argument is used when strMethod has the value AUTO or MERGE.

The default value is 30.

bReferLocalSetting​

A Boolean specifying whether to refer to the local setting or not.

The default value is False.

bConnectFace​

A Boolean specifying whether to connect faces after the merge operation is executed.

The default value is False.

Return Code​

A Boolean specifying whether the function is executed successfully or not:

True: The function is executed successfully.

False: The function cannot be executed.

Sample Code​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6409934)
Geometry.Edge.Angle([CursorPair(Node(945), Node(953))])
Geometry.Edge.Angle([CursorPair(Node(464), Node(472))])
Geometry.Edge.Angle([CursorPair(Node(79), Node(432))])
Geometry.Edge.Angle([CursorPair(Node(96), Node(487))])
Geometry.Edge.Angle([CursorPair(Node(470), Node(479))])
Geometry.Edge.Angle([CursorPair(Node(471), Node(479))])
Geometry.Edge.Angle([CursorPair(Node(946), Node(954))])
Geometry.Edge.Angle([CursorPair(Node(953), Node(954))])
Geometry.Edge.Angle([CursorPair(Node(961), Node(962))])
Geometry.Edge.Angle([CursorPair(Node(953), Node(962))])
merged_entities = Geometry.MergeEntities.TinyFacesMerge(crlTargets=[Part(1, 2)],
                                                        bCreateRefPart=True)
JPT.Debugger(merged_entities)

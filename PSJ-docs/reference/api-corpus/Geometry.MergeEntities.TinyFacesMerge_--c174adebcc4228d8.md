# Geometry.MergeEntities.TinyFacesMerge()

Geometry.MergeEntities.TinyFacesMerge()

説明​

ユーザー選択を拡張するか、選択したフェースのみを使用して、小さなフェースをマージします。

構文​

Geometry.MergeEntities.TinyFacesMerge(...)

リッボン: Geometry » Merge Entities » Tiny Faces Merge

入力​

strMethod​

マージに使用する方法を指定する String です。有効な値は AUTO, SELECT, MERGE, RESTORE です。

デフォルト値は AUTO です。

crlTargets​

マージするパートまたはフェースを指定する Cursor のリストです。

デフォルト値は []  です。

dMinFaceWidth​

メートル単位の最小フェース幅を指定する Double です。 strMethod の値が AUTO または SELECT の場合に使用されます。

デフォルト値は 0.0 です。

dMaxFaceWidth​

メートル単位の最大フェース幅を指定する Double です。 strMethod の値が AUTO または SELECT の場合に使用されます。

デフォルト値は 0.001 です。

dFaceAngle​

フェース間の角度を度で指定する Double です。 strMethod の値が AUTO または MERGE の場合に使用されます。

デフォルト値は 30 です。

bReferLocalSetting​

ローカル設定を参照するかどうかを指定する Boolean です。

デフォルト値は False です。

bConnectFace​

マージ操作の実行後にフェースを接続するかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: 関数は正常に実行されました。

False: 関数を実行できません。

サンプルコード​

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

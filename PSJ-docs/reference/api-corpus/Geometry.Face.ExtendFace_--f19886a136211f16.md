# Geometry.Face.ExtendFace()

Geometry.Face.ExtendFace()

説明​

エッジから拡張されたフェースを作成します。

構文​

Geometry.Face.ExtendFace(...)

マクロ：ExtendFace

リボン：Geometry » Face » ExtendFace

入力​

crEdge​

ソースエッジを指定する Cursor です。

これは必須の入力です。

crFace​

Metric が "Offset" または "Cylinder" に設定されている場合、ターゲットフェースを指定する Cursor です。

デフォルト値は None です。

crRefFace​

Metric が "Cylinder" に設定され、Method が "To Face" の場合、参照フェースを指定する Cursor です。

デフォルト値は None です。

crFirstNode​

Metric が "2Nodes" による軸の設定に使用する最初の節点を指定する Cursor です。

デフォルト値は None です。

crSecondNode​

Metric が "2Nodes" による軸の設定に使用する2番目の節点を指定する Cursor です。

デフォルト値は None です。

crElemEdge​

Metric が "Element Edge" による軸の設定に使用する要素エッジを指定する CursorPair です。

デフォルト値は [] です。

extendFaceDirection​

拡張フェースの3D次元での方向設定を指定する EXTEND_FACE_DIRECTION のクラスです。

デフォルト値はEXTEND_FACE_DIRECTIONです。

extendFaceMesh​

拡張されたフェースのメッシュ設定を指定する EXTEND_FACE_MESH のクラスです。

デフォルト値はEXTEND_FACE_MESHです。

extendFaceOption​

拡張フェースの幾何学的設定を指定する EXTEND_FACE_OPTION のクラスです。

デフォルト値はEXTEND_FACE_OPTIONです。

戻り値​

新しく作成されたフェースを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
created_face = Geometry.Face.ExtendFace(crEdge=Edge(19), 
                                      extendFaceDirection=EXTEND_FACE_DIRECTION(
                                          dComponentX=0, 
                                          dComponentZ=0), 
                                      extendFaceMesh=EXTEND_FACE_MESH(), 
                                      extendFaceOption=EXTEND_FACE_OPTION())
JPT.Debugger(created_face)

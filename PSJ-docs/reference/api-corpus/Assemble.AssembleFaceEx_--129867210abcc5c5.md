# Assemble.AssembleFaceEx()

Assemble.AssembleFaceEx()

説明​

フェースを組み立てます（共有面）。
ユーザーはAssemble.FindMatingFaceEx() 関数から出力されるペアフェースを入力し、作成された新しい共有面 ID のリストが返されます。

構文​

Assemble.AssembleFaceEx(...)

リボン: Assemble » Assemble Faces

入力​

ilPairFaceToMakeShareFace​

共有面を作成するためのペアフェースを指定する_Integer_のリスト。

これは必須の入力です。

dTolerance​

許容値を指定する_Double_型の値。

デフォルト値は0.1です。

iTypeConnectPos​

接続位置の種類を指定する_Integer_。

デフォルト値は1です。

bFitEdge​

エッジの適合オプションを指定する_Boolean_。

デフォルト値は False です。

戻り値​

作成された新しい共有面 ID のリスト。

サンプルコード​

cube1 = Geometry.Part.Cube()
cube2 = Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0], 
                           strName="Cube_2", 
                           iPartColor=6409934)

pair_faces = Assemble.FindMatingFaceEx(crlTaBodies=[cube1, cube2], 
                                       dMatingTol=0.001)

share_faces = Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace = pair_faces, 
                                      dTolerance=0.001,
                                      iTypeConnectPos=0, 
                                      bFitEdge=True)

JPT.Debugger(share_faces)

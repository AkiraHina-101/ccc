# Assemble.SharedFace()

Assemble.SharedFace()

説明​

組み立てられたフェース/共有面 グループを作成します。

構文​

Assemble.SharedFace(...)

マクロ: CreateSharedFace

リボン: Assemble » Shared Face

入力​

この関数には入力値が含まれていません。

戻り値​

作成された共有面を指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=15658599)
Geometry.Part.Cube(dlOrigin=[0.01, 0.01, 0.0], 
                   strName="Cube_3", 
                   iPartColor=14903267)

Assemble.FindMatingFaceEx(crlTaBodies=[Part(1, 
                                            2, 
                                            3)], 
                          dMatingTol=0.000222222)
Assemble.AssembleFaceEx(ilPairFaceToMakeShareFace=[48, 
                                                   73, 
                                                   49, 
                                                   24], 
                        dTolerance=0.000222222, 
                        iTypeConnectPos=0, 
                        bFitEdge=True)

created_shared_faces = Assemble.SharedFace()

JPT.Debugger(created_shared_faces)

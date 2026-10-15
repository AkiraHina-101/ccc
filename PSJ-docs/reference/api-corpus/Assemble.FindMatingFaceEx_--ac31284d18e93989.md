# Assemble.FindMatingFaceEx()

Assemble.FindMatingFaceEx()

説明​

Assemble.AssembleFaceEx() 関数で使用可能な対合フェースを見つけます。

構文​

Assemble.FindMatingFaceEx(...)

リボン：Assemble » Find Mating Face

入力​

crlTaBodies​

アセンブルフェースを作成するパートを指定する Cursor のリスト。

これは必須入力です。

crlMasterFace​

マスターフェースを指定する Cursor のリスト。

デフォルト値は [] です。

crlSlaveFace​

スレーブフェースを指定する Cursor のリスト。

デフォルト値は [] です。

dTolerance​

許容差を指定する Double 。

デフォルト値は 0.1 です。

戻り値​

見つかったペア対合フェースIDのリスト。

サンプルコード​

cube1 = Geometry.Part.Cube()
cube2 = Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0], 
                           strName="Cube_2", 
                           iPartColor=6409934)

pair_faces = Assemble.FindMatingFaceEx(crlTaBodies=[cube1, cube2], 
                                      dMatingTol=0.001)

JPT.Debugger(pair_faces)

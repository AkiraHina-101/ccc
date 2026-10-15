# Geometry.BodyCut.BySurface()

Geometry.BodyCut.BySurface()

説明​

与えられた切断面（フェースを選択して）を使用してパートを分割して、対象のパートを分割します。

構文​

Geometry.BodyCut.BySurface(...)

マクロ: BodyCutBySurfaceS

リボン: Geometry » Body Cut » By Surface

入力​

crlParts​

分割するパートを指定する Cursor のリスト。

これは必須の入力です。

crCutter​

切断するフェースを指定する Cursor 。

これは必須の入力です。

bSplitOnly​

指定されたパートを二つに分割しないようにするかどうかを指定する Boolean 。

True の場合、指定されたパートは分割されず、単に切断面で分割されます。

False の場合、指定されたパートは二つに分割されます。

デフォルト値は False です。

bMakeSectionFace​

分割セクションで断面フェースを生成するかどうかを指定する Boolean 。

デフォルト値は True です。

bSharedFace​

分割セクションで共有面を生成するかどうかを指定する Boolean 。この引数は、bMakeSectionFace=True かつ bSplitOnly=False の機能にのみ影響します。

デフォルト値は False です。

bSeparateFace​

区画内でセクションフェースがカップリング（マージ）されないようにするかどうかを指定する Boolean 。このオプションは、bMakeSectionFace=True の場合のみ機能します。

True の場合、セクションフェースは個別に作成されます。

False の場合、セクションフェースは1つだけ作成されます。

デフォルト値は False です。

戻り値​

新しいパートを指定する Cursor のリスト。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cylinder(dlOrigin=[0.005, -0.002, 0.005], 
                       dTopOuterRadius=0.002,
                       dBottomOuterRadius=0.002, 
                       dHeight=0.014)

Geometry.DeleteEntity.Face(crlFaces=[Face(29, 30)])

separated_bodies = Geometry.BodyCut.BySurface(crlParts=[Part(1)], 
                                              crCutter=Part(2), 
                                              bSharedFace=True)

JPT.Debugger(separated_bodies)

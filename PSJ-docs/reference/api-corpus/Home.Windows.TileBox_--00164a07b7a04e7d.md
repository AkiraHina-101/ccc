# Home.Windows.TileBox()

Home.Windows.TileBox()

説明​

ボックスのように、開かれたドキュメントを垂直および水平に配置して表示します。

構文​

Home.Windows.TileBox(...)

マクロ：FrameLessBoxMode1, FrameLessBoxMode2

リボン：Home » Windows » TileBox

入力​

iMode​

配置モードを指定する Integer です。

1：モード 1

2：モード 2

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを示す Boolean 型です：

True：プロセスが正常に実行されました。

False：機能を実行できません。

サンプルコード​

# JPTドキュメントを2つ準備します
Geometry.Part.Cube()
JPT.ViewFitToModel()
JPT.CreateNewDocument()
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# ボックス配置
Home.Windows.TileBox(iMode=1)

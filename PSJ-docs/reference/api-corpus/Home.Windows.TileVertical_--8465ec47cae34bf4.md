# Home.Windows.TileVertical()

Home.Windows.TileVertical()

説明​

ドキュメントを縦に並べて表示します。

構文​

Home.Windows.TileVertical(...)

マクロ: TileVertical, FrameLessVerticalMode1, FrameLessVerticalMode2, FrameLessVerticalMode3, FrameLessVerticalMode4, FrameLessVerticalMode5, FrameLessVerticalMode6, FrameLessVerticalMode7

リボン: Home » Windows » TileVertical

入力​

iMode​

縦の配置モードを指定する Integer 。

0: 縦に並べる。

1: モード 1。

2: モード 2。

3: モード 3。

4: モード 4。

5: モード 5。

6: モード 6。

7: モード 7。

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスが正常に実行されました。

False: 機能を実行できません。

サンプルコード​

# JPT ドキュメント2つを準備
Geometry.Part.Cube()
JPT.ViewFitToModel()
JPT.CreateNewDocument()
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# 縦に並べる
Home.Windows.TileVertical(iMode=0)

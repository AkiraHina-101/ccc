# Home.Windows.TileHorizontal()

Home.Windows.TileHorizontal()

説明​

開いているドキュメントを水平に配置して表示します。

構文​

Home.Windows.TileHorizontal(...)

マクロ: TileHorizontal, FrameLessHorizontalMode1, FrameLessHorizontalMode2, FrameLessHorizontalMode3, FrameLessHorizontalMode4, FrameLessHorizontalMode5, FrameLessHorizontalMode6, FrameLessHorizontalMode7

リボン: Home » Windows » TileHorizontal

入力​

iMode​

配置モードを指定する Integer の数値です。

0: タイル水平。

1: モード1。

2: モード2。

3: モード3。

4: モード4。

5: モード5。

6: モード6。

7: モード7。

この項目は必須です。

戻り値​

プロセスの実行が成功したかどうかを示す Boolean 型の値:

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# JPTドキュメントを2つ準備
Geometry.Part.Cube()
JPT.ViewFitToModel()
JPT.CreateNewDocument()
Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
JPT.ViewFitToModel()

# タイル水平配置
Home.Windows.TileHorizontal(iMode=0)

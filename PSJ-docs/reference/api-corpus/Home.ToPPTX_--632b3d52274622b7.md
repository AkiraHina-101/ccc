# Home.ToPPTX()

Home.ToPPTX()

説明​

Jupiterの表示ウィンドウをpptx形式の画像ファイルに保存します。

構文​

Home.ToPPTX(...)

リボン: Home » ToImage

入力​

bAutoCapture​

要素範囲ごとに画像を切り取るかどうかを指定する Boolean です。

デフォルト値は False です。

listAdjust​

最小化領域から左、上、右、下のマージンを指定する Integer のリストです。

デフォルト値は [0,0,0,0] です。

戻り値​

プロセスの状態を指定する Boolean 型です:

True: Jupiterの表示ウィンドウがpptx形式の画像ファイルに保存されます。

False: Jupiterの表示ウィンドウをpptx形式の画像ファイルに保存できません。

サンプルコード​

Geometry.Part.Cube()
JPT.DisableScreenAnimation()
JPT.ViewFitToModel()

copy_paste = Home.ToPPTX()

JPT.Debugger(copy_paste)

export_status = Home.ToPPTX(bAutoCapture=True, 
                            listAdjust=[10,20,10,20])

JPT.Debugger(copy_paste)

# Home.RectangularCapture.Clipboard()

Home.RectangularCapture.Clipboard()

説明​

メインウィンドウ内の指定された領域をクリップボードにキャプチャします。

構文​

Home.RectangularCapture.Clipboard(...)

マクロ: Capture_Rectangular()

リボン: Home » RectangularCapture » Clipboard

入力​

iLeft​

画像の左側のピクセル位置を指定する Integer の値です。

デフォルト値は0です。

iTop​

画像の上部のピクセル位置を指定する Integer の値です。

デフォルト値は0です。

iRight​

画像の右側のピクセル位置を指定する Integer の値です。

デフォルト値は0です。

iBottom​

画像の下部のピクセル位置を指定する Integer の値です。

デフォルト値は0です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型の値です。

サンプルコード​

Geometry.Part.Cube()
JPT.ViewFitToModel
Home.RectangularCapture.Clipboard(
    iLeft=157, 
    iTop=175, 
    iRight=408, 
    iBottom=297)

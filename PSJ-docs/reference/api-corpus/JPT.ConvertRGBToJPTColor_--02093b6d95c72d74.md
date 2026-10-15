# JPT.ConvertRGBToJPTColor()

JPT.ConvertRGBToJPTColor()

説明​

RGB（赤、緑、青）カラーコードをJupiterのカラー値に変換します。

構文​

JPT.ConvertRGBToJPTColor(redValue, greenValue, blueValue)

入力​

redValue​

赤色のカラーコードを指定する Integer です。

この入力は必須です。

greenValue​

緑色のカラーコードを指定する Integer です。

この入力は必須です。

blueValue​

青色のカラーコードを指定する Integer です。

この入力は必須です。

返却コード​

Jupiterでのカラーコードを指定する Integer です。

サンプルコード​

# RGBカラーコードをJupiterでのカラーコードに変換
newColor = JPT.ConvertRGBToJPTColor(255,100,213) # ピンク色
JPT.Debugger(newColor)

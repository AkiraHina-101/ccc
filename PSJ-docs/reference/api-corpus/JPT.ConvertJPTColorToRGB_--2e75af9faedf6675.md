# JPT.ConvertJPTColorToRGB()

JPT.ConvertJPTColorToRGB()

説明​

Jupiterの色値をRGB（Red、Green、Blue）コードを指定する String に変換します。

構文​

JPT.ConvertJPTColorToRGB(colorValue)

入力​

colorValue​

Jupiterの色値を指定する Integer です。

これは必須入力です。

戻り値​

RGBコードを値 = RGB(redCode, greenCode, blueCode) で指定する String です。

サンプルコード​

# Jupiterで色コード = 255 をRGB色コードに変換します
stringRGB = JPT.ConvertJPTColorToRGB(255) # RGB(255,0,0) が返されます
# RGBコードを分割して、赤、緑、青の色コードとして保存します
r, g, b = stringRGB[4:-1].strip().split(",") # String = RGB(255,0,0) -> List = [255, 0, 0]
print(f"この関数の出力値: {stringRGB}")
print(f"意味は: 赤 = {r} | 緑 = {g} | 青 = {b}")

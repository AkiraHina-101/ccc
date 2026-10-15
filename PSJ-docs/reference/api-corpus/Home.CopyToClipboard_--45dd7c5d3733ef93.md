# Home.CopyToClipboard()

Home.CopyToClipboard()

説明​

Jupiterの現在の表示ウィンドウをクリップボードに保存します。

構文​

Home.CopyToClipboard(...)

Ribbon: Home » CopyToClipboard

入力​

bWhiteBG​

背景色を白に設定するかどうかを指定する Boolean 型。

デフォルト値は False です。

bTransparentBG​

背景色を透明に設定するかどうかを指定する Boolean 型。
このオプションは、画像の拡張子が.pngの場合のみ有効です。また、bWhiteBG が True に設定されている場合は使用できません。

デフォルト値は False です。

bFixedSize​

エクスポート画像のサイズを固定するかどうかを指定する Boolean 型。
このパラメータが True の場合、画像は iExportWidth と iExportHeight で指定されたサイズでエクスポートされます。
このパラメータが False の場合、エクスポート画像のサイズは表示ウィンドウのサイズと同じです。

デフォルト値は False です。

iWidth​

エクスポート画像の幅を指定する Integer 。

デフォルト値は 1200 です。

iHeight​

エクスポート画像の高さを指定する Integer 。

デフォルト値は 900 です。

bAutoCapture​

表示されるエンティティ範囲に画像を切り取るかどうかを指定する Boolean 型。

デフォルト値は False です。

listAdjust​

最小化された領域からの左、上、右、下の余白を指定する Integer のリスト。

デフォルト値は [0,0,0,0] です。

戻り値​

プロセスの状態を指定する Boolean 型:

True: Jupiterの現在の表示ウィンドウがクリップボードに保存されます。

False: 現在の表示ウィンドウをクリップボードに保存できません。

サンプルコード​

Geometry.Part.Cube()
JPT.DisableScreenAnimation()
JPT.ViewFitToModel()

copy = Home.CopyToClipboard(bWhiteBG=False,
                            bTransparentBG=False,
                            bFixedSize=False,
                            iWidth=1200,
                            iHeight=900)

JPT.Debugger(copy)

copy = Home.CopyToClipboard(bWhiteBG=False,
                            bTransparentBG=False,
                            bFixedSize=False,
                            iWidth=1200,
                            iHeight=900,
                            bAutoCapture=True, 
                            listAdjust=[10,20,10,20])

JPT.Debugger(copy)

# Assembly.RightClick.AddToReference()

Assembly.RightClick.AddToReference()

説明​

現在のパートをその参照に追加し、追加されたパートを現在の参照パートとして使用します。

構文​

Assembly.RightClick.AddToReference(...)

リボン: Assembly » Right Click » Add To Reference

入力​

crSrcPart​

宛先パートの参照として使用されるソースパートを指定する Cursor です。

これは必須の入力です。

crDestPart​

宛先パートを指定する Cursor です。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

adding_status = Assembly.RightClick.AddToReference(crSrcPart=Part(1), 
                                                   crDestPart=Part(1))

JPT.Debugger(adding_status)

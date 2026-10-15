# Assembly.RightClick.ChangeBodyColor()

Assembly.RightClick.ChangeBodyColor()

説明​

選択したパートの色を変更します。

構文​

Assembly.RightClick.ChangeBodyColor(...)

リボン: Assembly » Right Click » Change Random Color » Surface

入力​

listPartColorPair​

パートとその色を含むリストを指定する PART_COLOR_PAIR のリスト。

デフォルト値は[]です。

bResetFaceColor​

フェースの色をリセットするかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 値：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

adding_status = Assembly.RightClick.ChangeBodyColor(listPartColorPair=[PART_COLOR_PAIR(crPart=Part(1),
                                                                                       iColor=6409934)])

JPT.Debugger(adding_status)

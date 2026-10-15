# Assembly.RightClick.AddSubAssembly()

Assembly.RightClick.AddSubAssembly()

説明​

選択した組立体に新しいアセンブリ（サブアセンブリ）を追加します。

構文​

Assembly.RightClick.AddSubAssembly(...)

リボン: Assembly » Right Click » Add Subassembly

入力​

crInst​

新しいサブアセンブリが追加されるインスタンスを指定する Cursor です。

デフォルト値は None です。

戻り値​

作成されたサブアセンブリを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

Assembly.RightClick.AddSubAssembly()
created_sub_assem = Assembly.RightClick.AddSubAssembly(crInst=Inst(1))

JPT.Debugger(created_sub_assem)

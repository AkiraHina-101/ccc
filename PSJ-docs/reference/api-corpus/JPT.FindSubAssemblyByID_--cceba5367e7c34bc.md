# JPT.FindSubAssemblyByID()

JPT.FindSubAssemblyByID()

説明​

IDによって対象のサブアセンブリの関連情報を取得します。

構文​

JPT.FindSubAssemblyByID(subAssemID)

入力​

subAssemID​

対象のサブアセンブリのIDを指定する Integer です。

この入力は必須です。

戻り値​

対象のサブアセンブリの情報を指定する DItem オブジェクトです。

サンプルコード​

# すべてのパートアセンブリの下に2つのサブアセンブリを作成します
JPT.CreateSubAssembly('CreateSubAsm0',JPT.DItem())
JPT.CreateSubAssembly('CreateSubAsm1',JPT.DItem())
JPT.ViewFitToModel()

# ID = 1のサブアセンブリの情報を取得します
JPT.Debugger(JPT.FindSubAssemblyByID(1))

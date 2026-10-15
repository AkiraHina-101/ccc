# JPT.FindSubAssemblyByName()

JPT.FindSubAssemblyByName()

説明​

ターゲットのサブアセンブリの関連情報を名前で取得します。

構文​

JPT.FindSubAssemblyByName(subAssemName)

入力​

subAssemName​

ターゲットのサブアセンブリの名前を指定する String です。

これは必須の入力です。

戻り値​

見つかったサブアセンブリを指定する DItemVector オブジェクトまたは DItem のリストです。

サンプルコード​

# 全パートアセンブリに2つのサブアセンブリを作成します
JPT.CreateSubAssembly('CreateSubAsm0',JPT.DItem())
JPT.CreateSubAssembly('CreateSubAsm1',JPT.DItem())
JPT.ViewFitToModel()

# 名前が「CreateSubAsm0」のサブアセンブリの情報を取得します
JPT.Debugger(JPT.FindSubAssemblyByName('CreateSubAsm0'))

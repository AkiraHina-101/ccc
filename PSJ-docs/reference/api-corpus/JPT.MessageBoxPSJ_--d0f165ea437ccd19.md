# JPT.MessageBoxPSJ()

JPT.MessageBoxPSJ()

説明​

Jupiterのダイアログを表示します（情報、警告）。

構文​

JPT.MessageBoxPSJ(messageContent, messageBoxType)

入力​

messageContent​

作成されたメッセージボックスに表示されるメッセージを指定する String 。

この入力は必須です。

messageBoxType​

Jupiterでメッセージボックスを作成するタイプを表す Enum 型。

この入力は必須です。

戻り値​

選択したオプション（YES、NO、OK、CANCEL）。

サンプルコード​

# 情報メッセージボックスを表示
returnValue = JPT.MessageBoxPSJ("テストダイアログ", JPT.MsgBoxType.MB_INFORMATION_OK)
JPT.Debugger(returnValue) # OK の値を持つ文字列オブジェクトを返します

# Assembly.RightClick.Rename()

Assembly.RightClick.Rename()

説明​

指定されたエンティティの名前を変更します。

構文​

Assembly.RightClick.Rename(...)

マクロ: RenameItem

リボン: Assembly » RightClick » Rename

入力​

strNewName​

項目の新しい名前を指定する String です。

デフォルト値は「新しい名前」です。

crItem​

名前が変更される項目を指定する Cursor です。

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

rename_status = Assembly.RightClick.Rename(strNewName="新しい箱", 
                                           crItem=Part(1))

JPT.Debugger(rename_status)

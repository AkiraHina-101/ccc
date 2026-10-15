# Properties.Section.Delete()

Properties.Section.Delete()

説明​

1D プロパティセクションライブラリ内の作成プロパティセクションを削除します。

構文​

Properties.Section.Delete(...)

リボン: Properties » Section » Delete

入力​

crlセクション​

削除されるプロパティセクションのリストを指定する Cursor のリストです。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Properties.Section.AddGeneral(strName="abc", 
                              iSecGenType=2, 
                              dDsecGensizeT1=0.02)

creating_status = Properties.Section.Delete(crlSections=[SectionGeneral(1)])

JPT.Debugger(creating_status)

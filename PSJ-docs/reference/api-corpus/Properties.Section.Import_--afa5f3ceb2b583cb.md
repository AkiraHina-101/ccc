# Properties.Section.Import()

Properties.Section.Import()

説明​

XMLファイルから1Dセクションをセクションライブラリにインポートします。

構文​

Properties.Section.Import(...)

リボン: Properties » Section » Import

入力​

strPath​

1Dセクションファイルへのパスを指定する String です。

これは必須の入力です。

戻り値コード​

プロセスの実行が成功したかどうかを指定する Boolean 型です:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

from os import environ

Properties.Section.AddGeneral(strName="Section_1", 
                              iSecGenType=2, 
                              dDsecGensizeT1=0.02)

path = environ["Temp"] + r"/TechnoStar/Section_Export_File.xml"

Properties.Section.Export(strPath = path)
Properties.Section.Delete(crlSections=[SectionGeneral(1)])

result = Properties.Section.Import(strPath=path)

JPT.Debugger(result)

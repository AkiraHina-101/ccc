# Connections.Contacts.TSSolver.ManualFace()

Connections.Contacts.TSSolver.ManualFace()

説明​

TSソルバーの指定されたフェース間の接触設定を定義します。

構文​

Connections.Contacts.TSSolver.ManualFace(...)

リボン: Connections » Contacts » TSSolver » ManualFace

入力​

strName​

作成される接触の名前を指定する String です。

デフォルト値は"ContactTSSolver_1" です。

tssolverContact​

TSSolver 接触パラメータを指定する TSSOLVER_CONTACT のリストです。

デフォルト値は TSSOLVER_CONTACT です。

crplTarget​

マスターフェースとスレーブフェースのリストまたはペアを指定する Cursor Pair のリストです。

これは必須の入力です。

crEdit​

既存の接触設定アイテムを指定する Cursor です。

このパラメータを使用すると、指定された接触設定アイテムが変更されます。

もし None のままにすると、新しい接触設定アイテムが作成されます。

デフォルト値は None です。

iColor​

接触の色を指定する Integer です。

デフォルト値は16711680 です。

戻り値​

作成された接触を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.015, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)

Tools.Group.CreateGroup(strGroupName="ContactTSSolver_1_Manual_Face_M", 
                        crlTargets=[Face(49)])
Tools.Group.CreateGroup(strGroupName="ContactTSSolver_1_Manual_Face_S", 
                        crlTargets=[Face(24)])

created_contact = Connections.Contacts.TSSolver.ManualFace(tssolverContact=TSSOLVER_CONTACT(iIshellelemfaceSlave=0, 
                                                                                            iIshellelemfaceMaster=0), 
                                                           crplTarget=[CursorPair(Group(1), 
                                                                                  Group(2))])

JPT.Debugger(created_contact)

# Connections.Contacts.TSSolver.ManualGroup()

Connections.Contacts.TSSolver.ManualGroup()

説明​

指定したグループ間のTS SunShineソルバー用接触設定を定義します。接触設定で接触を定義するために、事前にマスターサーフェスとスレーブサーフェスを含むグループを作成してください。

構文​

Connections.Contacts.TSSolver.ManualGroup(...)

リボン：Connections » Contacts » TSSolver » ManualGroup

入力​

strName​

接触の名前を指定する String です。

デフォルト値は "ContactTSSolver_1" です。

tssolverContact​

TSSolverの接触パラメータを指定する TSSOLVER_CONTACT リストです。

デフォルト値は [] です。

crplTarget​

マスターフェースグループとスレーブフェースグループのリストまたはペアを指定する Cursor Pair リストです。

これは必須入力です。

crEdit​

既存の接触設定アイテムを指定する Cursor です：

このパラメータを使用すると、指定された接触設定アイテムが変更されます。

None のままにしておくと、新しい接触設定アイテムが作成されます。

デフォルト値は None です。

iColor​

接触の色を指定する Integer です。

デフォルト値は 16711680 です。

戻り値​

作成された接触を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=12537679)
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6250449)

Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_M", 
                        crlTargets=[Face(49)])
Tools.Group.CreateGroup(strGroupName="ContactAbaqus_1_Manual_Face_S", 
                        crlTargets=[Face(24)])

created_contact = Connections.Contacts.TSSolver.ManualGroup(strName="ContactTSSolver_2", 
                                                            tssolverContact=TSSOLVER_CONTACT(iIshellelemfaceSlave=0, 
                                                                                             iIshellelemfaceMaster=0), 
                                                            crplTarget=[CursorPair(Group(1), 
                                                                                   Group(2))], 
                                                            iMethod=1)

JPT.Debugger(created_contact)

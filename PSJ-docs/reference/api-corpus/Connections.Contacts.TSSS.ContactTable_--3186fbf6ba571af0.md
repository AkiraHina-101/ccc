# Connections.Contacts.TSSS.ContactTable()

Connections.Contacts.TSSS.ContactTable()

説明​

表を使用してTSサンシャインソルバーの接触を作成します。

構文​

Connections.Contacts.TSSS.ContactTable(...)

リボン: Connections » Contacts » TSSS » ContactTable

入力​

strName​

接触名を指定する String です。

デフォルト値は "ContactTS_SS_1" です。

nastranContact​

サンシャイン接触パラメータを指定する SUNSHINE_CONTACT です。

デフォルト値は SUNSHINE_CONTACT です。

crplTarget​

リストまたはグループマスターフェースとグループスレーブフェースのリストまたはペアを指定する Cursor Pair リストです。

デフォルト値は [] です。

crEdit​

既存の接触設定項目を指定する Cursor です。このパラメーターを使用すると、指定された接触設定項目が変更されます。 None のままにしておくと、新しい接触設定項目が作成されます。

デフォルト値は None です。

iColor​

接触の色を指定する Integer です。

デフォルト値は 0 です。

戻り値​

作成された接触を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], 
                   strName="Cube_2", 
                   iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], 
                   strName="Cube_3", 
                   iPartColor=6417130)
Geometry.Part.Cube(dlOrigin=[0.01, 0.01, 0.0], 
                   strName="Cube_4", 
                   iPartColor=6053060)

Tools.Group.CreateGroup(strGroupName="Cube_3(73)-G0002", 
                        crlTargets=[Face(73)])
Tools.Group.CreateGroup(strGroupName="Cube_1(22)-G0001", 
                        crlTargets=[Face(22)])

created_contact_1 = Connections.Contacts.TSSS.ContactTable(strName="C0001_Cube_3-G0002_Cube_1-G0001", 
                                                           sunshineContact=SUNSHINE_CONTACT(iType=1, 
                                                                                            dERROR=0.001, 
                                                                                            dFRIC=DFLT_DBL, 
                                                                                            dSLIDE=DFLT_DBL, 
                                                                                            iICOORD=DFLT_INT, 
                                                                                            dSFACT=DFLT_DBL, 
                                                                                            dSFACTT=0.5, 
                                                                                            dCDAMP=DFLT_DBL, 
                                                                                            iIshellelemfaceSlave=1, 
                                                                                            iIshellelemfaceMaster=1), 
                                                           crplTarget=[CursorPair(Group(1), 
                                                                                  Group(2))], 
                                                           iColor=65280)

Tools.Group.CreateGroup(strGroupName="Cube_4(99)-G0004", 
                        crlTargets=[Face(99)])
Tools.Group.CreateGroup(strGroupName="Cube_2(48)-G0003", 
                        crlTargets=[Face(48)])

created_contact_2 = Connections.Contacts.TSSS.ContactTable(strName="C0002_Cube_4-G0004_Cube_2-G0003", 
                                                           sunshineContact=SUNSHINE_CONTACT(iType=1, 
                                                                                            dERROR=0.001, 
                                                                                            dFRIC=DFLT_DBL, 
                                                                                            dSLIDE=DFLT_DBL, 
                                                                                            iICOORD=DFLT_INT, 
                                                                                            dSFACT=DFLT_DBL, 
                                                                                            dSFACTT=0.5, 
                                                                                            dCDAMP=DFLT_DBL, 
                                                                                            iIshellelemfaceSlave=1, 
                                                                                            iIshellelemfaceMaster=1), 
                                                           crplTarget=[CursorPair(Group(3), 
                                                                                  Group(4))], 
                                                           iColor=65280)

Tools.Group.CreateGroup(strGroupName="Cube_2(49)-G0006", 
                        crlTargets=[Face(49)])
Tools.Group.CreateGroup(strGroupName="Cube_1(24)-G0005", 
                        crlTargets=[Face(24)])

created_contact_3 = Connections.Contacts.TSSS.ContactTable(strName="C0003_Cube_2-G0006_Cube_1-G0005", 
                                                           sunshineContact=SUNSHINE_CONTACT(iType=1, 
                                                                                            dERROR=0.001, 
                                                                                            dFRIC=DFLT_DBL, 
                                                                                            dSLIDE=DFLT_DBL, 
                                                                                            iICOORD=DFLT_INT, 
                                                                                            dSFACT=DFLT_DBL, 
                                                                                            dSFACTT=0.5, 
                                                                                            dCDAMP=DFLT_DBL, 
                                                                                            iIshellelemfaceSlave=1, 
                                                                                            iIshellelemfaceMaster=1), 
                                                           crplTarget=[CursorPair(Group(5), 
                                                                                  Group(6))], 
                                                           iColor=65280)

Tools.Group.CreateGroup(strGroupName="Cube_3(76)-G0007", 
                        crlTargets=[Face(76)])
Tools.Group.CreateGroup(strGroupName="Cube_4(101)-G0008", 
                        crlTargets=[Face(101)])

created_contact_4 = Connections.Contacts.TSSS.ContactTable(strName="C0004_Cube_3-G0007_Cube_4-G0008", 
                                                           sunshineContact=SUNSHINE_CONTACT(iType=1, 
                                                                                            dERROR=0.001, 
                                                                                            dFRIC=DFLT_DBL, 
                                                                                            dSLIDE=DFLT_DBL, 
                                                                                            iICOORD=DFLT_INT, 
                                                                                            dSFACT=DFLT_DBL, 
                                                                                            dSFACTT=0.5, 
                                                                                            dCDAMP=DFLT_DBL, 
                                                                                            iIshellelemfaceSlave=1, 
                                                                                            iIshellelemfaceMaster=1), 
                                                           crplTarget=[CursorPair(Group(7), 
                                                                                  Group(8))], 
                                                           iColor=65280)

Tools.Group.CreateGroup(strGroupName="Cube_4(99)-G0010", 
                        crlTargets=[Face(99, 101)])
Tools.Group.CreateGroup(strGroupName="Cube_1(22)-G0009", 
                        crlTargets=[Face(22, 24)])

created_contact_5 = Connections.Contacts.TSSS.ContactTable(strName="C0005_Cube_4-G0010_Cube_1-G0009", 
                                                           sunshineContact=SUNSHINE_CONTACT(iType=1, 
                                                                                            dERROR=0.001, 
                                                                                            dFRIC=DFLT_DBL, 
                                                                                            dSLIDE=DFLT_DBL, 
                                                                                            iICOORD=DFLT_INT, 
                                                                                            dSFACT=DFLT_DBL, 
                                                                                            dSFACTT=0.5, 
                                                                                            dCDAMP=DFLT_DBL, 
                                                                                            iIshellelemfaceSlave=1, 
                                                                                            iIshellelemfaceMaster=1), 
                                                           crplTarget=[CursorPair(Group(9), 
                                                                                  Group(10))], 
                                                           iColor=65280)

Tools.Group.CreateGroup(strGroupName="Cube_3(73)-G0012", 
                        crlTargets=[Face(73, 76)])
Tools.Group.CreateGroup(strGroupName="Cube_2(48)-G0011", 
                        crlTargets=[Face(48, 49)])

created_contact_6 = Connections.Contacts.TSSS.ContactTable(strName="C0006_Cube_3-G0012_Cube_2-G0011", 
                                                           sunshineContact=SUNSHINE_CONTACT(iType=1, 
                                                                                            dERROR=0.001, 
                                                                                            dFRIC=DFLT_DBL, 
                                                                                            dSLIDE=DFLT_DBL, 
                                                                                            iICOORD=DFLT_INT, 
                                                                                            dSFACT=DFLT_DBL, 
                                                                                            dSFACTT=0.5, 
                                                                                            dCDAMP=DFLT_DBL, 
                                                                                            iIshellelemfaceSlave=1, 
                                                                                            iIshellelemfaceMaster=1), 
                                                           crplTarget=[CursorPair(Group(11), 
                                                                                  Group(12))], 
                                                           iColor=65280)

JPT.Debugger(created_contact_1)
JPT.Debugger(created_contact_2)
JPT.Debugger(created_contact_3)
JPT.Debugger(created_contact_4)
JPT.Debugger(created_contact_5)
JPT.Debugger(created_contact_6)

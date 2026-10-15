# Connections.Contacts.TSSS.ManualGroup()

Connections.Contacts.TSSS.ManualGroup()

説明​

このメソッドは、指定されたグループ間の接触設定をTechnoStar SunShineソルバーで定義します。

構文​

Connections.Contacts.TSSS.ManualGroup(...)

リボン: Connections » Contacts » SunShine » Manual Group

入力​

strName​

接触名を指定する String です。

デフォルト値は「ContactTS_SS_1」です。

sunshineContact​

Sunshine接触パラメータを指定する SUNSHINE_CONTACT です。

デフォルト値は SUNSHINE_CONTACT です。

crplTarget​

マスターグループとスレーブグループのペアを指定する Cursor ペアのリストです。

デフォルト値は [] です。

crEdit​

既存のSunShine接触設定を指定する Cursor です。この引数が指定されている場合、指定されたSunShine接触設定が修正されます。指定されていない場合、新しいSunShine接触設定が作成されます。

デフォルト値は None です。

iColor​

表示マーカーの色を指定する Integer です。

デフォルト値は 0 です。

iMethod​

メソッドを指定する Integer です。

デフォルト値は 1 です。

戻り値​

成功した場合は 1 の String、失敗した場合は 0 です。

サンプルコード​

Geometry.Part.Cube()

Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=4803000)

Connections.Contacts.SunShine.ManualFace(crlMasterFaces=[Face(24)], crlSlaveFaces=[Face(49)],
    strName="ContactSunShine_1", sunshineContact=SUNSHINE_CONTACT(dERROR=0.001, dFRIC=0.5,
    dSLIDE=DFLT_DBL, iICOORD=DFLT_INT, dSFACT=DFLT_DBL, dSFACTT=0.5, dCDAMP=DFLT_DBL),
    iContactColor=16711680)

Connections.Contacts.TSSS.ManualGroup(strName="ContactSunShine_2", iColor=16711680,
    sunshineContact=SUNSHINE_CONTACT(dERROR=1e-06, dFRIC=0.5, dSLIDE=DFLT_DBL, iICOORD=DFLT_INT,
    dSFACT=DFLT_DBL, dSFACTT=0.5, dCDAMP=DFLT_DBL), crplTarget=[CursorPair(Group(1), Group(2))])

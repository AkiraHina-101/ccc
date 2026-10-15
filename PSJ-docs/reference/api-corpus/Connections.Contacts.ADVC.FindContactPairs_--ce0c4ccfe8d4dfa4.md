# Connections.Contacts.ADVC.FindContactPairs()

Connections.Contacts.ADVC.FindContactPairs()

説明​

接触ペアを検索します。

構文​

Connections.Contacts.ADVC.FindContactPairs(...)

リボン: Connections » Contacts » ADVC » FindContact

入力​

crlParts​

対象パートを指定する List of Cursor。

これは必須の入力です。

dFindTolerance​

接触を検索する許容差を指定する Double。

デフォルト値は0.0002です。

dTolForTIED​

結合（tied）を設定する距離を指定する Double。

デフォルト値は0.1です。

戻り値​

接触のパラメータを指定する stAdvcParam。

サンプルコード​

Geometry.Part.Cube(
  iPartColor=6409934)
Geometry.Part.Cube(
  dlOrigin=[0.01, 0.0, 0.0], 
  strName="Cube_2", 
  iPartColor=7463537)
Geometry.Part.Cube(
  dlOrigin=[0.02, 0.0, 0.0], 
  strName="Cube_3", 
  iPartColor=7666683)

cont=Connections.Contacts.ADVC.FindContactPairs(
    crlParts=[Part(1, 2, 3)], 
    dFindTolerance=0.0002, 
    dTolForTIED=0.1)

for c in cont:
    c.stAdvcParam.dClearance=0.1234

Connections.Contacts.ADVC.ContactTable_Advc(cont)

# Connections.Connector()

Connections.Connector()

説明​

指定された接続タイプに従って、節点、エッジ、およびフェース間にコネクタを作成します。 ユーザーはマスター/スレーブ・ターゲットを選択し、コネクタを使用してマスター/スレーブ・ターゲット上の節点を互いに接続します。

構文​

Connections.Connector(...)

マクロ: Connector

リボン: Connections » Connector

入力​

strName​

作成される接続の名前を指定する String 。

デフォルト値は "Connector_1" です。

iMethod​

接続方法を指定する Integer 。

iMethod=1 の場合、方法は「節点から節点」です。

iMethod=2 の場合、方法は「エッジからエッジ」です。

iMethod=3 の場合、方法は「フェースからフェース」です。

デフォルト値は 1 です。

iConnectType​

接続タイプを指定する Integer 。

iConnectType=0 の場合、接続タイプは「平行」です。

iConnectType=1 の場合、接続タイプは「平行移動」です。

iConnectType=2 の場合、接続タイプは「回転」です。

iConnectType=3 の場合、接続タイプは「ブッシング」です。

iConnectType=4 の場合、接続タイプは「円筒」です。

iConnectType=5 の場合、接続タイプは「ジョイント」です。

iConnectType=6 の場合、接続タイプは「剛棒」です。

iConnectType=7 の場合、接続タイプは「剛性バー」です。

デフォルト値は 0 です。

iRefNode​

座標系を決定する際に参照する節点を指定する Integer 。

iRefNode=0 の場合、最初の節点を参照します。

iRefNode=1 の場合、2番目の節点を参照します。

デフォルト値は 0 です。

iElemCs​

要素座標系を使用するかどうかを指定する Integer 。

iElemCs=0 の場合、要素座標系を使用しません。

iElemCs=1 の場合、要素座標系を使用します。

デフォルト値は 0 です。

crLocalCS​

ローカル座標系を指定する Cursor 型。

デフォルト値は None です。

crlElasticity​

弾性特性のテーブルデータを指定する List of Cursor 型。

デフォルト値は [] です。

crlDamp​

粘性特性のテーブルデータを指定する List of Cursor 型。

デフォルト値は [] です。

crlMasterTargets​

マスターターゲットのリストを指定する List of Cursor 型。

iMethod が 1 の場合、ターゲットは節点です。

iMethod が 2 の場合、ターゲットはエッジです。

iMethod が 3 の場合、ターゲットはフェースです。

デフォルト値は [] です。

crlSlaveTargets​

スレーブターゲットのリストを指定する List of Cursor 型。

iMethod が 1 の場合、ターゲットは節点です。

iMethod が 2 の場合、ターゲットはエッジです。

iMethod が 3 の場合、ターゲットはフェースです。

デフォルト値は [] です。

crEdit​

既存の接続を指定する Cursor 型。

このパラメータを使用すると、指定された接続が変更されます。

None のままにすると、新しい接続が作成されます。

デフォルト値は None です。

戻り値​

作成された接触を指定する Cursor 型。

サンプルコード​

Geometry.Part.Cube()

created_contact = Connections.Connector(strName="Connector_1", 
                                        iMethod=3, 
                                        crlElasticity=[Unknown(0, 
                                                               0, 
                                                               0, 
                                                               0,
                                                               0, 
                                                               0)], 
                                        crlDamp=[Unknown(0, 
                                                         0, 
                                                         0, 
                                                         0, 
                                                         0, 
                                                         0)], 
                                        crlMasterTargets=[Face(22)], 
                                        crlSlaveTargets=[Face(21)])

JPT.Debugger(created_contact)

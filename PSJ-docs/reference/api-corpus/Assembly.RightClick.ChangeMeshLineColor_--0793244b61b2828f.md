# Assembly.RightClick.ChangeMeshLineColor()

Assembly.RightClick.ChangeMeshLineColor()

説明​

選択されたパートのメッシュラインの色を変更します。

構文​

Assembly.RightClick.ChangeMeshLineColor(...)

リボン：Assembly » Right Click » Change Single Color » Mesh Line

入力​

crlFaces​

メッシュラインの色を変更するフェースを指定する Cursor のリストです。

この入力は必須です。

iColor​

色を指定する Integer です。

デフォルト値は0です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True：プロセスは正常に実行されました。

False：関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

changed_status = Assembly.RightClick.ChangeMeshLineColor(crlFaces=[Face(21, 
                                                                        22, 
                                                                        23, 
                                                                        24, 
                                                                        25, 
                                                                        26)], 
                                                         iColor=10535167)

JPT.Debugger(changed_status)

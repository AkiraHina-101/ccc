# Geometry.Face.Elements()

Geometry.Face.Elements()

説明​

選択した要素からフェースを作成します。

構文​

Geometry.Face.Elements(...)

マクロ：CreateFaceByElem

リボン：Geometry » Face » Elements

入力​

crlElems​

新しい表面に移動する表面要素を指定する Cursor のリストです。

これは必須の入力です。

bSharedFace​

共有面を作成するかどうかの Boolean です。bSharedFace=True の場合、crlElems 引数は共有要素を指定する必要があります。

デフォルト値は False です。

戻り値​

新しく作成されたフェースを指定する Cursor のリストです。

サンプルコード​

Geometry.Part.Cube()

created_face = Geometry.Face.Elements(crlElems=[Elem(1008,
                                                    1007,
                                                    989,
                                                    990,
                                                    1005,
                                                    1006,
                                                    988,
                                                    987)])

JPT.Debugger(created_face)

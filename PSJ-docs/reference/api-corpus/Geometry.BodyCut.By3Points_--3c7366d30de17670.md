# Geometry.BodyCut.By3Points()

Geometry.BodyCut.By3Points()

説明​

3点で定義された切断面を使用して、ターゲットパートを分割します。

構文​

Geometry.BodyCut.By3Points(...)

マクロ：BodyCutBy3PointsS

リボン：Geometry » Body Cut » 3 Points

入力​

crPart​

分割するパートを指定する Cursor です。

これは必須の入力です。

poslPoints​

結果の位置を定義するための位置を指定する Position のリストです。各位置は、節点、エッジ上の点、またはフェース上の点から取得できます。

デフォルト値は [[0.0,0.0,0.0], [0.0,0.0,0.0], [0.0,0.0,0.0]] です。

dOffsetDistance​

選択された位置からのオフセット距離を指定する Double です。

デフォルト値は 0.0 です。

bSplitOnly​

オリジナルのパートを保持するかどうかを指定する Boolean です。

False の場合、与えられたパートは2つに分割されます。

True の場合、与えられたパートは分割なしに切断面でだけ分割されます。

デフォルト値は False です。

bMakeSectionFace​

分割セクションで断面フェースを生成するかどうかを指定する Boolean です。

デフォルト値は True です。

bSharedFace​

分割セクションで共有面を生成するかどうかを指定する Boolean です。この引数は、bMakeSectionFace=True および bSplitOnly=False の場合にのみ機能に影響します。

デフォルト値は False です。

bSeparateFace​

セクションフェースが飾られていない場所で結合（マージ）されるのを防ぐかどうかを指定する Boolean です。このオプションは bMakeSectionFace=True の場合にのみ機能します。

True の場合、セクションフェースが別々に作成されます。

False の場合、セクションフェースが1つだけ作成されます。

デフォルト値は False です。

戻り値​

新しいパートを指定する Cursor のリスト。

サンプルコード​

part = Geometry.Part.Torus(strName="Torus_2", iPartColor=14114775)

cutting_status = Geometry.BodyCut.By3Points(crPart=part, 
                                            poslPoints=[[-0.038, -0.019, 0.017],
                                                        [-0.019, -0.010, 0.015], 
                                                        [0.048, 0.022, -0.006]], 
                                            bSharedFace=True, 
                                            bSeparateFace=True)

JPT.Debugger(cutting_status)

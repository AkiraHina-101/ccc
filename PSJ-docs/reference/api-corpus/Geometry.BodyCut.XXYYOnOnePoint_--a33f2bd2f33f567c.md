# Geometry.BodyCut.XXYYOnOnePoint()

Geometry.BodyCut.XXYYOnOnePoint()

説明​

節点を1つの始点として、指定された座標平面に沿ってパートを分割します。

構文​

Geometry.BodyCut.XXYYOnOnePoint(...)

マクロ: CutBodyByPlane

リボン: Geometry » Body Cut » XX-YY On 1 Point

入力​

crPart​

分割するパートを指定する Cursor です。

この入力は必須です。

posCutPoint​

分割面上の点を指定する Position です。この位置は、節点、エッジ上の点、またはフェース上の点から取得できます。

デフォルト値は[0.0,0.0,0.0]です。

iCuttingPlane​

分割面を指定する Integer です。

もし iType = 0 であれば、Oxy平面による分割です。

もし iType = 1 であれば、Oxz平面による分割です。

もし iType = 2 であれば、Oyz平面による分割です。

デフォルト値は0です。

dOffsetDistance​

選択された位置からのオフセット距離を指定する Double です。

デフォルト値は0.0です。

bSplitOnly​

オリジナルのパートを保持するかどうかを指定する Boolean です。

もし False であれば、指定されたパートは別々に2つのパートに分割されます。

もし True であれば、指定されたパートは2つに分割されることなく、分割面でのみ分割されます。

デフォルト値は False です。

bMakeSectionFace​

区画部分でクロスセクションフェースを生成するかどうかを指定する Boolean です。

デフォルト値は True です。

bSharedFace​

区画部分で共有面を生成するかどうかを指定する Boolean です。この引数は、bMakeSectionFace=True および bSplitOnly=False のときにのみ機能に影響します。

デフォルト値は False です。

crLocalCoordinate​

ローカル座標を指定する Cursor です。デフォルト値を使用すると、グローバル座標が選択されます。

デフォルト値は None です。

bSeparateFace​

セクションフェースが食い違うことを防ぐかどうかを指定する Boolean です。このオプションは、bMakeSectionFace=True のときのみ機能に影響します。

もし True であれば、セクションフェースは別々に作成されます。

もし False であれば、セクションフェースは1つだけ作成されます。

デフォルト値は False です。

戻り値​

新しいパートを指定する Cursor のリストです。

サンプルコード​

Torus = Geometry.Part.Torus(strName="Torus_2", iPartColor=14114775)

separate_status = Geometry.BodyCut.XXYYOnOnePoint(crPart=Torus, 
                                                  posCutPoint=[-0.015,
                                                               -0.005, 
                                                               0.006],
                                                  iCuttingPlane=1, 
                                                  bSharedFace=True, 
                                                  bSeparateFace=True)

JPT.Debugger(separate_status)

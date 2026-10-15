# Geometry.Edge.PerpendicularCylinderLine()

Geometry.Edge.PerpendicularCylinderLine()

説明​

曲面上の円形フェースに垂直なエッジを作成し、角度値またはエッジの長さ値を指定して、刻印されたラインをオフセットできます。

構文​

Geometry.Edge.PerpendicularCylinderLine(...)

マクロ：ImprintPerpendicularCylinderLineS

リボン：Geometry » Edge » Perpendicular Cylinder Line

入力​

crlNodes​

最初の節点が垂直ラインを描画する開始節点であり、2番目の節点はオフセット方向を決定するために使用されます（ユーザーがオフセットしたい場合）を指定する Cursor のリストです。

これは必須の入力です。

crlFaces​

エッジが刻印されるターゲットフェースを指定する Cursor リストです。選択したフェースは曲面または円面である可能性があります。

これは必須の入力です。

iMethod​

刻印方法を指定する Integer です。この方法はコンボボックス方法の選択順に従って値で表されます。

もし iMethod=0 ならば：中心角度 - 垂直位置の円柱の中心にある角度

もし iMethod=1 ならば：弧長 - 垂直位置の円周上の距離

デフォルト値は0です。

dOffset​

オフセット値を指定する Double です。オフセット値は角度度または円の円弧の長さ（ミリメートル単位）であり、選択した方法に依存します。

デフォルト値は0.0です。

bOppositeSide​

逆側オプションがチェックされているかどうかを指定する Boolean です。この引数は、選択したフェースの両側に2本の線を刻印することを可能にします。

もし True ならば、Jupiterは円柱の曲面の両側に2本の線を作成します。選択されたフェースが円形である場合、刻印されたラインは連続して中心節点を通過し、開始節点と対向する節点でエッジを切断します。

もし False ならば、Jupiterは開始節点で定義される1本の線のみを作成します。

デフォルト値は False です。

bBreakFace​

可能な場合、指定されたフェースを分割するかどうかを指定する Boolean です。

デフォルト値は True です。

戻り値​

新しく作成されたエッジを指定する Cursor のリストです。

サンプルコード​

Geometry.Part.Cylinder(iPartColor=5093709)

created_edges = Geometry.Edge.PerpendicularCylinderLine(crlNodes=[Node(19, 157)], 
                                                crlFaces=[Face(5)],
                                                dOffset=1.0, 
                                                bOppositeSide=True)
JPT.Debugger(created_edges)

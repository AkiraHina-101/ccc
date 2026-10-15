# Connections.SolidBoltModeling()

Connections.SolidBoltModeling()

説明​

六面体要素で構成されたソリッドボルトを作成します。

構文​

Connections.SolidBoltModeling(...)

マクロ：

リボン：Connections » SolidBoltModeling

入力​

crlTopTargets​

上側のエッジまたはフェースを指定する Cursor のリスト。

この入力は必須です。

crlBottomTargets​

下側のエッジまたはフェースを指定する Cursor のリスト。

この入力は必須です。

strName​

作成されたボルト接続の名前を指定する String。

デフォルト値は「Bolt_1」です。

iBoltType​

ボルトタイプを指定する Integer。

0: ボルト - ナット

1: ボルト

デフォルト値は0です。

dMaxHeight​

新しいボルトを作成するボルト穴の最大長さを指定する Double。

デフォルト値は100です。

dMaxDiameter​

ボルト穴を検索する最大直径を指定する Double。

デフォルト値は36です。

dMinDiameter​

ボルト穴を検索する最小直径を指定する Double。

デフォルト値は3です。

bPretension​

プリテンション設定を作成するかどうかを指定する Boolean。

デフォルト値は False です。

iSolverType​

ソルバータイプを指定する Integer。

0: すべて

1: Abaqus

デフォルト値は0です。

iForceUnit​

プリテンション力の単位を指定する Integer。

0: N

1: mN

2: kN

3: kgf

4: lbf

5: tf

デフォルト値は0です。

dPretensionValue​

プリテンション力の値を指定する Double。

デフォルト値は100です。

iDirection​

力の方向を指定する Integer。

0: UX

1: UY

2: UZ

デフォルト値は0です。

crCoord​

力の方向の座標を指定する Cursor。

デフォルト値は None です。

bFixLength​

固定長設定を作成するかどうかを指定する Boolean。

デフォルト値は False です。

dDiameter​

作成したボルトの名目スレッド直径を指定する Double。

デフォルト値は4です。

dBoltHeadWidthAcrossFlat​

ボルトヘッドの対角距離を指定する Double。

デフォルト値は7です。

dBoltHeadHeight​

ボルトヘッドの高さを指定する Double。

デフォルト値は2.8です。

dShaftLength​

ボルトシャフトの長さを指定する Double。

デフォルト値は40です。

dPitch​

ボルトスレッドの長さを指定する Double。

デフォルト値は5です。

iTopHeadHeightDivision​

ボルトヘッド高さ方向のメッシュ分割数を指定する Integer。

デフォルト値は1です。

iTopHeadRadialDivision​

ボルトヘッド円周方向のメッシュ分割数を指定する Integer。

デフォルト値は1です。

dNutWidthAcrossFlat​

ボルトナットの対角距離を指定する Double。

デフォルト値は7です。

dNutHeight​

ボルトナットの高さを指定する Double。

デフォルト値は3.2です。

iBotHeadHeightDivision​

ボルトヘッド高さ方向のメッシュ分割数を指定する Integer。

デフォルト値は1です。

iBotHeadRadialDivision​

ボルトヘッド上面円周方向のメッシュ分割数を指定する Integer。

デフォルト値は1です。

戻り値​

作成されたソリッドボルトパートを指定する Cursor のリスト。

サンプルコード​

##################
# モデルの準備
##################

# 立方体を作成
cube=Geometry.Part.Cube(
    ilAxialNodes=[3, 3, 3], 
    strName="Cube_3", 
    iPartColor=6409934)

# 上面を取得
maxface=JPT.Exec(f'FindFacesInPart({cube},"MaxZFACE")')

# 上面に円を刻印
Geometry.Edge.Circle(
    veclPositions=[[0.005, 0.005, 0.01]], 
    crlTargetFace=maxface, 
    dOutRadius=2.0, 
    iNoOfDiv=8)

# 新しく作成されたエッジを取得 -> 上部エッジ
edge1=JPT.GetMaxIDEntity(JPT.DItemType.EDGE)

# 新しく作成されたフェースを削除
face=JPT.GetMaxIDEntity(JPT.DItemType.FACE)
JPT.Exec(f'DeleteFace([{face}], 1)')

# 下面を取得
minface=JPT.Exec(f'FindFacesInPart({cube},"MinZFACE")')

# 下面に円を刻印
Geometry.Edge.Circle(
    veclPositions=[[0.005, 0.005, 0.0]], 
    crlTargetFace=minface, 
    dOutRadius=2.0, 
    iNoOfDiv=8)
# 新しく作成されたエッジを取得 -> 下部エッジ
edge2=JPT.GetMaxIDEntity(JPT.DItemType.EDGE)

# 新しく作成されたフェースを削除
face=JPT.GetMaxIDEntity(JPT.DItemType.FACE)
JPT.Exec(f'DeleteFace([{face}], 1)')

# ボルト穴の側面を作成
Geometry.Face.Edges(crlEdges=[Edge(edge1, edge2)])

# ボルト穴にソリッドボルトを作成
Connections.SolidBoltModeling(
    crlTopTargets=[Edge(edge1)], 
    crlBottomTargets=[Edge(edge2)], 
    strName="Bolt_1", iBoltType=1, 
    dMaxHeight=10,     
    dDiameter=3, 
    dBoltHeadWidthAcrossFlat=5.5,
    dBoltHeadHeight=2, 
    dShaftLength=10, 
    dPitch=1, 
    iTopHeadHeightDivision=2,
    iTopHeadRadialDivision=2)

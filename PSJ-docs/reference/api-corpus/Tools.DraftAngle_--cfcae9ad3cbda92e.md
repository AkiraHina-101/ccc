# Tools.DraftAngle()

Tools.DraftAngle()

説明​

この機能は、金型モデル内のメッシュの抜き角を測定して抜き角を検証します。

構文​

Tools.DraftAngle(...)

マクロ：DRAFT_ANGLE

リボン：Tools » DraftAngle

入力​

dlDraftDirection​

抜き方向を指定する Double 型のリストです。

これは必須の入力です。

crlTargets​

対象パートを指定する Cursor のリストです。これは必須の入力です。

これは必須の入力です。

戻り値​

listPairCursorData​

カーソルと値を含むデータの Cursor-Value のリストです。

戻り値の例：
[[[11:1], 10], [[11:2], 12]] 
ここで[[11:1], 10] は、カーソル[11:1]と値10を含むペアカーソルデータです。ペアカーソルデータの最初のアイテムはカーソルで、2番目は値（整数、倍精度浮動小数点数、または文字列である可能性があります）

サンプルコード​

#サンプルモデルの作成
Geometry.Part.Trapezoid(
    dlLength=[0.01, 0.001, 0.01], 
    ilAxialNodes=[10, 2, 10], 
    iPartColor=7961077)

JPT.ViewFitToModel()

MeshEdit.OneNode(
    crlNodes=[Node(45)],
    crlFaceFixed=[Face(21)], 
    bOffsetvector=True, dlOffset=[0.8, 0.0, 0.0], dOffset=0.0, 
    dDistStrong=2.0, dDistWeak=5.0)

MeshEdit.OneNode(
    crlNodes=[Node(56)],
    crlFaceFixed=[Face(21)], 
    bOffsetvector=True, dlOffset=[-0.8, 0.0, 0.0], dOffset=0.0,
    dDistStrong=2.0, dDistWeak=5.0)

MeshEdit.OneNode(
    crlNodes=[Node(4)], 
    crlFaceFixed=[Face(21)], 
    bOffsetvector=True, dlOffset=[0.8, 0.0, 0.0], dOffset=0.0, 
    dDistStrong=2.0, dDistWeak=5.0)

#抜き角の計算
draft_angle_result=Tools.DraftAngle(dlDraftDirection=[0, 1, 0], crlTargets=[Part(1)])

#輪郭で結果を表示
Tools.DraftAngleShowContour(listPairCursorData=draft_angle_result)

#グループに結果を保存
Tools.DraftAngleCreateGroup(listPairCursorData=draft_angle_result)

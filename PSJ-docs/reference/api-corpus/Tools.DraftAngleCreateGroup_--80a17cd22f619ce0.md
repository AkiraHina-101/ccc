# Tools.DraftAngleCreateGroup()

Tools.DraftAngleCreateGroup()

説明​

型モデル内のメッシュの抜き勾配を測定し、検証します。

構文​

Tools.DraftAngleCreateGroup(...)

マクロ：CreateGroupDraftAngle

リボン：Tools » DraftAngleCreateGroup

入力​

listPairCursorData​

カーソルと値を含むデータ（リスト形式）を指定する Cursor-Value のリスト型データです。

これは必須の入力です。

iNumDigits​

等高線の桁数を指定する Integer。

デフォルト値は 1 です。

dGroupMax​

グループの最大値を指定する Double。

デフォルト値は 90 です。

dGroupMin​

グループの最小値を指定する Double。

デフォルト値は -90 です。

戻り値​

新しく作成されたグループを指定する List of Cursor。

サンプルコード​

# サンプルモデルの作成
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

# ドラフト角の計算
draft_angle_result=Tools.DraftAngle(dlDraftDirection=[0, 1, 0], crlTargets=[Part(1)])

# グループ内に結果を保存
Tools.DraftAngleCreateGroup(listPairCursorData=draft_angle_result)

# 異なるパラメータでグループ内の結果を上書き
Tools.DraftAngleCreateGroup(
    listPairCursorData=draft_angle_result, 
    iNumDigits=5, dGroupMax=60, dGroupMin=-60)

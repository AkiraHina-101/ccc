# Tools.DraftAngleHideContour()

Tools.DraftAngleHideContour()

説明​

Draft Angle 機能の結果輪郭を非表示にします。

構文​

Tools.DraftAngleHideContour(...)

マクロ: HideContourDraftAngle()

リボン: Tools » DraftAngleHideContour

入力​

この関数には入力引数がありません。

戻り値​

関数が成功したかどうかを指定する Boolean 型。

0: 失敗

1: 成功

サンプルコード​

# サンプルモデルを作成
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

# Draft Angle を計算
draft_angle_result=Tools.DraftAngle(dlDraftDirection=[0, 1, 0], crlTargets=[Part(1)])

# 結果を輪郭表示
Tools.DraftAngleShowContour(listPairCursorData=draft_angle_result)

# 結果輪郭を非表示
Tools.DraftAngleHideContour()

# Tools.DraftAngleShowContour()

Tools.DraftAngleShowContour()

説明​

スケッチングモードの結果輪郭を表示します。

構文​

Tools.DraftAngleShowContour(...)

マクロ：ShowContourDraftAngle

リボン：Tools » DraftAngleShowContour

入力​

listPairCursorData​

カーソルと値を含むデータ（リスト形式）を指定する Cursor-Value のリスト型データです。

この入力は必須です。

iContourDivision​

輪郭の分割数を指定します。

dContourMax​

輪郭の最大値を指定します。

dContourMin​

輪郭の最小値を指定します。

戻り値​

関数の成功または失敗を指定します。

0：失敗

1：成功

サンプルコード​

#サンプルモデル作成
Geometry.Part.Trapezoid(
    dlLength=[0.01, 0.001, 0.01],
    ilAxialNodes=[10, 2, 10],
    iPartColor=7961077)

JPT.ViewFitToModel()

MeshEdit.OneNode(
    crlNodes=[節点(45)],
    crlFaceFixed=[フェース(21)],
    bOffsetvector=True, dlOffset=[0.8, 0.0, 0.0], dOffset=0.0,
    dDistStrong=2.0, dDistWeak=5.0)

MeshEdit.OneNode(
    crlNodes=[節点(56)],
    crlFaceFixed=[フェース(21)],
    bOffsetvector=True, dlOffset=[-0.8, 0.0, 0.0], dOffset=0.0,
    dDistStrong=2.0, dDistWeak=5.0)

MeshEdit.OneNode(
    crlNodes=[節点(4)],
    crlFaceFixed=[フェース(21)],
    bOffsetvector=True, dlOffset=[0.8, 0.0, 0.0], dOffset=0.0,
    dDistStrong=2.0, dDistWeak=5.0)

#ダフト角計算
draft_angle_result=Tools.DraftAngle(dlDraftDirection=[0, 1, 0], crlTargets=[Part(1)])

#輪郭で結果表示
Tools.DraftAngleShowContour(listPairCursorData=draft_angle_result)

#異なるパラメータで結果表示
Tools.DraftAngleShowContour(
    listPairCursorData=draft_angle_result,
    iDivisionNumber=5, dContourMax=60, dContourMin=-60)

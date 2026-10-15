# Geometry.Face.SmoothFace()

Geometry.Face.SmoothFace()

説明​

選択されたエッジによって設定された境界から、幾何学的なフェースを作成します。
選択されたエッジが曲線の場合、この機能は曲面を作成することができます。

構文​

Geometry.Face.SmoothFace(...)

マクロ: CreateSmoothFaceGUI

リボン: Geometry » Face » SmoothFace

入力​

crlTargets​

境界エッジを指定する Cursor のリスト。

これは必須の入力です。

iElementGeneration​

要素のタイプを指定する Integer 。

0: TRI

1: QUAD

デフォルト値は 0 です。

dGradation​

グラデーション係数を指定する Double 。

デフォルト値は 1 です。

bFaceSmooth​

接続の連続性を指定する Boolean 型。

False: G0

True: G1

デフォルト値は True です。

crlTargetParts​

作成されたフェースが属するパートを指定する Cursor のリスト。crlTargetParts が空の場合、新しいパートを作成します。

デフォルト値は [] です。

bInterpolation​

面のサイズまたはメッシュのサイズを均一にするかどうかを指定する Boolean 型。

デフォルト値は False です。

戻り値​

新しく作成されたフェースを指定する Cursor です。

サンプルコード​

Geometry.Part.Sphere()
Geometry.Edge.Angle(
    [CursorPair(Node(146), Node(147)), 
    CursorPair(Node(148), Node(168)), 
    CursorPair(Node(267), Node(268)), 
    CursorPair(Node(224), Node(244))])
Geometry.DeleteEntity.Face(crlFaces=[Face(2)])

created_face = Geometry.Face.SmoothFace(crlTargets=[Edge(3)])
JPT.Debugger(created_face)

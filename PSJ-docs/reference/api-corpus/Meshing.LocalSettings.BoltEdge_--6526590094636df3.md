# Meshing.LocalSettings.BoltEdge()

Meshing.LocalSettings.BoltEdge()

説明​

ボルトのエッジのメッシュ設定を行います（面のメッシュ作成前に設定を定義します）

構文​

Meshing.LocalSettings.BoltEdge(...)

マクロ:

リボン: Meshing » LocalSettings » BoltEdge

入力​

iCircleDivision​

円周方向の分割数を指定する Integer です。

デフォルト値は0です。

crlTargets​

メッシュ設定の対象エッジを指定する Cursor リストです。

デフォルト値は[]です。

戻り値​

成功した場合は作成されたローカルメッシュ設定を指定する Cursor 、失敗した場合はNoneを返します。

サンプルコード​

Geometry.Part.Cylinder()
Meshing.LocalSettings.BoltEdge(iCircleDivision=8, crlTargets=[Edge(2, 1)])

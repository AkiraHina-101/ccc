# BoundaryConditions.Submodel.ForcedTempertature()

BoundaryConditions.Submodel.ForcedTempertature()

説明​

粗いモデルから温度フィールドを使用してサブモデルを作成し、それを境界条件としてサブモデルに適用することで、関心領域で正確で高度な応答を得ます。

構文​

BoundaryConditions.Submodel.ForcedTempertature(...)

リボン: BoundaryConditions » Submodel » ForcedTempertature

入力​

strName​

サブモデルの強制温度名を指定する String です。

デフォルト値は "SubmodelForcedTemperature1" です。

iSolver​

ソルバータイプを指定する Integer です。現在は ADVC ソルバーのみ利用可能です。

0: ADVC ソルバー。

デフォルト値は 0 です。

strFilePathName​

ファイルパス名を指定する String です。

デフォルト値は "/home/" です。

iProcessNo​

ADVC ソルバーのプロセス番号を指定する Integer です。値は 0 より大きくする必要があります。

これは必須入力です。

iReferType​

参照タイプを指定する Integer です。

0: 空欄。

1: 結果。

2: リスタート。

デフォルト値は 0 です。

dExtensionRange​

拡張範囲値を指定する Double です。

デフォルト値は DFLT_DBL です。

dExtensionTol​

拡張許容度を指定する Double です。

デフォルト値は DFLT_DBL です。

dExtensionLimitTol​

拡張限界許容度を指定する Double です。

デフォルト値は DFLT_DBL です。

strGlobalElementSet​

グローバル要素セットを指定する String です。

デフォルト値は "" です。

iUseBucket​

バケットの使用を指定する Integer です。

0: 空欄。

1: はい。

2: いいえ。

デフォルト値は -1 です。

iNumBucketMaxX​

X方向のバケット最大数を指定する Integer です。

デフォルト値は DFLT_INT です。

iNumBucketMaxY​

Y方向のバケット最大数を指定する Integer です。

デフォルト値は DFLT_INT です。

iNumBucketMaxZ​

Z方向のバケット最大数を指定する Integer です。

デフォルト値は DFLT_INT です。

iPrevBc​

指定した境界条件の維持を指定する Integer です。

0: 空欄。

1: デフォルト保持。

デフォルト値は -1 です。

crlTargets​

ターゲットエンティティを指定する List of Cursor です。ターゲットエンティティにはフェースまたは節点が含まれます。

デフォルト値は [] です。

crEdit​

境界条件強制温度のカーソルを指定する Cursor です。

デフォルト値は None です。

戻り値​

作成した LBC を指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()
created_lbc = BoundaryConditions.Submodel.ForcedTempertature(strName="SubmodelForcedTemperature1",
                                                             iReferType=-1,
                                                             crlTargets=[Face(26)])
JPT.Debugger(created_lbc)

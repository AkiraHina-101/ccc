# Home.ImportResults.Nastran()

Home.ImportResults.Nastran()

説明​

Nastran/Vibro 結果ファイルをインポートします。

構文​

Home.ImportResults.Nastran(...)

マクロ: ImportNastran

リボン: Home » ImportResults » Nastran

入力​

strPath​

Nastran 結果ファイルのパスを指定する String です。

デフォルト値は "" です。

strlPaths​

Nastran hdf5 結果ファイルのパスを指定する String のリストです。

デフォルト値は [] です。

iImportType​

インポートタイプを指定する Integer です:

1: プロパティによる標準 Nastran Op2

2: シンプルなトポロジー

デフォルト値は 1 です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 型です（指定された値より小さい角度の隣接要素の間にエッジを作成します）。

デフォルト値は 60.0 度です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 型です（指定された値より大きい角度の隣接エッジ要素に頂点を作成します）。

デフォルト値は 60.0 度です。

bReadLoadAndConstraint​

負荷と拘束を読み込むかどうかを指定する Boolean です。

デフォルト値は False です。

bReadConnection​

接続を読み込むかどうかを指定する Boolean です。

デフォルト値は False です。

bCreateResultsAtMidNode​

中間節点で結果を作成するかどうかを指定する Boolean です。

デフォルト値は False です。

bIsVibro​

ファイルが Vibro Acoustic かどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

関数の実行が成功したかどうかを指定する Boolean 型です:

True: Nastran ファイル（*.op2 ファイル）が正常にインポートされました。

False: Nastran ファイル（*.op2 ファイル）をインポートできませんでした。

サンプルコード​

import os
NastranFile = os.path.join(
    JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH), 
    'SampleData/PSJ/PSJ-Utility/PostSample/101_solid.op2')
Home.ImportResults.Nastran(strPath=NastranFile)

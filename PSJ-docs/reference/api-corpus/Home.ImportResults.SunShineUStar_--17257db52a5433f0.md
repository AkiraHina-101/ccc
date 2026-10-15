# Home.ImportResults.SunShineUStar()

Home.ImportResults.SunShineUStar()

説明​

SunShine UStarファイル（*.op2）をJupiterデータベースにインポートします。

構文​

Home.ImportResults.SunShineUStar(...)

マクロ: ImportSunShineUStar

リボン: Home » ImportResults » SunShineUStar

入力​

strPath​

_String_を指定します

この入力は必須です。

iImportType​

インポートタイプを指定する Integer :

1: プロパティによる標準SunShine Op2

2: シンプルなトポロジ

デフォルト値は1です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double（指定値より小さい角度の隣接要素間にエッジを作成します）。

デフォルト値は60.0度です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double（指定値より大きい角度の隣接エッジ要素に頂点を作成します）。

デフォルト値は60.0度です。

戻り値​

関数の実行が成功したかどうかを指定する Boolean :

True: SunShine UStarファイル（*.op2ファイル）が正常にインポートされました。

False: SunShine Starファイル（*.op2ファイル）をインポートできません。

サンプルコード​

import os
UstarFile = os.path.join(JPT.GetAppPathInfo(JPT.PathType.APPDATA_PATH), 'SampleData/PSJ/PSJ-Utility/PostSample/plate_beam_ustar.op2')
Home.ImportResults.SunShineUStar(strPath=UstarFile)

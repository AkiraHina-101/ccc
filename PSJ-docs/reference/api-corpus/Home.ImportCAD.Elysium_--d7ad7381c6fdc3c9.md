# Home.ImportCAD.Elysium()

Home.ImportCAD.Elysium()

説明​

Elysiumインターフェースを使用してJupiterデータベースにCADファイルをインポートします。

構文​

Home.ImportCAD.Elysium(...)

リボン：Home » Import CAD » Elysium

入力​

strlPaths​

インポートに使用されるCADファイルのリストを指定する String のリストです。

これは必須入力です。

dChordHeightTolerance​

実際の曲面から面要素までの最大距離を指定する Double です。 コードハイトが小さいほど、面要素が小さく、曲面の曲率が正確に表現されます。

デフォルト値は1.0です。

dAngleToleranceDegree​

比較的小さな半径を持つ曲線のテッセレーションに影響する角度許容度を指定する Double です。CADモデル全体のサイズに比べて半径が小さい曲線のテッセレーションに影響します。

デフォルト値は5.0です。

dPointCoincidentTolerance​

一致（連結）パートの検出に影響を与える許容度を指定する Double です。

デフォルト値は0.01です。

iConvertIsolatedCurve​

孤立曲線を変換するかどうかを指定する Integer です。

0: オフ

1: オン

デフォルト値は0です。

iDekCleanselfintersectingloop​

頂点位置で自己交差しているループを検出して排除するオプションを指定する Integer です。

0: クリーニングを無効

2: 頂点位置で自己交差しているループの検出と排除

3: 自己交差しているループの検出と排除

デフォルト値は2です。

iDekVolumetopart​

パートへのボリューム数を指定する Integer です。

デフォルト値は4です。

iIgesFixedCurvePreference​

トリム曲線の計算方法を指定する Integer です。IGES CADタイプ用です。

0: IGESファイルの値

1: 2D曲線

2: 3D曲線

デフォルト値は0です。

iIgesAutostitch​

トポロジーのないIGESファイルの隙間を埋めるコントロール（オン/オフ）オプションを指定する Integer です。IGES CADタイプ用です。

0: オフ

1: オン

デフォルト値は1です。

dIgesStitchtolerance​

隙間を埋めるための許容度を指定する Double です。IGES CADタイプ用です。

デフォルト値は0.1です。

iCatiaConvertNotShownElement​

非表示要素の変換を制御するオプションを指定する Integer です。CATIA CADタイプ用です。

0: オフ

1: オン

デフォルト値は0です。

iCatiaConvertNotShownInstance​

非表示インスタンスの変換を制御するオプションを指定する Integer です。CATIA CADタイプ用です。

0: オフ

1: オン

デフォルト値は0です。

iCatiaConvertaxis​

座標系の変換を制御するオプションを指定する Integer です。CATIA CADタイプ用です。

0: オフ

1: オン

デフォルト値は1です。

iStepCreateseam​

外部ループがないトポロジーにシームを作成するオプションを指定する Integer です。STEP CADタイプ用です。

0: シームなし

1: CADに依存

2: シームを追加

デフォルト値は1です。

dStepPointtolerance​

同じ点をチェックするための許容度を指定する Double です。STEP CADタイプ用です。

デフォルト値は0.0です。

iAcisHealacisbeforeversion​

ヒーリング機能を使用するオプションを指定する Integer です。ACIS CADタイプ用です。

0: オフ

1: オン

デフォルト値は0です。

iJtConvertgeometrytype​

変換対象の要素タイプを指定する Integer です。JT CADタイプ用です。

0: オフ

1: Brep

デフォルト値は1です。

bFaceColor​

色情報オプションを指定する Boolean です。

デフォルト値は False です。

iJtConvertgeneralpart​

一般パートタイプの変換を制御するオプションを指定する Integer です。JT CADタイプ用です。

0: オフ

1: オン

デフォルト値は1です。

iJtConvertaxis​

座標系の変換を制御するオプションを指定する Integer です。JT CADタイプ用です。

0: オフ

1: オン

デフォルト値は1です。

iJtConvertcenterline​

中心線の変換を制御するオプションを指定する Integer です。JT CADタイプ用です。

0: オフ

1: オン

デフォルト値は0です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True：CADファイル（IGESファイル、STEPファイルなど）が正常にインポートされました。

False：CADファイル（IGESファイル、STEPファイルなど）をインポートできませんでした。

サンプルコード​

imported_status = Home.ImportCAD.Elysium(strlPaths=[JPT.GetProgramPath() +
                                                    "SampleData/CAD_Model/IGES/A400MA.igs"],
                                         dAngleToleranceDegree=3.0,
                                         dPointCoincidentTolerance=1e-05,
                                         dIgesStitchtolerance=0.01)
JPT.Debugger(imported_status)

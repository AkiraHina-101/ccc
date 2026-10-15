# Calculation.TransRespSolver.ResponseCondition()

Calculation.TransRespSolver.ResponseCondition()

説明​

一時応答（ソルバー）の応答点の結果を出力します。

構文​

Calculation.TransRespSolver.ResponseCondition(...)

マクロ:

リボン: Calculation » TransRespSolver » ResponseCondition

入力​

crTargetAnalysis​

処理される対象ジョブを指定する Cursor です。

デフォルト値は None です。

crCoordinate​

出力座標系を指定する Cursor です。

デフォルト値は None です。

bAllModesUsed​

すべてのモードを使用するかを指定する Boolean です。

デフォルト値は True です。

strlModesSelected​

応答計算に使用される選択されたモードを指定する String のリストです。bAllModesUsed が False の場合にこのオプションが使用されます。

デフォルト値は [] です。

bDampingFactor​

計算にダンピング係数を使用するかを指定する Boolean です。

デフォルト値は True です。

dDampingFactor​

ダンピング係数の値を指定する Double です。

デフォルト値は 0.01 です。

crDampingFactor​

ダンピング係数のフィールドデータを指定する Cursor です。

デフォルト値は None です。

iCurveStyle​

計算のための時間範囲のスタイルを指定する Integer です。

0: 開始値 + ステップ番号 + ステップサイズ

1: 開始値 + ステップサイズ + 終了値

2: 開始値 + ステップ番号 + 終了値

デフォルト値は 1 です。

dStyleParamTop​

選択した曲線スタイルの解析開始値を指定する Double です。

デフォルト値は 0.0 です。

dStyleParamMid​

選択した曲線スタイルのステップサイズ値を指定する Double です。

デフォルト値は 1.0 です。

dStyleParamBot​

選択した曲線スタイルの解析終了値を指定する Double です。

デフォルト値は 1.0 です。

bCreateNewResult​

モデル全体の新しい結果（変位と応力）を作成するかを指定する Boolean です。

デフォルト値は False です。

iResultType​

計算される結果タイプを指定する Integer です。

0: 変位

1: 速度

2: 加速度

3: 応力（ソリッド）

4: 応力（シェル）

5: 変位 + 応力。この結果タイプは bCreateNewResult = True の場合に表示されます。

デフォルト値は 0 です。

strlResultNames​

選択された結果タイプに応じてコンポーネントの結果を指定する String のリストです。

デフォルト値は ["TX"] です。

iResultPosition​

結果の出力位置を指定する Integer です。

0: 節点上

1: 要素上

2: 要素節点上

デフォルト値は 0 です。

strDBFileName​

SunShine DB ファイル（*.mdb）を指定する String です。

デフォルト値は "" です。

strDBVersion​

DB バージョンを指定する String です。

デフォルト値は "" です。

strMethodId​

メソッド ID を指定する String です。

デフォルト値は "" です。

strSPCID​

SPC ID を指定する String です。

デフォルト値は "" です。

strMPCID​

MPC ID を指定する String です。

デフォルト値は "" です。

iResidualVector​

残留ベクトルオプションを指定する Integer です。
0: なし
1: あり
2: 空白

デフォルト値は 0 です。

strPath​

結果データ（*.bdf ファイル）を格納するディレクトリパスを指定する String です。

デフォルト値は "" です。

crlTargets​

応答を計算する対象を指定する Cursor のリストです。対象は節点またはソリッド要素です。

デフォルト値は [] です。

crEdit​

既存の応答条件を指定する Cursor です

このパラメータを使用すると、指定した応答条件が変更されます。

None の場合は新しい応答条件が作成されます。

デフォルト値は None です。

戻り値​

作成された一時応答条件（ソルバー）を指定する Cursor です。

サンプルコード​

# 結果モデルの準備
inputPath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Command\\PostSample\\freq-solver\\103.bdf"
outputFolder = "C:\\temp"
JPT.RunSunShine(inputPath,outputFolder,2,1,False,True,False)

Home.ImportResults.Nastran(strPath = outputFolder + "\\103.op2", dFaceAngle=60.16, dEdgeAngle=60.16) 

# 一時解析ロードの作成 - ソルバー
Calculation.TransRespSolver.LoadCondition(strName="TRNLoad_1", 
                                        iLoadDirection=2, 
                                        dlForce=[0.0, 0.0, 10.0], 
                                        dAmplitude=10.0, 
                                        crlTargets=[Node(514)])

# 一時応答解析 - ソルバーの作成
respCondition = Calculation.TransRespSolver.ResponseCondition(crTargetAnalysis=PostTransAnalysisSolver(1), 
                                                            bDampingFactor=False, 
                                                            dDampingFactor=0.02, 
                                                            iCurveStyle=2, 
                                                            dStyleParamMid=20.0, 
                                                            dStyleParamBot=5000.0, 
                                                            strlResultNames=["TZ"], 
                                                            strDBFileName="103", 
                                                            strDBVersion="1", 
                                                            strMethodId="2", 
                                                            strPath="C:/temp/111.bdf", 
                                                            crlTargets=[Node(517)])
JPT.Debugger(respCondition) # 戻り値を確認するため

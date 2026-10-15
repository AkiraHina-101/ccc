# Post.AreaMaxMin()

Post.AreaMaxMin()

説明​

指定された範囲内の節点の最大値と最小値を検出します。

構文​

Post.AreaMaxMin(...)

マクロ: CmdPostAreaMaxMin

リボン: Post » AreaMaxMin

入力​

crlTargets​

最大値/最小値を検出する選択した節点を指定する Cursor のリストです。

この入力は必須です。

bCheckMax​

最大値を検出および表示するかどうかを指定する Boolean です。

デフォルト値は True です。

bCheckMin​

最小値を検出および表示するかどうかを指定する Boolean です。

デフォルト値は True です。

bSave​

検出された最大値/最小値の結果を Watch Data Window の AreaMax/Min タブに保存するかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

最大値/最小値を含む辞書です。

サンプルコード​

# ポストモデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 結果をプロット
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=4))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))

# 選択された範囲内の最大値/最小値を検出
MaxMinArea = Post.AreaMaxMin(crlTargets=[Node(45, 53, 133, 132, 48, 130, 127, 39, 47, 38, 28, 46)])
print("範囲内の最大値は:", MaxMinArea['Max']['value']) 
print("範囲内の最小値は:", MaxMinArea['Min']['value'])

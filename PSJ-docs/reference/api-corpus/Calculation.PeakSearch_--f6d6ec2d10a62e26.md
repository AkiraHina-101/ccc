# Calculation.PeakSearch()

Calculation.PeakSearch()

説明​

モデル内の各節点で、近くの頂点よりも高いまたは低い結果（ピーク）を持つピーク節点を見つけ、フラグを立てます。

構文​

Calculation.PeakSearch(...)

マクロ: CmdPostPeakSearch

リボン: Calculation » PeakSearch

入力​

iOption​

ピークオプションを指定する Integer 。

0: 最大

1: 最小

2: 絶対最大

デフォルト値は 0 です。

dParameter​

マイクロピーク除去の値を指定する Double 。

デフォルト値は 0.1 です。

bStep​

ステップオプションを使用するかどうかを指定する Boolean 型。

デフォルト値は True です。

戻り値​

ピーク節点を指定する Cursor のリスト。

サンプルコード​

# 結果モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)
# 結果のプロット
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=2, 
                iResultSet=1, 
                iTimeStep=2, 
                strResultName="Stress", 
                strResultCompName="Max Principal Stress", 
                iResultPos=4), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1, 
                iOptionConversion=1, 
                iOptionContinuous=8))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=2, 
                    iResultSet=1, 
                    iTimeStep=2, 
                    strResultName="Stress", 
                    strResultCompName="Max Principal Stress"))

# ピーク検索
peakNodes = Calculation.PeakSearch(bStep=False)
print(peakNodes)

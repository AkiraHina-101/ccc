# Post.DisplayContour()

Post.DisplayContour()

説明​

読み込まれた結果の輪郭を表示します。

構文​

Post.DisplayContour(...)

マクロ：ShowContour()

リボン：Post » DisplayContour

入力​

bDisplay​

輪郭表示をする（True）か非表示にする（False）を指定する Boolean 型の値です。

デフォルト値は True です。

戻り値​

成功した場合は True、失敗した場合は False です。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
Home.ImportResults.Nastran(strPath=samplePath)

# 輪郭を表示
Post.ShowContour(
    crPostJob=TSVPostJob(1), 
    lContourSettings=[
        PostContourSetting(
            postResultKey=PostResultKey(
                iAnalysisType=1, iResultSet=1, iTimeStep=1, strResultName="Displacement", 
                strResultCompName="Translational", iResultPos=1), 
                postDataOp=PostDataOp(iResultLocation=1, iOptionCoord=1))])

Post.ShowDeformation(
    crPostJob=TSVPostJob(1), 
    postResultKey=PostResultKey(
        iAnalysisType=1, 
        iResultSet=1, 
        iTimeStep=1, 
        strResultName="Displacement", 
        strResultCompName="Translational"))
Post.EnableMiddleNodes()

# 輪郭表示を非表示にする
Post.DisplayContour(bDisplay=False)

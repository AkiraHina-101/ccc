# Tools.Property()

Tools.Property()

説明​

選択したエンティティの出力情報をすべてリストします。

構文​

Tools.Property(...)

マクロ: CmdPostProperty

リボン: Tools » Property

入力​

crTarget​

出力するターゲットを指定する Cursor。ターゲットは節点または実体要素です。

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean:

True: プロセスが正常に実行されます。

False: 関数を実行できません。

サンプルコード​

# ポストモデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\Post\\Static_Renkon.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)
Post.ShowContour(crPostJob=TSVPostJob(1), 
                lContourSettings=[PostContourSetting(postResultKey=PostResultKey(
                iAnalysisType=1, 
                iResultSet=1, 
                iTimeStep=1, 
                strResultName="Displacement", 
                strResultCompName="Translational", 
                iResultPos=1), 
                postDataOp=PostDataOp(
                iResultLocation=1, 
                iOptionCoord=1))])
Post.ShowDeformation(crPostJob=TSVPostJob(1), 
                    postResultKey=PostResultKey(
                    iAnalysisType=1, 
                    iResultSet=1, 
                    iTimeStep=1, 
                    strResultName="Displacement", 
                    strResultCompName="Translational"))

# 節点のプロパティを表示
nodeProperty = Tools.Property(crTarget=Node(6699))
JPT.Debugger(nodeProperty)

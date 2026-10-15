# Post.Template.Update()

Post.Template.Update()

説明​

指定されたテンプレートを更新します。

構文​

Post.Template.Update(...)

マクロ: UpdateTemplate

リボン: Post » Template » Update

入力​

strName​

アップデートするテンプレート名を指定する String です。

この入力は必須です。

strComment​

テンプレートを更新する際のコメントを指定する String です。

デフォルト値は "" です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# Post モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 新しいテンプレートの作成
Post.Template.Create(strName="Template_1", strComment="")
Post.Template.AttachViewPoint(strName="Template_1", dlCenter=[0.016, 0.005, 0.0025], dScaleFactor=0.0349344)

# 作成したテンプレートの更新
Post.Template.Update(strName="Template_1", strComment="View Point を更新 ")
Post.Template.AttachViewPoint(strName="Template_1", dlCenter=[0.003, 0.005, 0.001], dScaleFactor=0.00753137)

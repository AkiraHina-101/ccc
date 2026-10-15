# Post.Template.Delete()

Post.Template.Delete()

説明​

指定されたテンプレートを削除します。

構文​

Post.Template.Delete(...)

マクロ: DeleteTemplate

リボン: Post » Template » Delete

入力​

strName​

テンプレートの名前を指定する String の入力です。

この入力は必須です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# Post モデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 新しいテンプレートを作成
Post.Template.Create(strName="Template_1", strComment="")
Post.Template.AttachViewPoint(strName="Template_1", dlCenter=[0.016, 0.005, 0.0025], dScaleFactor=0.0349344)
Post.Template.Copy(strCurrentTemplate="Template_1", strNewTemplate="Template_2")
Post.Template.Delete(strName="Template_2")

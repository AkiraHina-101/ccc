# Post.Template.Create()

Post.Template.Create()

説明​

新しいテンプレートを作成します。

構文​

Post.Template.Create(...)

マクロ：CreateTemplate

リボン：Post » Template » Create

入力​

strName​

テンプレート名を指定する String です。

デフォルト値は「NewTemplate」です。

strComment​

作成されたテンプレートのコメントを指定する String です。

デフォルト値は「」です。

戻り値​

処理が正常に実行されたかどうかを指定する Boolean です。

True: 処理は正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# Postモデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 新しいテンプレートを作成
Post.Template.Create(strName="Template_1", strComment="")
Post.Template.AttachViewPoint(strName="Template_1", dlCenter=[0.016, 0.005, 0.0025], dScaleFactor=0.0349344)

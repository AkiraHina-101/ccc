# Post.Template.Import()

Post.Template.Import()

説明​

保存されたテンプレート設定（*.xml）の内容をテンプレートリストにインポートします。

構文​

Post.Template.Import(...)

マクロ: ImportTemplate

リボン: Post » Template » Import

入力​

strPath​

*.xmlファイルのパスを指定する String です。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です。

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポストモデルを準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\103_solid.op2"
Home.ImportResults.Nastran(strPath = samplePath, dFaceAngle=60.16, dEdgeAngle=60.16)

# 新しいテンプレートを作成
Post.Template.Create(strName="Template_1", strComment="")
Post.Template.AttachViewPoint(strName="Template_1", dlCenter=[0.016, 0.005, 0.0025], dScaleFactor=0.0349344)
Post.Template.Export(strPath="C:/temp/Template_1.xml")
Post.Template.Delete(strName="Template_1")

# テンプレートをインポート
importTemplate = Post.Template.Import(strPath="C:/temp/Template_1.xml")
JPT.Debugger(importTemplate)

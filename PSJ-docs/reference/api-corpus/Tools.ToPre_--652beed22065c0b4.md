# Tools.ToPre()

Tools.ToPre()

説明​

モデルのデータと関連設定を、開いているポストドキュメントから新しいプレドキュメントに変換します。変換中に、モデル内のすべてのパート名、設定項目名、および設定項目のデータが保持されます。

構文​

Tools.ToPre(...)

マクロ: ToPre

リボン: Tools » ToPre

入力​

strName​

プレドキュメントの名前を指定する String です。

これは必須の入力です。

ilOptions​

モデルと一緒に変換される関連設定を指定する Integer のリストです。

0: グループ

1: LBC

2: コネクション

3: 座標

4: プロパティ

デフォルト値は [] です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

# ポストモデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\Post\\Static_Renkon.op2"
Home.ImportResults.Nastran(strPath= samplePath, dFaceAngle=60.16, dEdgeAngle=60.16, bReadLoadAndConstraint=True, 
                            bReadConnection=True, bCreateResultsAtMidNode=True)
# プレに変換
data = Tools.ToPre(strName="Static_Renkon", ilOptions=[0, 1, 2, 3, 4])
JPT.SetActiveDocumentByName("Static_Renkon",1)
JPT.Debugger(data)

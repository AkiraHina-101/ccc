# JPT.GetActivePostJob()

JPT.GetActivePostJob()

説明​

アクティブなポストジョブの情報を取得します。

構文​

JPT.GetActivePostJob()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

アクティブなポストジョブの情報を指定する DItem オブジェクトです。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

post_job = JPT.GetActivePostJob()
JPT.Debugger(post_job)

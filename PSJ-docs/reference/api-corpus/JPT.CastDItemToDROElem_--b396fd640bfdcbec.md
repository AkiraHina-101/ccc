# JPT.CastDItemToDROElem()

JPT.CastDItemToDROElem()

説明​

選択したポスト要素の情報を取得するために、 DItem オブジェクトを DPostElem オブジェクトに変換します。

構文​

JPT.CastDItemToDROElem(DItemObject)

入力​

DItemObject​

変換に使用される DItem オブジェクトです。

これは必須の入力です。

戻り値​

関連情報を持つ DPostElem オブジェクト（ポスト要素）です。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\PostSample\\101_solid.op2"
JPT.Exec('CmdImportTSVOp2Post({}, 1, 1.0472, 1.0472, 0, 0, 0)'.format(samplePath))

# 作成されたDItemオブジェクトのリストからDItemオブジェクトとして要素オブジェクトを取得
listDItemPostElems = JPT.GetAllByTypeID(JPT.DItemType.POST_ELEM)
dItemPostElem = listDItemPostElems[0]
JPT.Debugger(dItemPostElem)

# 上記のDItemオブジェクトからDElemオブジェクトに変換
dPostElem = JPT.CastDItemToDROElem(dItemPostElem)
JPT.Debugger(dPostElem)

# JPT.GetDictMatPropKeys()

JPT.GetDictMatPropKeys()

説明​

dictMatPropsからキーのリストを取得します。

構文​

JPT.GetDictMatPropKeys(dictMatProps)

入力​

dictMatProps​

dictMatProps を指定する Dictionary。

この入力は必須です。

戻り値​

dictMatPropsのキーを指定する String のリスト。

サンプルコード​

# ライブラリ材料から1番目の材料を取得
mat0 = JPT.GetAllLibraryMaterials()[0]

# dictMatPropsを取得して印刷します
dict1 = mat0.dictMatProps
pprint(dict1)

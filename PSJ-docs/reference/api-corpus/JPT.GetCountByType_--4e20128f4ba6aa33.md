# JPT.GetCountByType()

JPT.GetCountByType()

説明​

データ型を入力して、エンティティの総数を取得します。

構文​

JPT.GetCountByType(データ型)

入力​

データ型​

総数を数えたい データ型 を指定する Enum です。

この入力は必須です。

戻り値​

入力されたタイプの総数を指定する Integer です。

サンプルコード​

# モデルの準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2")
Geometry.Part.Cube(strName="Cube_3")
JPT.ViewFitToModel()

# 現在のJupiterに存在する パートの総数を数えます
iPartCount = JPT.GetCountByType(JPT.DItemType.BODY)
print(iPartCount) # 3

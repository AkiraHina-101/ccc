# MaterialInfo()

MaterialInfo()

説明​

材料の情報を取得します

構文​

MaterialInfo(String MatName,String Info Type)

入力​

1. String​

材料名

2. String​

情報タイプ（DENSITYまたはYOUNGMODULUESまたはPOISSONRATIO）

戻り値​

"1"：関数を実行できます

"0"：関数を実行できません

サンプルコード​

MaterialInfo("Structural_Steel","DENSITY")

または

MaterialInfo("Structural_Steel","YOUNGMODULUES")

# JPT.GetMaterialDBById()

JPT.GetMaterialDBById()

説明​

入力された材料IDがユーザー材料データベースに存在するかどうかを確認します。

構文​

JPT.GetMaterialDBById(userMaterialID)

入力​

userMaterialID​

ユーザー材料データベースで確認したい材料IDを指定する Integer です。

これは必須入力です。

戻り値​

ユーザー材料データベースに存在する場合は確認した材料IDを指定する Integer です。
以下のような値が返されます：

0: ユーザー材料データベースに存在しない場合。

userMaterialID: 確認した材料IDがユーザー材料データベースに存在する場合は、入力されたIDを返します。

サンプルコード​

# ユーザー材料データベースを作成
Properties.Material.Add("Copper_Alloy", [Density([(DENSITY, 8.3e-09)]),
                        Elastic([(YOUNGS_MODULUS, 110000.0), (POISSONS_RATIO, 0.34)])])
                        # ユーザー材料ID = 1（ライブラリ材料データベースに存在）

# 作成した材料のIDがユーザー材料データベースに存在するかどうかを確認します

# 戻り値1 - 確認した材料がユーザー材料データベースに存在し、
# そのIDが入力されたIDと同じであることを返します
firstMat = JPT.GetMaterialDBById(1)
JPT.Debugger(firstMat)

# 戻り値0 - ユーザー材料データベースに存在しません
# 入力された材料ID = 2
secondMat = JPT.GetMaterialDBById(2)
JPT.Debugger(secondMat)

# JPT.EnableLicenseFeature()

JPT.EnableLicenseFeature()

説明​

現在のJupiterで存在するライセンス機能を有効化または無効化します。

構文​

JPT.EnableLicenseFeature("licenseFeatureName", BoolType)

入力​

licenseFeatureName​

現在のJupiterに存在するライセンスの名前を指定する String です。

Jupiterのライセンス名は Home » Preference » License で見つけることができます。

この入力は必須です。

BoolType​

ライセンスの有効状態を説明する BoolType を指定する Enum 型です：

True: ライセンスを有効にします。

False: ライセンスを無効にします。

この入力は必須です。

ヒント

JPT.BoolType.TRUE_VAL を入力する代わりに 1 、
または JPT.BoolType.FALSE_VAL を入力する代わりに 0 を入力することもできます。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# ライセンス JPT_BASE を無効にする
JPT.EnableLicenseFeature("JPT_BASE",
                         JPT.BoolType.FALSE_VAL)
# または
# JPT.EnableLicenseFeature("JPT_BASE", 0)

# ライセンス JPT_BASE を有効にする
JPT.EnableLicenseFeature("JPT_BASE",
                         JPT.BoolType.TRUE_VAL)
# または
# JPT.EnableLicenseFeature("JPT_BASE", 1)

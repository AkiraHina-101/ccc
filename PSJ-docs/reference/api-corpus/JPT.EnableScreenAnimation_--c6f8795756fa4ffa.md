# JPT.EnableScreenAnimation()

JPT.EnableScreenAnimation()

説明​

画面アニメーション効果を有効にします。

このユーティリティは、JPT.DisableScreenAnimation() ユーティリティを使用した後に画面アニメーション効果を有効にするために使用されます。

構文​

JPT.EnableScreenAnimation()

入力​

このユーティリティ機能には入力値は必要ありません。

戻り値​

このユーティリティ機能は出力値を持ちません。

サンプルコード​

# 画面アニメーションを無効にする
JPT.DisableScreenAnimation()

# 立方体を作成し、画面アニメーションを確認します
# アニメーション効果は無効です
Geometry.Part.Cube(iPartColor=7011837)

# JPT.DisableScreenAnimation() を使用した後に画面アニメーション効果を有効にする
JPT.EnableScreenAnimation()

# 立方体を作成し、画面アニメーションを確認します
# アニメーション効果が有効になります
Geometry.Part.Cube(iPartColor=7011837)

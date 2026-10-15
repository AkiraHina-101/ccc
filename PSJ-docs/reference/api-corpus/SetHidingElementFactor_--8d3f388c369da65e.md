# SetHidingElementFactor()

SetHidingElementFactor()

説明​

最適化された形状の値と非表示要素であるための閾値を設定します。

構文​

SetHiddingElementFactor(float OptimizedShape, string ResultName)

入力​

1. float​

要素を非表示にするための最適化された形状値を指定します。

2. string​

非表示要素のソースとして使用する結果を指定します。"NodalDensityRatio"または"DensityRatio"。

戻り値​

なし。

サンプルコード​

SetHidingElementFactor(0.28, "NodalDensityRatio")

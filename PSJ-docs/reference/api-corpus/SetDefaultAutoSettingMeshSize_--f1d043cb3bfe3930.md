# SetDefaultAutoSettingMeshSize()

SetDefaultAutoSettingMeshSize()

説明​

データ検証をON/OFFします。

構文​

SetDefaultAutoSettingMeshSize(int Selection, float Maximum, float Minimum)

入力​

1. int​

設定タイプを選択します

0: 平均

1: 最小値

2: 最大値

2. float​

最大メッシュサイズの係数。

3. float​

最小メッシュサイズの係数。

戻り値​

戻り値はありません。

サンプルコード​

SetDefaultAutoSettingMeshSize(1, 2, 0.2)

# JPT.GetAllLicensesStatus()

JPT.GetAllLicensesStatus()

説明​

利用可能なすべてのライセンスのステータスを取得します。

構文​

JPT.GetAllLicensesStatus()

入力​

このユーティリティ関数には入力値は必要ありません。

Return Code​

_辞書_はライセンス名とそのステータスのペアを格納します。

サンプルコード​

# すべての利用可能なライセンスのステータスを確認します
pprint(JPT.GetAllLicensesStatus())

# CreateContactReport()

CreateContactReport()

説明​

接触チェックレポートを作成します

構文​

CreateContactReport(string path, double zoomFactor, int fitGroupBy, int listBy, int listOrder, int listFormat)

入力​

1. String​

エクスポートされたレポートファイルパス

2. Double​

ズームファクター

3. Int​

フィットグループ方式：

0: 部分

1: フェース

4. Int​

リスト方法：

0: 部分

1: 接触条件

5. Int​

リスト順序：

0: 名前

1: ID

6. Int​

リスト形式：

0: html

1: excel

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateContactReport("D:/contact_report.html", 2, 0, 0, 0, 0)

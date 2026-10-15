# DSubGroup

DSubGroup

説明​

これは、ドキュメント内のサブグループを表す DSubGroup クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | name | パートの名前。

 | typeID | サブグループのタイプ ID（ID = 78）。
戻り値は DItem TypesのInt表記（int 型）です。

 | id | サブグループの外部 ID。
ID は重複する可能性がありますが、推奨されません。
ID は、再番号付け機能を使用して変更できます。
戻り値は ID（int 型）です。

 | parent | 親グループ。
戻り値は Sub Group 型 です。

 | children | サブグループに所属する子グループとサブグループ。
戻り値は DItemVector です。

 | name | サブグループの名前。

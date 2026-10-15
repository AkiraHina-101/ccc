# DPostNode

DPostNode

説明​

これは、Jupiter内部でのPost Nodeを表すDPostNodeクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | typeID | Post NodeのタイプID（ID = 192）。
戻り値は、DItem TypesのInt表記（int）です。

 | id | Post Nodeの外部ID。
Post NodeのIDは一意です。
戻り値はID（int）です。

 | connectElem | 共有節点要素。
戻り値はDItemVectorオブジェクトで、DItem形式で要素のすべての情報を格納します。

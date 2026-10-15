# DNode

DNode

説明​

これはJupiterの内部で節点を表すDNodeクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | isFloating | 節点がフローティング節点かどうかを判断します。
フローティング節点の場合はTrueを返し、そうでない場合はFalseを返します。

 | typeID | 節点のタイプID（ID = 10）。
戻り値はDItem TypesのInt表記（int）です。

 | id | 節点の外部ID。
IDは重複する可能性がありますが、推奨されません。
IDは、再番号付け機能を使用して変更できます。
戻り値はID（int）です。

 | pos | 節点の位置座標。
戻り値はTVector3dです。

 | coordinate | 節点に割り当てられた座標。
戻り値はDCoordです。

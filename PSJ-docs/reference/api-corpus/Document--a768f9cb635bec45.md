# Document

Document

説明​

これは Jupiter でドキュメント情報を表す Document クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | docName | ドキュメントの名前。
戻り値はアクティブドキュメントの名前（文字列）です。

 | docID | ドキュメントのID。
戻り値はアクティブドキュメントのID（文字列）です。

 | docType | ドキュメントのタイプ。
アクティブドキュメントが Pre ドキュメントの場合は DocPre、
Post ドキュメントの場合は DocPost、DocPre や DocPost のいずれでもない場合は DocNone が返ります。

 | docPath | ドキュメントのパス。
戻り値はアクティブドキュメントのパス（文字列）です。
アクティブドキュメントに特定のパスがない場合、Undefined が返ります。

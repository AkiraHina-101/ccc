# DPostResponse

DPostResponse

説明​

これはDPostResponseクラスのインスタンスで、Jupiter内のPost周波数応答、Post過渡応答、Post周波数応答（ソルバー）、およびPost過渡応答（ソルバー）を表します。

プロパティ​

 | 属性 | 説明

 | name | 応答の名前。
戻り値は名前の文字列（str）です。

 | id | 応答のID。
戻り値はID（int）です。

 | type | 応答のタイプ。
戻り値は応答タイプの文字列（str）です。

 | targetAnalysis | 解析対象。
戻り値は処理対象のPostジョブのすべての情報を格納する DPostAnalysis オブジェクトです。

 | resultCurve | カーブの情報。
戻り値は指定されたカーブのすべての情報を格納する DPostResultCurve オブジェクトです。

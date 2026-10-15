# DSolverJob

DSolverJob

説明​

これは Jupiter 内の Job を表す DSolverJob クラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | isValid | Job の妥当性を判定します。
Job が有効であれば True を返し、無効であれば False を返します。

 | type | Job のタイプ名です。
戻り値はタイプ（文字列）です。

 | typeID | Job のタイプ ID です。
戻り値は DItem Types の Int 表記（int）です。

 | tableID | Job のテーブル ID です。
戻り値は DTable Types の Int 表記（int）です。

 | id | Job の外部 ID です。
重複する可能性がありますが、推奨されません。
ID は renumbering 関数を使用して変更することができます。
戻り値は ID（int）です。

 | targets | Job の内容を保持します。
戻り値は DItem のリストです。

 | masters | Job の Master face/edge/node です。
戻り値は DItem のリストです。

 | slaves | Job の Slave face/edge/node です。
戻り値は DItem のリストです。

 | parent | アセンブリツリー内の Job の親であるサブアセンブリです。
戻り値は DItem のリストです。

 | isHidden | Job の表示状態を判定します。
Job が非表示であれば True を返し、表示されていれば False を返します。

 | name | Job の名前です。
戻り値は名前（文字列）です。

 | jobSteps | Job のタイムステップです。
ADVC と Abaqus Job に使用されます。
戻り値は DItem のリストです。

 | jobDescription | Job の説明です。
戻り値は説明テキスト（文字列）です。

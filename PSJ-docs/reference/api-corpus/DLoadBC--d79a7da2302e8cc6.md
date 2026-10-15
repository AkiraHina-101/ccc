# DLoadBC

DLoadBC

説明​

これは、Jupiter内のLBCアイテムを表すDLoadBCクラスのインスタンスです。

プロパティ​

 | 属性 | 説明

 | isValid | LBCの検証を判断します。
LBCが有効であれば True を返し、無効であれば False を返します。

 | type | LBCのタイプ名です。
戻り値はタイプ（文字列）です。

 | typeID | LBCのタイプIDです。
戻り値はDItem TypesのInt表記（int型）です。

 | tableID | LBCのテーブルIDです。
戻り値はDTable TypesのInt表記（int型）です。

 | id | LBCの外部IDです。
重複することができますが、推奨されていません。
IDは、renumbering機能を使用して変更できます。
戻り値はID（int型）です。

 | targets | LBCの内容を保持します。
戻り値はDItemのリストです。

 | masters | LBCのマスターフェース/エッジ/節点です。
戻り値はDItemのリストです。

 | slaves | LBCのスレーブフェース/エッジ/節点です。
戻り値はDItemのリストです。

 | parent | アセンブリツリーにおいてLBCの親であるサブアセンブリです。
戻り値はDItemのリストです。

 | isHidden | LBCの表示状態を決定します。
LBCが非表示であれば True を返し、表示されていれば False を返します。

 | name | LBCの名前です。

 | lbcAnalysisType | LBCの解析ソルバーのタイプです。
戻り値はlbcAnalysisType（文字列）です。

 | lbcCoord | LBCの参照座標系です。
戻り値はDCoord（オブジェクト）です。

 | color* 1 | LBCの色情報です。
この値は調整可能です。
戻り値はRGBカラーです。

属性​

lbcAnalysisType​

 | 名前 | 説明

 | FOR_BOTH | 構造と熱解析の両方。

 | FOR_STRUCT | 構造解析。

 | FOR_THERMAL | 熱解析。

注意​

Footnotes​

属性名にアスタリスク記号*が含まれる場合、その属性は現在の値から新しい値に変更/割り当てることができることを意味します。 ↩

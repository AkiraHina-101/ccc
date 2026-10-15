# CmdGetResultByPosition()

CmdGetResultByPosition()

説明​

特定の位置の結果を取得します。

構文​

CmdGetResultByPosition(Real x, Real y, Real z, Real Tolerance, bool DisplayPartOnly, bool UseMidNode)

入力​

1. Real​

X位置

2. Real​

Y位置

3. Real​

Z位置

4. Real​

サーチサーフェスの許容値。

5 bool​

検索対象を表示されたパートのみに制限します。true = 1, false = 0

6. bool​

中間節点データを使用します。true = 1, false = 0

戻り値​

検索された点の結果値。精度は環境設定の数値設定のウォッチデータで設定されます。

"FAILED": 位置が見つからない場合。

サンプルコード​

CmdGetResultByPosition(10.001400, 8.884620, 1.818100, 0.010000, 0, 1)')

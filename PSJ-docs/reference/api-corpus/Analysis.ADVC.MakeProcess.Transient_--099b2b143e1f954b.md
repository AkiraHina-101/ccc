# Analysis.ADVC.MakeProcess.Transient()

Analysis.ADVC.MakeProcess.Transient()

説明​

一時的なプロセスのための ADVC 熱伝達を作成します。

構文​

Analysis.ADVC.MakeProcess.Transient(...)

マクロ: AdvcTHProcess

リボン: Analysis » ADVC » Heat Transfer » Make Process

入力​

strName​

新しいプロセスの名前を指定する String です。

デフォルト値は "" です。

iEndType​

終了接続タイプを指定する Integer です。取りうる値は 0、1、2 です。それぞれ、"最大時間"、"一定速度"、"両方" に対応しています。

デフォルト値は 1 です。

dMaxTime​

最大時間を指定する Double です。この引数は、iEndType=1 または iEndType=2 のときに使用されます。

デフォルト値は 1 です。

dSteadyRate​

一定速度を指定する Double です。この引数は、iEndType=2 または iEndType=2 のときに使用されます。

デフォルト値は 0.0 です。

iFixedOrAuto​

インクリメンテーションのタイプを指定する Integer です。

iFixedOrAuto=0 の場合: 固定の dt 時間値 dFixedDt を使用します。

iFixedOrAuto=1 の場合: これらのパラメータ dMaxChange, dInitDt, dMaxDt, dMinDt に基づいて dt 時間値を自動計算します。

デフォルト値は 0 です。

...

（以降も同様のフォーマットで続きます）

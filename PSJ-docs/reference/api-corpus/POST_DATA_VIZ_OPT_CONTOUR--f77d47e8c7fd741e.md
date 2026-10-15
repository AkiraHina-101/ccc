# POST_DATA_VIZ_OPT_CONTOUR

POST_DATA_VIZ_OPT_CONTOUR

説明​

データ型は等高線を表示するための結果設定を行うために使用されます。

属性​

iColorDivision​

等高線範囲の分割数を指定する Integer です。

デフォルト値は10です。

iContourType​

等高線のタイプを指定する Integer です。

0: 連続

1: ステップ

2: 等値面

デフォルト値は1です。

iMaxMinType​

等高線で表示する最大/最小タイプを指定する Integer です。

0: 見える実体

1: 合計実体

2: ユーザー定義

3: 複数の結果

デフォルト値は0です。

dMaxUser​

ユーザーによる等高線の最大値を指定する Double です。

デフォルト値は1000.0です。

dMinUser​

ユーザーによる等高線の最小値を指定する Double です。

デフォルト値は-1000.0です。

dMaxTotal​

合計での等高線の最大値を指定する Double です。

デフォルト値は1000.0です。

dMinTotal​

合計での等高線の最小値を指定する Double です。

デフォルト値は-1000.0です。

dIsoVolumeScalar​

Double 型で指定する。

デフォルト値は0.0です。

iSpectrumType​

等高線のカラーパターンを指定する Integer です。

デフォルト値は2（レインボースペクトル）です。

iUpperColor​

等高線の上部カラーを指定する Integer です。

デフォルト値は255です。

iLowerColor​

等高線の下部カラーを指定する Integer です。

デフォルト値は16711680です。

iFrameColor​

等高線の枠のカラーを指定する Integer です。

デフォルト値は65535です。

dlCustomColors​

カスタムカラーを指定する Double 型のリスト 型です。

デフォルト値は[]です。

dlCustomColorValues​

カスタムカラー値を指定する Double 型のリスト 型です。

デフォルト値は[100,90,80,70,60,50,40,30,20,10,0]です。

iLogType​

表示のためのログタイプを指定する Integer です。

0: なし

1: LogE

2: Log10

3: SPL

デフォルト値は0です。

bShowBlankValueAs0​

空白値を0または指定されたカラーで表示するかを指定する Boolean です。

デフォルト値は False です。

bOptimizedShape​

最適化ツールキットを使用するかどうかを指定する Boolean です。

デフォルト値は False です。

bGururiContour​

ぐるりん等高線を表示するかどうかを指定する Boolean です。

デフォルト値は False です。

bAutoSetAmplitudeValue​

振幅値を自動で設定するかを指定する Boolean です。

デフォルト値は False です。

iBlankValueColor​

空白値の表示されるカラーを指定する Integer です。

デフォルト値は8421504です。

iInterpolateMethod​

補間方法を指定する Integer です。

0: 固定

1: 補間

デフォルト値は0です。

ilInterpolateInfo​

補間情報を指定する Integer のリスト 型です。

デフォルト値は[-1, -1, -1]です。

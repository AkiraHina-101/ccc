# POST_DATA_VIZ_OPT_ANIMATION

POST_DATA_VIZ_OPT_ANIMATION

説明​

データ型は、アニメーションの表示設定を行うために使用されます。

属性​

iMode​

アニメーションモードを指定する Integer です。

0: シングル

1: マルチ

2: マルチ解析

デフォルト値は0です。

iFPS​

アニメーション速度を指定する Integer です。

デフォルト値は8です。

iFrameNumber​

初期状態と変形状態の間のフレーム数を指定する Integer です。

デフォルト値は8です。

iDivideMethod​

初期状態と最大変形間の分割方法を指定する Integer です。

0: 線形

1: サイン

デフォルト値は1です。

iLoopType​

アニメーションの動作タイプを指定する Integer です。

0: 片道

1: 行きと帰り

2: サイクル

デフォルト値は1です。

iAnimationResultType​

アニメーションの結果タイプを指定する Integer です。

デフォルト値は0です。

bApplyDeform​

アニメーション再生時に変形を適用するかどうかを指定する Boolean です。

デフォルト値は True です。

bLocus​

ローカスオプションを使用するかどうかを指定する Boolean です。

デフォルト値は False です。

bPhaseAngle​

位相角の値を変更するかどうかを指定する Boolean です。

デフォルト値は False です。

bAcousticCombine​

音響結合を使用するかどうかを指定する Boolean です。

デフォルト値は False です。

ilSubcaseIds​

サブケースIDを指定する Integer のリスト 型です。

デフォルト値は[]です。

bMultiAnalysis​

マルチ解析モードを使用するかどうかを指定する Boolean です。

デフォルト値は False です。

bMemCache​

メモリキャッシュオプションを使用するかどうかを指定する Boolean です。

デフォルト値は True です。

bFixContour​

アニメーション再生中に最後の結果で輪郭を固定するかどうかを指定する Boolean です。

デフォルト値は False です。

iSectionMode​

クロスセクション表示中のアニメーションタイプを指定する Integer です。

0: オイラー表示

1: ラグランジュ表示

デフォルト値は0です。

bSetTime​

時間でアニメーション再生範囲を設定するかどうかを指定する Boolean です。

デフォルト値は False です。

dStartTime​

アニメーション再生の開始時間を指定する Double です。

デフォルト値は0.0です。

dEndTime​

アニメーション再生の終了時間を指定する Double です。

デフォルト値は0.0です。

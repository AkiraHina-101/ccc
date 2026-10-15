# Analysis.AbaqusStep.ModalStep()

Analysis.AbaqusStep.ModalStep()

説明​

Abaqus Stepを作成します - Modal Type。

構文​

Analysis.AbaqusStep.ModalStep(...)

リボン: Analysis » AbaqusStep » ModalStep

入力​

strName​

Modalステップ名を指定する String です。

この入力は必須です。

strDesp​

Modal解析のステップの説明を指定する String です。

デフォルト値は "" です。

iEigenSolver​

Modal解析方法を指定する Integer です。

0: Lanczos

1: Subspace

デフォルト値は 0 です。

iNFreqRequestbchecked​

取得するモードの数を指定する Integer です。

0: 周波数範囲でのすべてのモードを取得します。

その他: 取得するモード数を指定します。

デフォルト値は 0 です。

ilNFreqRequestTList​

周波数範囲を指定する Integer のリスト 型です。

デフォルト値は [] です。

iFreqShiftbchecked​

周波数シフト値 (サイクル/時間)2(サイクル/時間)^2(サイクル/時間)2 を指定する Integer です。

デフォルト値は 0 です。

ilFreqShiftTList​

周波数シフト範囲を指定する Integer のリスト 型です。

デフォルト値は [] です。

iFreqRangebchecked​

興味のある最小周波数 (サイクル/時間)(サイクル/時間)(サイクル/時間) を指定します Integer です。

デフォルト値は 0 です。

ilFreqRangeTList​

興味のある最小周波数値リストを指定する Integer のリスト 型です。

デフォルト値は [] です。

iIncldAcoustic​

音響構造カップリングの含めるかを指定する Integer です。

デフォルト値は 0 です。

iBlockSizebchecked​

ブロックサイズの使用有無を指定する Integer です。

デフォルト値は 0 です。

ilBlockSizeTList​

ブロックサイズ値リストを指定する Integer のリスト 型です。

デフォルト値は [] です。

iMaxBlkNumofLanczosStepbchecked​

ブロックランチョスステップの最大数を指定する Integer です。

デフォルト値は 0 です。

ilMaxBlkNumofLanczosStepTList​

ブロックランチョスステップの最大数値リストを指定する Integer のリスト 型です。

デフォルト値は [] です。

iEnableUseSIM​

SIMベースの線形動的手法の使用を指定する Integer です。

デフォルト値は 0 です。

iEnableIncludeResMods​

残差モードの含めるかを指定する Integer です。

デフォルト値は 0 です。

iNEigenRequest​

モードリクエスト数を指定する Integer です。

デフォルト値は 2147483647 です。

iMaxItersUsed​

カーネル行列が再形成される前に許容される反復数を指定する Integer です。

デフォルト値は 30 です。

iVectorsUsed​

繰り返し中に使用されるベクトル数を指定する Integer です。

デフォルト値は 2147483647 です。

iMethod​

ソルバー手法を指定する Integer です。

0: 直接

1: 反復

デフォルト値は 0 です。

iMatrixStorage​

行列の保存方法を指定する Integer です。

0: デフォルト

1: 非対称

2: 対称

デフォルト値は 0 です。

iNormalizeEigenBy​

固有ベクトルの正規化を指定する Integer です。

0: 変位

1: 質量

デフォルト値は 1 です。

iEvalPropFreqbchecked​

周波数依存特性を評価する周波数を指定する Integer です。

デフォルト値は 0 です。

ilEvalPropFreqTList​

周波数依存特性を評価する周波数値リストを指定する Integer のリスト 型です。

デフォルト値は [] です。

abaqusOutputRequest​

Abaqus出力リクエストのリストを指定する ABAQUS_OUTPUT_REQUEST です。

デフォルト値は ABAQUS_OUTPUT_REQUEST です。

crEdit​

既存のAbaqusステップを指定する Cursor です。

このパラメータを使用すると、指定したステップが変更されます。

None の場合、新しいステップが作成されます。

デフォルト値は None です。

戻り値​

新しく作成された、または変更されたAbaqus Modalステップを指定する Cursor です。

サンプルコード​

process = Analysis.AbaqusStep.ModalStep(strName="Step1", ilNFreqRequestTList=[DFLT_INT],
  ilFreqShiftTList=[DFLT_DBL], ilFreqRangeTList=[DFLT_DBL, DFLT_DBL],
  ilBlockSizeTList=[DFLT_DBL], ilMaxBlkNumofLanczosStepTList=[0], ilEvalPropFreqTList=[DFLT_DBL])

print("Result Dynamic Process has ID: " + str(process)) #for checking return value

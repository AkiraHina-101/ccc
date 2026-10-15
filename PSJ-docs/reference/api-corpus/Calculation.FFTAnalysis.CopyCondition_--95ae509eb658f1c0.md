# Calculation.FFTAnalysis.CopyCondition()

Calculation.FFTAnalysis.CopyCondition()

説明​

指定されたFFT条件のコピーを作成します。

構文​

Calculation.FFTAnalysis.CopyCondition(...)

マクロ:

リボン: Calculation » FFTAnalysis » CopyCondition

入力​

crPostFFTCondition​

FFT条件を指定する Cursor。

これは必須入力です。

戻り値​

関数の成功を指定する Boolean。

True: 成功。

False: 失敗。

サンプルコード​

# このコードは、Calculation.FFTAnalysis.SetCondition を使用して PostFFTCondition が必要です。 
# つまり
# firstBore=Calculation.FFTAnalysis.SetCondition(...)

Calculation.FFTAnalysis.CopyCondition(crPostFFTCondition=firstBore)

# AcousticIntensity()

AcousticIntensity()

説明​

強度は音圧と粒子速度の結果から作成されます。

構文​

AcousticIntensity(str strAnalysisName, cursor crEdit)

入力​

1. int​

解析の名前。

2. cursor​

編集を指定するCursor。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AcousticIntensity("MyAcousticIntensity", 0:0)

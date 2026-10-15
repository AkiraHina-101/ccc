# CmdPostDiagramSettings()

CmdPostDiagramSettings()

説明​

ダイアグラムの設定。

構文​

CmdPostDiagramSettings(int ScaleMethod, float ratioModel, float ratioScreen, color Highlight, color Positive, color Negative, bool UseContour, bool TwoSides, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget)

入力​

1. int​

スケール法。0：モデルのサイズ比率、1：画面のサイズ比率。

2. float​

モデルのサイズ比率の値。

3. float​

画面のサイズ比率の値。

4. color​

ハイライトカラー。

5. color​

ポジティブカラー。

6. color​

ネガティブカラー。

7. bool​

コンツア使用フラグ。

8. bool​

両面フラグ。

9. int​

ハイライトタイプ

10. float​

ハイライト値1

11. float​

ハイライト値2

12. int​

表示対象

戻り値​

なし。

サンプルコード​

CmdPostDiagramSettings(0, 0.03, 0.03, 255, 16777215, 51400, 0, 1, 0, 0, 1, 0)

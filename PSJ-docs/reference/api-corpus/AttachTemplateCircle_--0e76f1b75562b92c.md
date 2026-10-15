# AttachTemplateCircle()

AttachTemplateCircle()

説明​

新しいテンプレートを作成します。

構文​

AttachTemplateCircle(string templateName, int ScaleMethod, float ratioModel, float ratioScreen, float ratioValue, color Highlight, color Positive, color Negative, bool UseContour, int HighlightTarget, float HighligValue1, float HighligValue2, int DisplayTarget, bool Reverse)

入力​

1. string ​

テンプレート名。

2. int ​

スケール方法。 0: モデルサイズ比率、1: 画面サイズ比率。

3. float ​

モデルサイズ比率の値。

4. float ​

画面サイズ比率の値。

5. float ​

比率値 = 1.0,

6. color ​

ハイライト色。

7. color ​

ポジティブ色。

8. color ​

ネガティブの色。

9. bool  ​

UseContour フラグ。

10 . int ​

ハイライト対象。

11. float ​

ハイライト値1。GREATER THANやGREATER THAN ABS、および RANGEの最小値で使用されます。

12. float ​

ハイライト値2。RANGEの最大値で使用されます。

13 . int  ​

しきい値

14. bool  ​

リバースフラグ。

戻り値​

"1": 成功。

"0": 失敗。

サンプルコード​

AttachTemplateCircle("My Template", 0, 0.03, 0.03, 1, 255, 16777215, 51400, 0, 0, 0, 1, 0, 0)

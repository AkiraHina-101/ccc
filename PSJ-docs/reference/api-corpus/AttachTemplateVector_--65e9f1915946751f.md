# AttachTemplateVector()

AttachTemplateVector()

説明​

新しいテンプレートを作成します。

構文​

AttachTemplateVector(string テンプレート名, int スケール方法, float モデル比率, float 画面比率, float 比率値, bool 矢印を使用, color ハイライト, color ポジティブ, color ネガティブ, bool コントアを使用, int ハイライト対象, float ハイライト値1, float ハイライト値2, int 表示対象, bool 逆, bool 全モデルベクトル, int 閾値オプション, float 閾値値, float 閾値値最大, int 比較オプション, bool 全て同じ長さ)

入力​

1. string ​

テンプレート名

2. int ​

スケール方法。0: モデルサイズ比率、1: 画面サイズ比率。

3. float ​

モデルサイズ比率値。

4. float ​

画面サイズ比率値。

5. float ​

比率値。

6. bool ​

矢印を使用するかどうかのフラグ。

7. color ​

ハイライト色。

8. color ​

ポジティブ色。

9. color ​

ネガティブ色。

10. bool ​

コントアを使用するかどうかのフラグ。

11. int ​

ハイライト対象。

12. float ​

ハイライト値1。

13. float ​

ハイライト値2。

14. int ​

表示対象。

15. bool ​

逆フラグ。

16. bool ​

全モデルベクトルフラグ。

17. int ​

閾値対象。

18. float ​

閾値値。

19. float ​

閾値値最大。

20. int ​

比較オプション。

21. bool ​

全て同じ長さ。

戻り値​

"1": 成功

"0": 失敗

サンプルコード​

AttachTemplateVector("マイテンプレート", 0, 0.03, 0.03, 1, 1, 255, 16777215, 51400, 0, 0, 0, 1, 0, 0, 0, 0, 0, 100, 0, 0)

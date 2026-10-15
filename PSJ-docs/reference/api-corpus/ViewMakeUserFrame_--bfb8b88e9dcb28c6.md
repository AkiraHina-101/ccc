# ViewMakeUserFrame()

ViewMakeUserFrame()

説明​

新しいユーザーフレームを作成します

構文​

ViewMakeUserFrame(string nameOfFrame, int StartPointX, int StartPointY, int endPointX, int EndPointY, bool Mode )

入力​

1. string​

ユーザーフレームの名前。

2. int​

x方向の開始点を指定します。

3. int​

y方向の開始点を指定します。

4. int​

x方向の終点を指定します（開始点x + 幅）。

5. int​

y方向の終点を指定します（開始点y + 高さ）。

6. bool​

シングルモードまたはマルチプルモードを指定します。

0 : シングル

1 : マルチプル

戻り値​

戻り値はありません。

サンプルコード​

ViewMakeUserFrame("New_Frame_1 ((Multiple))", 294, 128, 588, 257, 1)

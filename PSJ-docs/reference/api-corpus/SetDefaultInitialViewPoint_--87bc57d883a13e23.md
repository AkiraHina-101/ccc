# SetDefaultInitialViewPoint()

SetDefaultInitialViewPoint()

説明​

ドキュメントを開いたときのデフォルトビューポイントを設定します。

構文​

SetDefaultInitialViewPoint(int Flag, int Type)

入力​

1. int​

初期ビューポイントを有効または無効にします。

0: 無効

1: 有効

2. int​

ビューポイントを指定します。

0: XY平面（+Z軸）

1: XY平面（-Z軸）

2: XZ平面（+Y軸）

3: XZ平面（-Y軸）

4: YZ平面（-X軸）

5: YZ平面（+X軸）

6: ISOビュー（+Z1）

7: ISOビュー（+Z2）

8: ISOビュー（+Y1）

9: ISOビュー（+Y2）

10: ISOビュー（+X1）

11: ISOビュー（+X2）

戻り値​

戻り値はありません。

サンプルコード​

SetDefaultInitialViewPoint(0,1)

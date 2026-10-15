# ViewSelectByFace()

ViewSelectByFace()

説明​

選択したターゲットと同じ平面上にあるすべてのターゲットを選択します。

構文​

ViewSelectByFace(int ターゲットタイプ, cursor[] ターゲット)

入力​

1. Int​

選択するターゲットの種類を指定する整数です。

2. Cursor[]​

他のターゲットを選択するために同じ平面上のターゲットを指定するカーソルリストです。

戻り値​

選択されたパート（フェースまたは2D要素）を指定するカーソルリストです。

サンプルコード​

ViewSelectByFace(3,[])

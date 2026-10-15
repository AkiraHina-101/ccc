# Geometry.Bar.TwoNodes()

Geometry.Bar.TwoNodes()

説明​

2つの選択された節点からバーパートを作成します。

構文​

Geometry.Bar.TwoNodes( ... )

マクロ: CreateBar

リボン: Geometry » Bar » 2 Nodes

入力​

crStartNode​

開始節点を指定する Cursor です。

この入力は必須です。

crEndNode​

終了節点を指定する Cursor です。

この入力は必須です。

strName​

新しいパートの名前を指定する String です。

デフォルト値は "Bar_1" です。

iMeshOption​

バー パートに要素を生成するオプションを指定する Integer です。

もし iMeshOption=0 の場合: 新しいバー パートには iMeshCount と同じ数の1D要素があります。

もし iMeshOption=1 の場合: バー パート上の1D要素のサイズは dMeshSize と同じです。

デフォルト値は 0 です。

iMeshCount​

バー パート上の1D要素の数を指定する Integer です。この引数は iMeshOption=0 のときに指定する必要があります。

デフォルト値は 5 です。

dMeshSize​

バー パート上の1D要素のサイズを指定する Double です。この引数は iMeshOption=1 のときに指定する必要があります。

デフォルト値は 0.0 です。

戻り値​

作成されたバーパートを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube()

newBar = Geometry.Bar.TwoNodes(crStartNode=Node(5), crEndNode=Node(7))
JPT.Debugger(newBar)

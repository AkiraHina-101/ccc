# CmdDistancePlot()

CmdDistancePlot()

説明​

距離プロット。

構文​

CmdDistancePlot(int Node1, int Node2, PostStepItem [] stepItem, bool DistXYZ, bool PosXYZ )

入力​

1. int  ​

節点1のID

2. int  ​

節点2のID

3. PostStepItem [] ​

ソースの結果。

PostStepItemsは以下です:

int - 解析タイプ。

int - 結果セット。

int - タイムステップ。

4. bool ​

X、 Y、 Z距離プロットフラグ。

5. bool ​

X、 Y、 Z位置プロットフラグ。

戻り値​

なし。

サンプルコード​

CmdDistancePlot(8, 2, [[1,0,0], [1,0,1], [1,0,2], [1,0,3]], 0, 1)

# CmdCurveEdit()

CmdCurveEdit()

説明​

ライン形式の編集。

構文​

CmdCurveEdit(int dxCurve, string Name, color col, int LineType, int SymbolType, int Thick, int SymbolThick, bool 13OCT)

入力​

1. int​

ポストジョブ。

2. string​

タイトル

3. color​

ラインの色

4. int​

破線のタイプ

5. int​

マーカーのタイプ

6. int​

ラインの太さ

7. int​

マーカーのサイズ

8. bool​

1/3 OCT フラグ

戻り値​

なし。

サンプルコード​

CmdCurveEdit(1, "Curve1", 16711935, 0, 0, 1, 4, 0)

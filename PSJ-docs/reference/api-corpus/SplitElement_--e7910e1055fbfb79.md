# SplitElement()

SplitElement()

説明​

要素の分割

構文​

SplitElement(cursor[] taElems, cursor datum0, cursor datum1, int iMethod, bool bAutoExecute,
    bool AutoTransition, bool bCADProject, bool bMergeNodes)

入力​

1. Cursor[]​

対象要素のカーソル（[11:要素ID]）

2. Cursor​

datum0 = 0:0

3. Cursor​

datum1 = 0:0

4. Int​

Method = 0

5. Bool​

自動実行フラグ 真 = 1、偽 = 0

6. Bool​

自動移行フラグ 真 = 1、偽 = 0

7. Bool​

CADプロジェクションフラグ 真 = 1、偽 = 0

8. Bool​

節点統合フラグ 真 = 1、偽 = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

SplitElement([11:1090], 0:0, 0:0, 0, 1, 0, 0, 1)

# TemplateCopy()

TemplateCopy()

説明​

テンプレートコピー（ウィンドウからウィンドウへのコピーを含む）

構文​

TemplateCopy(cursor[] entityMaster, cursor[] entitySlave, int iMethod, bool bCopySub, double dTolerance)

入力​

1. Cursor[]​

対象エンティティのマスターカーソル（[CursorType:CursorType ID]）

2. Cursor[]​

対象エンティティのスレーブカーソル（[CursorType:CursorType ID]）

3. Int​

コピー設定メソッド

0: 形状による

1: トポロジによる

4. Bool​

サブエンティティを含むかどうかのフラグ True = 1, False = 0

5. Double​

許容差（m）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

TemplateCopy([3:1], [3:2], 0, 1, 1e-06)

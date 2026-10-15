# FindHoles()

FindHoles()

説明​

FindHoles

構文​

FindHoles(パートリスト（Cursor[]）, エッジリスト（Cursor[]）, 最小長さ（int）, 最大長さ（double）, 検索方法（double）)

入力​

1. Cursor[]​

パートリスト

2. Cursor[]​

エッジリスト

3. Double​

エッジ最小長さ

4. Double​

エッジ最大長さ

5. Int​

検索方法。全て=0, エッジのみ=1, パートのみ=2

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

FindHoles([3:1], [], 0, 12.345, 2)

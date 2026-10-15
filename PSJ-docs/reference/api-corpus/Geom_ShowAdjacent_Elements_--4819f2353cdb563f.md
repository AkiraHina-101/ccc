# Geom_ShowAdjacent_Elements()

Geom_ShowAdjacent_Elements()

説明​

要素（複数）を選択すると、指定された制約条件で隣接要素が表示されます

構文​

Geom_ShowAdjacent_Elements（double stopAngle,bool IncludeStopFace,int Layer,bool IsPreview,
    Cursor[] startFaceCursor,Cursor[] stopFaceCursor）

入力​

1. Double​

停止角度の値

2. Bool​

停止要素が含まれるかどうかの値

3. Int​

層の数

4. Bool​

結果がプレビューか実行か

5. Cursor[]​

開始要素のカーソルのリスト（[11: 要素ID]）

6. Cursor[]​

停止要素のカーソルのリスト（[11: 要素ID]）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

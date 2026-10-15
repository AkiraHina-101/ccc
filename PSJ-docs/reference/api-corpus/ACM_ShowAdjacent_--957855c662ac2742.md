# ACM_ShowAdjacent()

ACM_ShowAdjacent()

説明​

フェースを選択すると、指定された制約条件で隣接するフェースが表示されます。

構文​

ACM_ShowAdjacent(double stopAngle, bool IncludeStopFace, int Layer, bool IsPreview,
    bool bStopByNonma, bool bShowPartOnly, cursor[] startFaceCursor, cursor[] stopFaceCursor)

入力​

1. Double​

停止角度値

2. Bool​

停止フェースを含めるかどうかのブールフラグ 真 = 1、偽 = 0

3. Int​

レイヤー数

4. Bool​

結果がプレビューか実行か

5. Bool​

ノンマニホールドで停止するかどうかのブールフラグ 真 = 1、偽 = 0

6. Bool​

パートのみを表示するかどうかのブールフラグ 真 = 1、偽 = 0

7. Cursor[]​

開始フェースカーソルのリスト（[11:要素ID]）

8. Cursor[]​

停止フェースカーソルのリスト（[11:要素ID]）

戻り値​

"1"： 関数を実行できます

"0"： 関数を実行できません

サンプルコード​

ACM_ShowAdjacent(0, 0, 100, 0, 0, 0, [6:22], [])

# CreateFaceFromEdges()

CreateFaceFromEdges()

説明​

エッジからフェースを作成します。

構文​

CreateFaceFromEdges(cursor[] edgeList, cursor[] part, cursor[] nodeList, bool sharedFace,
    bool smoothFace, bool createPart, bool improved, bool barsOnly, bool onlyOnePart, bool useMidNodes)

入力​

1. Cursor[]​

対象のエッジカーソル([5:Edge ID])

2. Cursor[]​

対象のパートカーソル([3:Part ID])

3. Cursor[]​

対象の節点カーソル([10:Node ID])

4. Bool​

フェースを共有するかどうかの真偽値（True = 1, False = 0）

5. Bool​

フェースを滑らかにするかどうかの真偽値（True = 1, False = 0）

6. Bool​

新しいパートを作成するかどうかの真偽値（True = 1, False = 0）

7. Bool​

改善された真偽値（True = 1, False = 0）

8. Bool​

バーだけの真偽値（True = 1, False = 0）

9. Bool​

1つのパートのみの真偽値（True = 1, False = 0）

10. Bool​

中間節点を使用するかどうかの真偽値（True = 1, False = 0）

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

CreateFaceFromEdges([5:57, 5:38], [3:3], [], 0, 0, 1, 0, 0, 0, 0)

# AddItemsEdgeProjectEdgetoFace()

AddItemsEdgeProjectEdgetoFace()

説明​

エッジを最小の距離でフェースに射影して、アイテムを追加します

構文​

エッジをプロジェクトしてアイテムをフェースに追加（int[] FaceKey、int[] EdgeKey、bool ExtendToEdge）

入力​

1. Int[]​

エッジを射影する対象のフェース

2. Int[]​

射影する対象のエッジ

3. Bool​

新たに作成されたエッジを近くのエッジまで延長するか。true = 1, false = 0

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AddItemsEdgeProjectEdgetoFace([24], [42], 1)

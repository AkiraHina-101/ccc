# EntityInfo()

EntityInfo()

説明​

カーソルからエンティティ情報を取得します。

構文​

EntityInfo(cursor Entity, string Target)

入力​

1. Cursor​

エンティティカーソル ?:*

2. String​

ターゲット( CENTER = パート,面,エッジ,要素 NORMAL = 面,要素 COORD = 節点 XMAX = パート,面,エッジ,要素 XMIN = パート,面,エッジ,要素 YMAX = パート,面,エッジ,要素 YMIN = パート,面,エッジ,要素 ZMAX = パート,面,エッジ,要素 ZMIN = パート,面,エッジ,要素 MATNAME = パート,面,エッジ,要素 MATERIAL= パート,面,エッジ,要素)

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

EntityInfo(3:1,"CENTER")

または

EntityInfo(6:26,"NORMAL")

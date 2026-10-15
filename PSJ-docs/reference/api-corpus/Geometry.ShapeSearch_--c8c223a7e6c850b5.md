# Geometry.ShapeSearch()

Geometry.ShapeSearch()

説明​

指定したパート内で形状を検索します。

構文​

Geometry.ShapeSearch(...)

マクロ：

リボン：Geometry » ShapeSearch

入力​

crlParts​

ターゲットパートを指定する Cursor のリスト。

この入力は必須です。

crlRefEdges​

参照エッジを指定する Cursor のリスト。

デフォルト値は[]です。

iGroupOption​

グループ化オプションを指定する Integer 。

デフォルト値は0です。

strGroupName​

グループの名前を指定する String 。

デフォルト値は""です。

listShapeSearchOptions​

対象の検索オプションを指定する SHAPE_SEARCH_OPTION のリスト。

bConvexOption​

凸形状を含めるかどうかを示す Boolean 。

デフォルト値は False です。

bConcaveOption ​

凹形状を含めるかどうかを示す Boolean 。

デフォルト値は False です。

戻り値​

検出されたエンティティを示す CustorStr のリスト。

サンプルコード​

# モデルの準備
Geometry.Part.Cylinder(iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], iPartColor=7434735)

JPT.ClearAllSelection()
# 平面フェースを検索して選択する。
result=Geometry.ShapeSearch(crlParts=[Part(1, 2)], listShapeSearchOptions=[SHAPE_SEARCH_OPTION(iType=4, bAll=1)])
print(f"平面フェースが {len(result)} 個あります。")

JPT.ClearAllSelection()
# 完全な円柱フェースを検索して選択する。
result=Geometry.ShapeSearch(crlParts=[Part(1, 2)], listShapeSearchOptions=[SHAPE_SEARCH_OPTION(iType=8, bAll=1)])
print(f"完全な円柱フェースが {len(result)} 個あります。")

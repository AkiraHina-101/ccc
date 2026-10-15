# Geometry.Transform.ThreePoints()

Geometry.Transform.ThreePoints()

説明​

3 組の節点を選択してパートを移動します。選択されたパートは、元のパートと移動先の間で 1:1 の関連付けで移動されます。

構文​

Geometry.Transform.ThreePoints(...)

リボン: Geometry » Transform » ThreePoints

入力​

crlTargetParts​

移動するパートを指定する Cursor のリスト。

これは必須の入力です。

poslOriginalPoints​

移動に使用される元のポイントを指定する Vector のリスト。
移動には、それぞれ 3 つの元のポイントに対応する 3 点が必要です。

これは必須の入力です。

poslNextPoints​

移動に使用される次のポイントを指定する Vector のリスト。
3 つの次のポイントが、それぞれ poslOriginalPoints で定義された 3 つの元のポイントに対応しています。

これは必須の入力です。

bCreateNewPart​

移動後のパートを新しいパートにコピーするかどうかを指定する Boolean 型。

True の場合、新しいパートが新しい位置にコピーされます。

False の場合、元のパートが新しい位置に移動します。

デフォルト値は False です。

bCopyLBC​

既存のパートから新しいパートに負荷境界条件をコピーするかどうかを指定する Boolean 型。この引数は、bCreateNewPart=True の場合の機能にのみ影響します。

デフォルト値は False です。

bCopyProperty​

既存のパートから新しいパートにプロパティをコピーするかどうかを選択する Boolean 型。この引数は、bCreateNewPart=True の場合の機能にのみ影響します。

デフォルト値は False です。

bCopyReference​

既存のパートから新しいパートに参照をコピーするかどうかを選択する Boolean 型。この引数は、bCreateNewPart=True の場合の機能にのみ影響します。

デフォルト値は False です。

戻り値​

生成されたパートを指定する Cursor のリスト。

サンプルコード​

target_part = Geometry.Part.Cube()
move_part = Geometry.Part.Cube(dlOrigin=[0.012, 0.0, 0.0], 
                               strName="Cube_2", 
                               iPartColor=6409934)

created_parts = Geometry.Transform.ThreePoints(crlTargetParts=[move_part],
                                               poslOriginalPoints=[[0.022, 0, 0.01], 
                                                                   [0.022, 0.01, 0.01], 
                                                                   [0.012, 0, 0.01]],
                                               poslNextPoints=[[0.01, 0, 0.01], 
                                                               [0, 0, 0.01], 
                                                               [0, 0.01, 0.01]],
                                               bCreateNewPart=True, 
                                               bCopyLBC=True, 
                                               bCopyProperty=True,
                                               bCopyReference=True)

JPT.Debugger(created_parts)

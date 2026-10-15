# Geometry.ExtractSurfaces()

Geometry.ExtractSurfaces()

説明​

指定された角度以下で隣接する表面を再帰的に見つけて新しいパートを作成します。

構文​

Geometry.ExtractSurfaces(...)

Ribbon: Geometry » Extract Surfaces

入力​

crlFaces​

抽出プロセスに使用する開始面を指定する Cursor リスト。

これは必須入力です。

dFaceAngle​

選択した面から隣接する面に広がるために使用される制限角を指定する Double 。

_dFaceAngle=-1_の場合、選択した面のみが抽出されます。

デフォルト値は60.0です。

strName​

関数を実行した後に作成されるパートの名前を指定する String 。

デフォルト値は「ExtractFace_1」です。

bMergePart​

作成されたパートを1つのパートにマージするかどうかを指定する Boolean 型。

デフォルト値は False です。

戻り値​

作成されたパートを指定する Cursor リスト。

サンプルコード​

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.011, 0.0, 0.0],
                   strName="Cube_2",
                   iPartColor=6409934)
bodies = Geometry.ExtractSurfaces([Face(52, 26)],
                                  dFaceAngle=-1.0,
                                  strName="ExtractFace_4",
                                  bMergePart=True)
JPT.Debugger(bodies)

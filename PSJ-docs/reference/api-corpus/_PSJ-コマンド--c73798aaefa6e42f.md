# 🆕 PSJ-コマンド

🆕 PSJ-コマンド

前書き​

マクロと同等ですが、PSJ-コマンドは、コンパクトで、書きやすく、Python と完全に互換性があるように洗練されています。
この新しい PSJ 機能は、Jupiter バージョン 5 から導入されました。

特別な機能​

クラスベース形式​

PSJ-コマンドの関数は、クラスベースの形式とJupiter のリボンにちなんで名付けられています。

たとえば、デフォルトの入力値で立方体を作成します。

PSJ-コマンド

マクロ

Geometry.Part.Cube(dlOrigin=[0, 0, 0], dlLength=[10, 10, 10], ilAxialNodes=[10, 10, 10],
  strName="Cube_1", iPartColor=7105764, crLocalCoordinate=None)

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0)

PSJ-コマンド の引数は、標準の命名規則に従います。

コンパクト​

PSJ-コマンドのパラメーターは、デフォルト値が使用されている場合は無視されます。

たとえば、デフォルトの入力値で立方体を作成します。

PSJ-コマンド

マクロ

Geometry.Part.Cube()

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0)

明示的​

PSJ-コマンドは、明示的な定義のおかげで読みやすくなっています。

たとえば、面上の２点間にエッジを引きます：

PSJ-コマンド

マクロ

Geometry.Edge.Line(veclPosition=[[7.8, 0, 10], [2.2, 10, 10]], crlTargetFace=[Face(26)])

ImprintLineS([[7.8, 0, 10], [2.2, 10, 10]], [6:26], 1)

戻り値​

PSJ-コマンドには、コードをより Pythonicに見せることができる戻り値があります。

たとえば、作成したばかりの 2 つのキューブを削除します:

PSJ-コマンド

マクロ

cube1 = Geometry.Part.Cube()
cube2 = Geometry.Part.Cube(dlOrigin=[10.0, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.DeleteEntity.Part(crlParts=[cube1, cube2])

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0)
CreateCube([10, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_2", 6409934, 0:0)
DeletePartCr([3:1, 3:2])

エラー処理​

PSJ-コマンドにはエラー処理が組み込まれています。これにより、開発者はバグをすばやく簡単に見つけることができます。

たとえば、次のように間違った形式でコードを入力します。

# 以下の入力の2番目のパラメーターの名前が間違っています
Geometry.Part.Cube(dlOrigin=[10.0, 0.0, 0.0], strame="Cube_1")

上記のコードを実行すると、PythonAPI ウィンドウにエラーが表示されます。

IDE がサポートされています​

PSJ-コマンドは、customized IDEまたはVSCode 拡張で完全にサポートされています。

続きを読む

使用可能な PSJ コマンドの完全なリストを取得するには、スクリプト APIを参照してください。

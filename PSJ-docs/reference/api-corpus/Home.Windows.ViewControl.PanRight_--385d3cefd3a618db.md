# Home.Windows.ViewControl.PanRight()

Home.Windows.ViewControl.PanRight()

説明​

ビューを入力した移動量だけ右に移動します。

構文​

Home.Windows.ViewControl.PanRight(...)

マクロ:

リボン: Home » Windows » ViewControl » PanRight

入力​

dDistance​

画面上でビューが右に移動する相対移動量を指定する Double です。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを示す Boolean 型です:

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.PanRight(dDistance=50)

# Home.Windows.ViewControl.PanUp()

Home.Windows.ViewControl.PanUp()

説明​

入力された移動量だけ、ビューを上に移動します。

構文​

Home.Windows.ViewControl.PanUp(...)

マクロ：

リボン：Home » Windows » ViewControl » PanUp

入力​

dDistance​

ビューを上に移動する画面上の相対的な移動量を指定する Double です。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを示す Boolean 型です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.PanUp(dDistance=50)

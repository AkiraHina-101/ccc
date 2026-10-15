# Home.Windows.ViewControl.PanLeft()

Home.Windows.ViewControl.PanLeft()

説明​

画面を入力した移動量だけ左に移動します。

構文​

Home.Windows.ViewControl.PanLeft(...)

マクロ：

リボン：Home » Windows » ViewControl » PanLeft

入力​

dDistance​

画面上でのビューの左方向への相対移動量を指定する Double です。

これは必須入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean 型です：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.PanLeft(dDistance=50)

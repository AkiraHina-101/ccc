# Home.Windows.ViewControl.Rotate()

Home.Windows.ViewControl.Rotate()

説明​

入力された角度ごとにモデル全体を各軸まわりに回転させます。

構文​

Home.Windows.ViewControl.Rotate(...)

マクロ:

リボン: Home » Windows » ViewControl » Rotate

入力​

dlAngle​

各軸（X、Y、Z）ごとにモデル全体を回転させる角度（度）を指定する Double 型のリストです。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスが正常に実行されました。

False: 機能を実行できません。

サンプルコード​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.Rotate(dlAngle=[0, 20, 20])

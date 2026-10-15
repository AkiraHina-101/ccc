# Home.Windows.ViewControl.SetCenter()

Home.Windows.ViewControl.SetCenter()

説明​

モデルの回転の中心を設定します。

構文​

Home.Windows.ViewControl.SetCenter(...)

マクロ：

リボン：Home » Windows » ViewControl » SetCenter

入力​

dlCenter​

モデルの回転中心座標を指定する _Double 型のリスト_です。回転中心座標の単位は、現在のドキュメントの単位に応じて取られます。

これは必須の入力です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean型 です：

True：プロセスは正常に実行されました。

False：関数を実行できません。

サンプル コード​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.SetCenter(dlCenter=[0.0, 0.01, 0.0])

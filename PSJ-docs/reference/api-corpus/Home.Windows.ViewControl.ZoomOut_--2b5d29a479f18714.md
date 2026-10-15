# Home.Windows.ViewControl.ZoomOut()

Home.Windows.ViewControl.ZoomOut()

説明​

ズーム比率でビューを縮小します。

構文​

Home.Windows.ViewControl.ZoomOut(...)

マクロ：

リボン：Home » Windows » ViewControl » ZoomOut

入力​

dZoom​

ズームアウト比率を指定する Double 。ズーム比率は1より大きい必要があります。

入力値が範囲内（0:1）の場合、ズーム比率 = 1/(入力値)となります。

デフォルト値は1.2です。

戻り値コード​

プロセスが正常に実行されたかどうかを指定する Boolean 型：

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.ZoomOut(dZoom=1.15)

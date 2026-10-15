# Home.Windows.ViewControl.ZoomIn()

Home.Windows.ViewControl.ZoomIn()

説明​

ズーム比率でビューをズームインします。

構文​

Home.Windows.ViewControl.ZoomIn(...)

マクロ:

リボン: Home » Windows » ViewControl » ZoomIn

入力​

dZoom​

ズームイン比率を指定する Double 。ズーム比率は範囲（0:1）内である必要があります。

入力された値が1より大きい場合、ズーム比率は 1/(入力値) になります。

デフォルト値は 0.83333333 です。

戻り値​

プロセスの実行が成功したかどうかを指定する Boolean 型:

True: プロセスが成功裏に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()
Home.Windows.ViewControl.FitToModel()
Home.Windows.ViewControl.ZoomIn(dZoom=0.3)

# MainWindow.ViewPoint.SetUserViewPoint()

MainWindow.ViewPoint.SetUserViewPoint()

説明​

ユーザービューポイントを設定します。

構文​

MainWindow.ViewPoint.SetUserViewPoint(...)

マクロ:

リボン: MainWindow » ViewPoint » SetUserViewPoint

入力​

strName​

ビューポイントの名前を指定する String 。

これは必須の入力です。

bRotate​

ビューを回転するかどうかを指定する Boolean 型。

デフォルト値は True です。

bPan​

ビューをパンするかどうかを指定する Boolean 型。

デフォルト値は True です。

bScale​

ビューのスケールを指定する Boolean 型。

デフォルト値は True です。

戻り値​

成功した場合は 1 の String を返し、失敗した場合は 0 を返します。

サンプルコード​

JPT.Exec('ViewReset()')
JPT.Exec('ViewControl_Rotate([0, -60, 0])')
JPT.Exec('ViewControl_SetCenter([0.005, 0.005, 0.005])')
JPT.Exec('AddUserViewPoint("New View Point")')
JPT.Exec('ViewReset()')
MainWindow.ViewPoint.SetUserViewPoint(strName="New View Point")

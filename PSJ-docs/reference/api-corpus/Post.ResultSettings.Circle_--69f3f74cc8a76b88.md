# Post.ResultSettings.Circle()

Post.ResultSettings.Circle()

説明​

円の表示設定を設定します。

構文​

Post.ResultSettings.Circle(...)

マクロ: CmdPostCircleSettings

リボン: Post » ResultSettings » Circle

入力​

postDataVizOptCircle​

_POST_DATA_VIZ_OPT_CIRCLE_を指定し、円の表示のすべての設定を指定します。

デフォルト値はPOST_DATA_VIZ_OPT_CIRCLEです。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean:

True: プロセスが正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Post.ResultSettings.Circle(postDataVizOptCircle=PostDataVizOptCircle(dRatioModel=0.05, dRatioScreen=0.05))

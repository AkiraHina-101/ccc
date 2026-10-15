# Post.ResultSettings.FFT3DDisplay()

Post.ResultSettings.FFT3DDisplay()

説明​

FFT3Dの表示結果設定をセットアップします。

構文​

Post.ResultSettings.FFT3DDisplay(...)

マクロ: CmdPostFFT3DDisplaySettings

リボン: Post » ResultSettings » FFT3DDisplay

入力​

postDataVizOptBDPP​

FFT3D表示のすべての設定を指定する POST_DATA_VIZ_OPT_BDPP です。

デフォルト値は POST_DATA_VIZ_OPT_BDPP です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Post.ResultSettings.FFT3DDisplay(postDataVizOptBDPP=PostDataVizOptBDPP(
                                dLayerPointSize=2.0, 
                                dLineWidth=2.0, 
                                dPointSize=2.0, 
                                dDotDistance=0.05))

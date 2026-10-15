# Home.ImportResults.MuxWeld()

Home.ImportResults.MuxWeld()

説明​

Mux-Weldの結果ファイルをインポートします。

構文​

Home.ImportResults.MuxWeld(...)

マクロ: ImportMuxWeld

リボン: Home » ImportResults » MuxWeld

入力​

strPath​

Mux-Weldの結果ファイルパスを指定する String です。

これは必須の入力です。

iImportType​

インポートタイプを指定する Integer です。LS-Dynaの場合、常に1に設定されます。

デフォルト値は1です。

dFaceAngle​

フェース分割を決定するための角度許容度を指定する Double 型です（指定値より小さい角度の隣接要素間にエッジを作成することで）。

デフォルト値は60.0（度）です。

dEdgeAngle​

エッジ分割を決定するための角度許容度を指定する Double 型です（指定値より大きい角度の隣接エッジ要素に頂点を作成することで）。

デフォルト値は60.0（度）です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True：MuxWeldの結果が正常にインポートされました。

False：MuxWeldの結果をインポートできませんでした。

サンプルコード​

#サンプルmux-weldファイルのパスを設定してください。
filepath="C:/Temp/Sample.wsi"

Home.ImportResults.MuxWeld(filepath)

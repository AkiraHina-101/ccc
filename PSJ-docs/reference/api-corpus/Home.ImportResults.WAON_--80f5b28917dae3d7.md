# Home.ImportResults.WAON()

Home.ImportResults.WAON()

説明​

Jupiter データベースに WAON 結果ファイルをインポートします。

構文​

Home.ImportResults.WAON(...)

マクロ: CmdImportTSVWAONPost

リボン: Home » ImportResults » WAON

入力​

strPath​

BEM ファイル（.bdf）を指定する String です。

この入力は必須です。

strFPMFilePath​

FPM ファイル（.bdf）を指定する String です。

この入力は必須です。

strResultFolderPath​

結果フォルダを指定する String です。

この入力は必須です。

iImportType​

WAON ファイルのインポートタイプを指定する Integer です。常に 1 に設定されます。

デフォルト値は 1 です。

dFaceAngle​

フェース分割を決定するための角度許容値を指定する Double 型です（指定値以下の角度を持つ隣接要素間にエッジを作成することによって）。

デフォルト値は 60.0（度）です。

dEdgeAngle​

エッジ分割を決定するための角度許容値を指定する Double 型です（指定値を超える角度を持つ隣接エッジ要素に頂点を作成することによって）。

デフォルト値は 60.0（度）です。

bReadLoadAndConstraint​

ロードおよび拘束を読み取るかどうかを指定する Boolean です。

デフォルト値は False です。

bReadConnection​

接続を読み取るかどうかを指定する Boolean です。

デフォルト値は False です。

bCreateResultsAtMidNode​

中央節点で結果を作成するかどうかを指定する Boolean です。

デフォルト値は False です。

戻り値​

関数が正常に実行されたかどうかを指定する Boolean 型です：

True: WAON 結果が正常にインポートされました。

False: WAON 結果をインポートできませんでした。

サンプルコード​

# サンプル WAON ファイルへのパスを設定してください。
filepath="C:/Temp/"
bem_file = filepath + "BEM.bdf"
fpm_file = filepath + "FPM.bdf"
result = base_FILEPATH + "result/"
Home.ImportResults.WAON(bem_file, 
                        fpm_file, 
                        result, 
                        bReadLoadAndConstraint=True, 
                        bReadConnection=True, 
                        bCreateResultsAtMidNode=True)

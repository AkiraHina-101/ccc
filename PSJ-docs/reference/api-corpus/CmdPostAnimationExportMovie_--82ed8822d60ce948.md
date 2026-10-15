# CmdPostAnimationExportMovie()

CmdPostAnimationExportMovie()

説明​

アニメーションのエクスポート

注意

このコマンドはV5.1 で CmdPostAnimationExportMovieToFile に置き換えられました。

構文​

CmdPostAnimationExportMovie(string フルパス, int コーデック, int フレームレート, int 繰り返し, bool 画像作成, int 画面幅, int 画面高さ, bool 最適化)

入力​

1. string ​

エクスポートするアニメーションのフルパス。

2. int ​

コーデックオプション。0: インテルIYUVコーデック、1:インテルIYUVコーデック、2:マイクロソフトビデオ1、3:テックスミススクリーンキャプチャコーデック、4:テックスミススクリーンコーデック2。

3. int ​

秒あたりのフレーム数。

4. int ​

繰り返し。

5. bool ​

画像作成オプション。0: いいえ、1: はい。

6. int ​

画面幅。

7. int ​

画面高さ。

8. bool ​

True（1）の場合、アニメーションを最適化します。

戻り値​

なし。

サンプルコード​

CmdPostAnimationExportMovie("C:/Users/Admin/Pictures/1.avi", 0, 5, 1, 0)
CmdPostAnimationExportMovie("C:/Users/Admin/Videos/opt.gif", 0, 5, 1, 1, 0, 0, 1)

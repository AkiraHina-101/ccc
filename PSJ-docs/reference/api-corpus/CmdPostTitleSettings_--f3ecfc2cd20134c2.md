# CmdPostTitleSettings()

CmdPostTitleSettings()

説明​

タイトル設定。

構文​

CmdPostTitleSettings(bool ResultName,bool Convection,bool Unit,bool Coordinate,bool TotalMaxMin,bool FileName,bool Location,bool VisibleMaxMin,bool Animation,bool DeformRatio,bool Detail,int SizeTitleTarget,int SizeDesTarget,int ResultTitle,color ResultTitle,bool ResultTitle,int ResultDescription,color ResultDescription,bool ResultDescription,bool UseBackground,color FillBackground,color BorderBackground,float Percentage)

入力​

1. bool​

結果名のフラグ。

2. bool​

対流フラグ。

3. bool​

単位フラグ。

4. bool​

座標フラグ。

5. bool​

最大値/最小値フラグ。

6. bool​

ファイル名フラグ。

7. bool​

位置フラグ。

8. bool​

最大/最小値の表示フラグ。

9. bool​

アニメーションフラグ。

10. bool​

変形率フラグ。

11. bool​

詳細フラグ。

12. int​

結果タイトルのフォントサイズ。

13. int​

結果説明のフォントサイズ。

14. int​

結果タイトル、

15. color​

結果タイトルの色、

16. bool​

結果タイトルの太字フラグ、

17. int​

結果説明、

18. color​

結果説明の色。

19. bool​

結果説明の太字フラグ、

20. bool​

背景使用フラグ。

21. color​

背景色

22. color​

背景の枠線色、

23. float​

透明度。

戻り値​

なし。

サンプルコード​

CmdPostTitleSettings(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 5, 6, 16777215, 1, 5, 16777215, 0, 0, 16777215, 16777215, 0.500000)

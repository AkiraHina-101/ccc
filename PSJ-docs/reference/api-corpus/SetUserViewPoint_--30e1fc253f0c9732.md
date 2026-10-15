# SetUserViewPoint()

SetUserViewPoint()

説明​

値でビューポイントを設定します。

構文​

SetUserViewPoint(float trans[0], float trans[1], float trans[2], float trans[3], float trans[4], float trans[5], float trans[6], float trans[7], float trans[8], float trans[9], float trans[10], float trans[11], float trans[12], float trans[13], float trans[14], float trans[15], float Cent[0], float Cent[1], float Cent[2], float PanOffsetX, float PanOffsetY, float ScaleFactor, bool Rotate, bool Pan, bool Scale)

入力​

1. float ​

4x4 変換行列の 00 です（00 - 33）。

2. float ​

4x4 変換行列の 01 です。

3. float ​

4x4 変換行列の 02 です。

4. float ​

4x4 変換行列の 03 です。

5. float ​

4x4 変換行列の 10 です。

6. float ​

4x4 変換行列の 11 です。

7. float ​

4x4 変換行列の 12 です。

8. float ​

4x4 変換行列の 13 です。

9. float ​

4x4 変換行列の 20 です。

10. float ​

4x4 変換行列の 21 です。

11. float ​

4x4 変換行列の 22 です。

12. float ​

4x4 変換行列の 23 です。

13. float ​

4x4 変換行列の 30 です。

14. float ​

4x4 変換行列の 31 です。

15. float ​

4x4 変換行列の 32 です。

16. float ​

4x4 変換行列の 33 です。

17. float ​

回転の中心 x です。

18. float ​

回転の中心 y です。

19. float ​

回転の中心 z です。

20. float ​

オフセット x です。

21. float ​

オフセット y です。

22. float ​

スケールファクターです。

23. bool ​

回転フラグです。

24. bool ​

パンフラグです。

25. bool ​

スケールフラグです。

戻り値コード​

なし。

サンプルコード​

SetUserViewPoint(-0.707107, -0.5, 0.5, 0, 0.707107, -0.5, 0.5, 0, 0, 0.707107, 0.707107, 0, 0, 0, 0, 1, 0.00188554, -0.00188527, 0.1, 0, 0, 0.211944, 1, 1, 1)

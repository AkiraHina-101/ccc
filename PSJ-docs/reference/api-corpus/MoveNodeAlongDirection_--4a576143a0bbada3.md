# MoveNodeAlongDirection()

MoveNodeAlongDirection()

説明​

節点を指定された方向に移動します

構文​

MoveNodeAlongDirection(double dX, double dY, double dZ, double planept[0][0],
    double planept[0][1], double planept[0][2], double planept[1][0], double planept[1][1],
    double planept[1][2], double planept[2][0], double planept[2][1], double planept[2][2],
    Cursor face, double magnitude, bool facepicked, bool elempicked, int[] node)

入力​

1. Double​

X方向の変位

2. Double​

Y方向の変位

3. Double​

Z方向の変位

4. Double​

平面点1の第1座標

5. Double​

平面点1の第2座標

6. Double​

平面点1の第3座標

7. Double​

平面点2の第1座標

8. Double​

平面点2の第2座標

9. Double​

平面点2の第3座標

10. Double​

平面点3の第1座標

11. Double​

平面点3の第2座標

12. Double​

平面点3の第3座標

13. Cursor​

選択されたフェースのカーソル

14. Double​

マグニチュード

15. Bool​

フェースが選択されているかどうか 0=いいえ,1=はい

16. Bool​

要素が選択されているかどうか 0=いいえ,1=はい

17. Int[]​

節点リスト

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

MoveNodeAlongDirection(0.00333333, 0, -0.00111111, 0.01, 0, 0, 0.01, 0.00111111, 0,
    0.01, 0.00111111, 0.00111111, 6:24, 0.00351364, 1, 0, [443, 437])

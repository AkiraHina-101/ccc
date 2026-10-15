# CmdSetPostUnit()

CmdSetPostUnit()

説明​

プリファレンスでポストユニットを設定します。

構文​

CmdSetPostUnit(int[] origUnit, int[] currUnit)

入力​

1. origUnit::int ​

力

2. origUnit::int ​

角度

3. origUnit::int ​

温度

4. origUnit::int ​

モーメント

5. origUnit::int ​

エネルギー

6. origUnit::int ​

パワー

7. origUnit::int ​

変位

8. origUnit::int ​

応力

9. origUnit::int ​

速度

10. origUnit::int ​

加速度

11. origUnit::int ​

角速度

12. origUnit::int ​

角加速度

13. origUnit::int ​

エネルギー密度

14. origUnit::int ​

温度勾配

15. origUnit::int ​

熱流

16. currUnit::int ​

力

17. currUnit::int ​

角度

18. currUnit::int ​

温度

19. currUnit::int ​

モーメント

20. currUnit::int ​

エネルギー

21. currUnit::int ​

パワー

22. currUnit::int ​

変位

23. currUnit::int ​

応力

24. currUnit::int ​

速度

25. currUnit::int ​

加速度

26. currUnit::int ​

角速度

27. currUnit::int ​

角加速度

28. currUnit::int ​

エネルギー密度

29. currUnit::int ​

温度勾配

30. currUnit::int ​

熱フラックス

戻り値​

なし。

サンプルコード​

CmdSetPostUnit([0, 0, 1, 3, 2, 2, 2, 2, 1, 1, 0, 0, 1, 1, 1], [0, 1, 1, 3, 2, 2, 2, 2, 1, 1, 0, 0, 1, 1, 1])

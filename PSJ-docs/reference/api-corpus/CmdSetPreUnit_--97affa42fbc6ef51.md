# CmdSetPreUnit()

CmdSetPreUnit()

説明​

設定の優先単位を設定します。

構文​

CmdSetPostUnit(origUnit[], currUnit[])

入力​

1. origUnit::int​

長さ

2. origUnit::int​

時間

3. origUnit::int​

質量

4. origUnit::int​

力

5. origUnit::int​

角度

6. origUnit::int​

温度

7. origUnit::int​

面積

8. origUnit::int​

体積

9. origUnit::int​

速度

10. origUnit::int​

加速度

11. origUnit::int​

角速度

12. origUnit::int​

角加速度

13. origUnit::int​

モーメント

14. origUnit::int​

圧力

15. origUnit::int​

密度

16. origUnit::int​

剛性

17. origUnit::int​

回転剛性

18. origUnit::int​

減衰係数

19. origUnit::int​

回転減衰係数

20. origUnit::int​

弾性率

21. origUnit::int​

エネルギー

22. origUnit::int​

パワー

23. origUnit::int​

熱膨張係数

24. origUnit::int​

熱伝導率

25. origUnit::int​

対流係数

26. origUnit::int​

比熱

27. origUnit::int​

熱流束

28. origUnit::int​

発熱

29. origUnit::int​

単位長さあたりの質量

30. origUnit::int​

単位面積あたりの質量

31. origUnit::int​

慣性モーメント（面積）

32. origUnit::int​

ねじり定数

33. origUnit::int​

ひずみ係数

34. origUnit::int​

単位長さあたりの慣性モーメント

35. origUnit::int​

慣性モーメント

36. origUnit::int​

応力

37. origUnit::int​

ひずみ

38. origUnit::int​

ひずみエネルギー

39. origUnit::int​

熱エネルギー

40. origUnit::int​

周波数

41. origUnit::int​

体積エネルギー密度

42. origUnit::int​

電気抵抗率

43. origUnit::int​

応力の逆数

44. origUnit::int​

熱放射

45. origUnit::int​

変位

この値は、長さ設定の origUnit によって自動的に上書きされます。

46. origUnit::int​

エネルギー密度

47. origUnit::int​

温度勾配

48. CurrUnit::int​

長さ

49. CurrUnit::int​

時間

50. CurrUnit::int​

質量

51. CurrUnit::int​

力

52. CurrUnit::int​

角度

53. CurrUnit::int​

温度

54. CurrUnit::int​

面積

55. CurrUnit::int​

体積

56. CurrUnit::int​

速度

57. CurrUnit::int​

加速度

58. CurrUnit::int​

角速度

59. CurrUnit::int​

角加速度

60. CurrUnit::int​

モーメント

61. CurrUnit::int​

圧力

62. CurrUnit::int​

密度

63. CurrUnit::int​

剛性

64. CurrUnit::int​

回転剛性

65. CurrUnit::int​

減衰係数

66. CurrUnit::int​

回転減衰係数

67. CurrUnit::int​

弾性率

68. CurrUnit::int​

エネルギー

69. CurrUnit::int​

パワー

70. CurrUnit::int​

熱膨張係数

71. CurrUnit::int​

熱伝導率

72. CurrUnit::int​

対流係数

73. CurrUnit::int​

比熱

74. CurrUnit::int​

熱流束

75. CurrUnit::int​

発熱

76. CurrUnit::int​

単位長さあたりの質量

77. CurrUnit::int​

単位面積あたりの質量

78. CurrUnit::int​

慣性モーメント（面積）

79. CurrUnit::int​

ねじり定数

80. CurrUnit::int​

ひずみ係数

81. CurrUnit::int​

単位長さあたりの慣性モーメント

82. CurrUnit::int​

慣性モーメント

83. CurrUnit::int​

応力

84. CurrUnit::int​

ひずみ

85. CurrUnit::int​

ひずみエネルギー

86. CurrUnit::int​

熱エネルギー

87. CurrUnit::int​

周波数

88. CurrUnit::int​

体積エネルギー密度

89. CurrUnit::int​

電気抵抗率

90. CurrUnit::int​

応力の逆数

91. CurrUnit::int​

熱放射

92. CurrUnit::int​

変位

この値は、CurrUnit の長さ設定によって自動的に上書きされます。

93. CurrUnit::int​

エネルギー密度

94. CurrUnit::int​

温度勾配

戻り値​

なし

サンプルコード​

CmdSetPreUnit([0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 2, 1, 0, 1, 0, 1, 1], [0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 2, 1, 0, 1, 0, 1, 1])

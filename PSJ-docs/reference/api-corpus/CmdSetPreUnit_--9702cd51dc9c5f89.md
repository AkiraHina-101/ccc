# CmdSetPreUnit()

CmdSetPreUnit()

Description​

Set pre unit in Preference.

Syntax​

CmdSetPostUnit(origUnit[], currUnit[])

Inputs​

1. origUnit::int ​

Length

2. origUnit::int ​

Time

3. origUnit::int ​

Mass

4. origUnit::int ​

Force

5. origUnit::int ​

Angle

6. origUnit::int ​

Temperature

7. origUnit::int ​

Area

8. origUnit::int ​

Volume

9. origUnit::int ​

Velocity

10. origUnit::int ​

Acceleration

11. origUnit::int ​

Angle Velocity

12. origUnit::int ​

Anglar Acceleration

13. origUnit::int ​

Moment

14. origUnit::int ​

Pressure

15. origUnit::int ​

Density

16. origUnit::int ​

Stiffness

17. origUnit::int ​

Rotate Stiff

18. origUnit::int ​

Damping Coefficient

19. origUnit::int ​

Rotate Damping Coefficient

20. origUnit::int ​

Elastic Modulus

21. origUnit::int ​

Energy

22. origUnit::int ​

Power

23. origUnit::int ​

Thermal Expansion Coefficient

24. origUnit::int ​

Thermal Conductivity

25. origUnit::int ​

Convection Coefficient

26. origUnit::int ​

Specific Heat

27. origUnit::int ​

Heat Flux

28. origUnit::int ​

Heat Generation

29. origUnit::int ​

Mass Per Unit Length

30. origUnit::int ​

Mass Per Unit Area

31. origUnit::int ​

Moment Of Inertia (Area)

32. origUnit::int ​

Torsional Constant

33. origUnit::int ​

Warping Coefficient

34. origUnit::int ​

Mass Moment Of Intertia Per Unit Length

35. origUnit::int ​

Mass Moment of Intertia

36. origUnit::int ​

Stress

37. origUnit::int ​

Strain

38. origUnit::int ​

Strain Energy

39. origUnit::int ​

Thermal Energy

40. origUnit::int ​

Frequency

41. origUnit::int ​

Volume Energy Density

42. origUnit::int ​

Electrical Resistivity

43. origUnit::int ​

Stress Reciprocal

44. origUnit::int ​

Thermal Radiation

45. origUnit::int ​

Displacement

This value is automatically overwritten by origUnit of Length setting.

46. origUnit::int ​

Energy Density

47. origUnit::int ​

Temperature Gradient

48. CurrUnit::int ​

Length

49. CurrUnit::int ​

Time

50. CurrUnit::int ​

Mass

51. CurrUnit::int ​

Force

52. CurrUnit::int ​

Angle

53. CurrUnit::int ​

Temperature

54. CurrUnit::int ​

Area

55. CurrUnit::int ​

Volume

56. CurrUnit::int ​

Velocity

57. CurrUnit::int ​

Acceleration

58. CurrUnit::int ​

Angle Velocity

59. CurrUnit::int ​

Anglar Acceleration

60. CurrUnit::int ​

Moment

61. CurrUnit::int ​

Pressure

62. CurrUnit::int ​

Density

63. CurrUnit::int ​

Stiffness

64. CurrUnit::int ​

Rotate Stiff

65. CurrUnit::int ​

Damping Coefficient

66. CurrUnit::int ​

Rotate Damping Coefficient

67. CurrUnit::int ​

Elastic Modulus

68. CurrUnit::int ​

Energy

69. CurrUnit::int ​

Power

70. CurrUnit::int ​

Thermal Expansion Coefficient

71. CurrUnit::int ​

Thermal Conductivity

72. CurrUnit::int ​

Convection Coefficient

73. CurrUnit::int ​

Specific Heat

74. CurrUnit::int ​

Heat Flux

75. CurrUnit::int ​

Heat Generation

76. CurrUnit::int ​

Mass Per Unit Length

77. CurrUnit::int ​

Mass Per Unit Area

78. CurrUnit::int ​

Moment Of Inertia (Area)

79. CurrUnit::int ​

Torsional Constant

80. CurrUnit::int ​

Warping Coefficient

81. CurrUnit::int ​

Mass Moment Of Intertia Per Unit Length

82. CurrUnit::int ​

Mass Moment of Intertia

83. CurrUnit::int ​

Stress

84. CurrUnit::int ​

Strain

85. CurrUnit::int ​

Strain Energy

86. CurrUnit::int ​

Thermal Energy

87. CurrUnit::int ​

Frequency

88. CurrUnit::int ​

Volume Energy Density

89. CurrUnit::int ​

Electrical Resistivity

90. CurrUnit::int ​

Stress Reciprocal

91. CurrUnit::int ​

Thermal Radiation

92. CurrUnit::int ​

Displacement

This value is automatically overwritten by Length setting of CurrUnit.

93. CurrUnit::int ​

Energy Density

94. CurrUnit::int ​

Temperature Gradient

Return Code​

Nothing.

Sample Code​

CmdSetPreUnit([0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 2, 1, 0, 1, 0, 1, 1], [0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 2, 1, 0, 1, 0, 1, 1])

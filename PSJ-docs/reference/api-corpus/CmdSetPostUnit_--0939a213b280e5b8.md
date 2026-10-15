# CmdSetPostUnit()

CmdSetPostUnit()

Description​

Set post unit in Preference.

Syntax​

CmdSetPostUnit(int[] origUnit, int[] currUnit)

Inputs​

1. origUnit::int ​

Force

2. origUnit::int ​

Angle

3. origUnit::int ​

Temperature

4. origUnit::int ​

Moment

5. origUnit::int ​

Energy

6. origUnit::int ​

Power

7. origUnit::int ​

Displacement

8. origUnit::int ​

Stress

9. origUnit::int ​

Velocity

10. origUnit::int ​

Acceleration

11. origUnit::int ​

Angle Velocity

12. origUnit::int ​

Angle Acceleration

13. origUnit::int ​

Energy Density

14. origUnit::int ​

Temperature Gradient

15. origUnit::int ​

HeatFlux

16. currUnit::int ​

Force

17. currUnit::int ​

Angle

18. currUnit::int ​

Temperature

19. currUnit::int ​

Moment

20. currUnit::int ​

Energy

21. currUnit::int ​

Power

22. currUnit::int ​

Displacement

23. currUnit::int ​

Stress

24. currUnit::int ​

Velocity

25. currUnit::int ​

Acceleration

26. currUnit::int ​

Angle Velocity

27. currUnit::int ​

Angle Acceleration

28. currUnit::int ​

Energy Density,

29. currUnit::int ​

Temperature Gradient,

30. currUnit::int ​

Heat Flux

Return Code​

Nothing.

Sample Code​

CmdSetPostUnit([0, 0, 1, 3, 2, 2, 2, 2, 1, 1, 0, 0, 1, 1, 1], [0, 1, 1, 3, 2, 2, 2, 2, 1, 1, 0, 0, 1, 1, 1])

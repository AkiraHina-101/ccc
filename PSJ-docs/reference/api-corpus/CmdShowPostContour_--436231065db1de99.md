# CmdShowPostContour()

CmdShowPostContour()

Description​

Display result in contour

Syntax​

CmdShowPostContour(Cursor crPostJob,
    PostResultKey& resKey, PostDataOp& opOut,
    bool hasResult2, PostResultKey resKey2, PostDataOp opOut2,
    bool hasResult3, PostResultKey resKey3, PostDataOp opOut3,
    bool enableMidNode, bool bApplyAll)

Inputs​

1. Cursor​

Cursor of post job.

2. PostResultKey::int​

Analysis type.

3. PostResultKey::int​

Result set 

4. PostResultKey::int​

Time step 

5. PostResultKey::string ​

Name of result

6. PostResultKey::string ​

Name of component

7. PostResultKey::int  ​

Position of result

8. PostDataOp::int  ​

Display at

9. PostDataOp::int  ​

Coordinate

10. PostDataOp::int  ​

1D Data

11. PostDataOp::int  ​

2D Data

12. PostDataOp::int  ​

Conversion

13. PostDataOp::int  ​

Display of connection

14. PostDataOp::int  ​

Complex.

15. PostDataOp::double  ​

Phase angle.

16. PostDataOp::int  ​

Id of coordinate.

17. bool  ​

Whether it uses 2nd result or not.

18. PostResultKey::int​

Analysis type of 2nd result.

19. PostResultKey::int​

Result set of 2nd result.

20. PostResultKey::int​

Time step of 2nd result.

21. PostResultKey::string ​

Name of result of 2nd result.

22. PostResultKey::string ​

Name of component of 2nd result.

23. PostResultKey::int  ​

Position of result of 2nd result.

24. PostDataOp::int  ​

Display of 2nd result.

25. PostDataOp::int  ​

Type of coordinate of 2nd result.

26. PostDataOp::int  ​

1D data of 2nd result.

27. PostDataOp::int  ​

2D data of 2nd result.

28. PostDataOp::int  ​

Conversion of 2nd result.

29. PostDataOp::int  ​

Display of connection of 2nd result.

30. PostDataOp::int  ​

Complex of 2nd result.

31. PostDataOp::double  ​

Phase angle of 2nd result.

32. PostDataOp::int  ​

Id of coordinate of 2nd result.

33. bool​

Whether it uses 3rd result or not.

34. PostResultKey::int​

Analysis type of 3rd result.

35. PostResultKey::int​

Result set of 3rd result.

36. PostResultKey::int​

Time step of 3rd result.

37. PostResultKey::string ​

Name of result of 3rd result.

38. PostResultKey::string ​

Name of component of 3rd result.

39. PostResultKey::int  ​

Position of result of 3rd result.

40. PostDataOp::int  ​

Display of 3rd result.

41. PostDataOp::int  ​

Type of coordinate of 3rd result.

42. PostDataOp::int  ​

1D data of 3rd result.

43. PostDataOp::int  ​

2D data of 3rd result.

44. PostDataOp::int  ​

Conversion of 3rd result.

45. PostDataOp::int  ​

Display of connection of 3rd result.

46. PostDataOp::int  ​

Complex of 3rd result.

47. PostDataOp::double  ​

Phase angle of 3rd result.

48. PostDataOp::int  ​

Id of coordinate of 3rd result.

49. bool  ​

Enables or not MidNode.

50. bool  ​

Enalbes or not for all documents.

Return Code​

Nothing.

Sample Code​

CmdShowPostContour(183:1, {1, 1, 1, Displacement, Translational, 1}, {1, 1, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, {0, 0, 0, , , 0}, {0, 0, 0, 0, 0, 0, 0, 0.000000, 0}, 0, 0)

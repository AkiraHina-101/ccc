# AdvcDynamicExplicitProcess()

AdvcDynamicExplicitProcess()

説明​

ADVCダイナミック明示的プロセスを作成します。

構文​

AdvcDynamicExplicitProcess(string m_strName, int m_iGeomNonlinear, int fixed_or_auto,
    int num_of_inc, double max_time, double max_dt, double min_dt, int load_type, int output_last,
    int output_interval, int restart_last, int restart_interval, double output_time_interval,
    double restart_time_interval, bool m_bConvergence, double cg_tol, double cg_nr_tol,
    double cg_disp_tol, double cg_nr_disp_tol, double cg_disp_limit_tol,
    double cg_total_disp_limit_tol, double newton_tol, double newton_disp_tol,
    double newton_disp_limit_tol, double newton_total_disp_limit_tol, int cgloop_max,
    int newton_max, double ht_nl_loop_tol, int ht_nl_loop_max, bool m_bContact,
    int subdivide_mode, int contactloop_max, int internal_contactloop_max,
    double separation_tol, double relative_separation_tol, double penetration_tol,
    double relative_penetration_tol, int maxchp, int friction_onset, double stick_slip_tol,
    double friction_tol, int estimate_impact_time, bool m_bAutoIncrement, int newton_residue_incr_max,
    int begin_residue_incr_check, int begin_logarithmic_rate_check,
    double cut_back_factor_for_divergence, double cut_back_factor_for_too_slow_convergence,
    double cut_back_factor_for_excessive_distortion, int incr_enlarge_newton_max,
    int incr_enlarge_suppress, double increase_factor_for_static, double increase_factor_for_dynamic,
    double increase_factor_for_creep, double increase_factor_for_rdnlk, double temperature_incr_max,
    int use_temperature_incr_max, double half_step_tol, double stra_tol, double creep_stra_tol,
    double rdnlk_stra_tol, int iLogMessageInterval, int iLinearApproximation, double dBulkViscosityCoef1,
    double dBulkViscosityCoef2, double dMassScalingdt, double dDtScaleFactor, double dPenaltyScaleFactor,
    int iContactSearchInterval, Cursor m_crEdit, list m_LoadNodeList, list m_LoadCaseNodeList,
    list m_LoadNodeContactList, list m_OutputParamList, int m_iRefType, string m_strRefPath,
    list m_ReferenceResultList)

入力​

1. String​

ADVCダイナミック明示的プロセスの名前

2. Int​

Geometry nonlinear[0：指定なし; 1：Total Lagrange; 2：Updated Lagrange]

3. Int​

時間[0：自動; 1：固定]

4. Int​

インクリメント数

5. Double​

最大時間

6. Double​

最大dt

7. Double​

最小dt

8. Int​

負荷タイプ[-1：デフォルト; 0：ステップ; 1：ランプ]

9. Int​

出力最終[-1：デフォルト; 0：いいえ; 1：はい]

10. Int​

出力間隔

11. Int​

リスタート最終[-1：デフォルト; 0：いいえ; 1：はい]

12. Int​

リスタート間隔

13. Double​

出力時間間隔

14. Double​

リスタート時間間隔

15. Bool​

収束パラメータが定義されているかどうか

16. Double​

cg_tol

17. Double​

cg_nr_tol

18. Double​

cg_disp_tol

19. Double​

cg_nr_disp_tol

20. Double​

cg_disp_limit_tol

21. Double​

cg_total_disp_limit_tol

22. Double​

newton_tol

23. Double​

newton_disp_tol

24. Double​

newton_disp_limit_tol

25. Double​

newton_total_disp_limit_tol

26. Int​

cgloop_max

27. Int​

newton_max

28. Double​

ht_nl_loop_tol

29. Int​

ht_nl_loop_max

30. Bool​

接触パラメータが定義されているかどうか

31. Int​

subdivide_mode[-1：デフォルト; 0：いいえ; 1：はい]

32. Int​

contactloop_max

33. Int​

internal_contactloop_max

34. Double​

separation_tol

35. Double​

relative_separation_tol

36. Double​

penetration_tol

37. Double​

relative_penetration_tol

38. Int​

maxchp

39. Int​

friction_onset[0：遅延; 1：即時]

40. Double​

stick_slip_tol

41. Double​

friction_tol

42. Int​

estimate_impact_time[-1:デフォルト; 0：いいえ; 1：はい]

43. Bool​

自動増分パラメータが定義されているかどうか

44. Int​

newton_residue_incr_max

45. Int​

begin_residue_incr_check

46. Int​

begin_logarithmic_rate_check

47. Double​

cut_back_factor_for_divergence

48. Double​

cut_back_factor_for_too_slow_convergence

49. Double​

cut_back_factor_for_excessive_distortion

50. Int​

incr_enlarge_newton_max

51. Int​

incr_enlarge_suppress

52. Double​

increase_factor_for_static

53. Double​

increase_factor_for_dynamic

54. Double​

increase_factor_for_creep

55. Double​

increase_factor_for_rdnlk

56. Double​

temperature_incr_max

57. Int​

use_temperature_incr_max[-1：デフォルト; 0：いいえ; 1：はい]

58. Double​

half_step_tol

59. Double​

stra_tol

60. Double​

creep_stra_tol

61. Double​

rdnlk_stra_tol

62. Int​

ログメッセージインターバル

63. Int​

線形近似[-1：デフォルト; 0：いいえ; 1：はい]

64. Double​

Bulk Viscosity Coef1

65. Double​

Bulk Viscosity Coef2

66. Double​

Mass Scaling dt

67. Double​

Dt Scale Factor

68. Double​

Penalty Scale Factor

69. Int​

Contact Search Interval

70. Cursor​

編集カーソル

71. List​

負荷の状態

72. List​

負荷ケースの状態

73. List​

接触の状態とその他のデータ

74. List​

出力パラメータ

75. Int​

参照結果タイプ[0：温度負荷; 1：応力]

76. String​

参照結果のパス

77. List​

参照結果のデータ

戻り値コード​

"1"：関数を実行できます

"0"：関数を実行できません

サンプルコード​

AdvcDynamicExplicitProcess("テスト",1,1,1,0.001,0.001,0.001,1,1,1,1,1,0.001,0.001,1,
    0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,1,1,0.001,1,1,1,1,
    1,0.001,0.001,0.001,0.001,1,1,0.001,0.001,1,1,1,1,1,0.001,0.001,0.001,1,1,0.001,
    0.001,0.001,0.001,0.001,1,0.001,0.001,0.001,0.001,1,1,0.001,0.001,0.001,0.001,
    0.001,1,1:11,,,,,1,"テスト",)

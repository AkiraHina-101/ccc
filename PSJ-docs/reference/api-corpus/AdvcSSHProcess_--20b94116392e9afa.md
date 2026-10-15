# AdvcSSHProcess()

AdvcSSHProcess()

説明​

熱伝達定常プロセスを作成します

構文​

AdvcSSHProcess(String m_strName,int end_type,double max_time,int fixed_or_auto,
    double max_change,double init_dt,int define_max_dt,double max_dt,
    int define_min_dt,double min_dt,double fixed_dt,int output_last,
    int output_interval,int restart_last,int restart_interval,
    double output_time_interval,double restart_time_interval,int output_init,
    int list_output_interval,BOOL m_bConvergence,double cg_tol,double cg_nr_tol,
    double cg_disp_tol,double cg_nr_disp_tol,double cg_disp_limit_tol,
    double cg_total_disp_limit_tol,double newton_tol,double newton_disp_tol,
    double newton_disp_limit_tol,double newton_total_disp_limit_tol,
    int cgloop_max,int newton_max,double ht_nl_loop_tol,int ht_nl_loop_max,
    cursor m_crEdit,list m_LoadNodeList,list m_LoadCaseNodeList,
    list m_LoadNodeContactList,list m_OutputParamList)

入力​

1. String​

熱伝達定常プロセスの名前

2. Int​

終了タイプ[0:なし; 1:最大時間]

3. Double​

最大時間

4. Int​

固定または自動タイプ[0:自動; 1:固定]

5. Double​

最大変化温度

6. Double​

初期dt時間

7. Int​

最大dtを定義する場合[0:しない; 1:する]

8. Double​

最大dt時間

9. Int​

最小dtを定義する場合[0:しない; 1:する]

10. Double​

最小dt時間

11. Double​

固定dt時間

12. Int​

最後に出力する[-1:デフォルト; 0:しない; 1:する]

13. Int​

出力間隔

14. Int​

最後にリスタートする[-1:デフォルト; 0:しない; 1:する]

15. Int​

リスタート間隔

16. Double​

出力時間間隔

17. Double​

リスタート時間間隔

18. Int​

初期結果を出力する[-1:デフォルト; 0:しない; 1:する]

19. Int​

リスト出力間隔

20. BOOL​

収束パラメータが定義されているか

21. Double​

cg_tol

22. Double​

cg_nr_tol

23. Double​

cg_disp_tol

24. Double​

cg_nr_disp_tol

25. Double​

cg_disp_limit_tol

26. Double​

cg_total_disp_limit_tol

27. Double​

newton_tol

28. Double​

newton_disp_tol

29. Double​

newton_disp_limit_tol

30. Double​

newton_total_disp_limit_tol

31. Int​

cgloop_max

32. Int​

newton_max

33. Double​

ht_nl_loop_tol

34. Int​

ht_nl_loop_max

35. Cursor​

編集カーソル

36. List​

負荷の状態

37. List​

負荷ケースの状態

38. List​

接触の状態と他のデータ

39. List​

出力パラメータ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AdvcSSHProcess("ADVC_DEFAULT_PROCESS", 1, 1, 0, 1.79769e+308, 1.79769e+308, 0, 1, 0,
    1e-05, 1.79769e+308, -1, 2147483647, -1, 2147483647, 1.79769e+308, 1.79769e+308, -1,
    2147483647, 0, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308,
    1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 1.79769e+308, 2147483647,
    2147483647, 1.79769e+308, 2147483647, 128:2, [], [], [], [])

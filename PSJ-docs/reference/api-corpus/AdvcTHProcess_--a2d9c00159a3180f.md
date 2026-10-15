# AdvcTHProcess()

AdvcTHProcess()

説明​

ADVC熱転送一時プロセスを作成します。

構文​

AdvcTHProcess(string m_strName,int end_type,double max_time,double steady_rate,
    int fixed_or_auto,double max_change,double init_dt,int define_max_dt,double max_dt,
    int define_min_dt,double min_dt,double fixed_dt,int output_last,int output_interval,
    int restart_last,int restart_interval,double output_time_interval,
    double restart_time_interval,int output_init,int list_output_interval,
    bool m_bConvergence,double cg_tol,double cg_nr_tol,double cg_disp_tol,
    double cg_nr_disp_tol,double cg_disp_limit_tol,double cg_total_disp_limit_tol,
    double newton_tol,double newton_disp_tol,double newton_disp_limit_tol,
    double newton_total_disp_limit_tol,int cgloop_max,int newton_max,
    double ht_nl_loop_tol,int ht_nl_loop_max,Cursor m_crEdit,list m_LoadNodeList,
    list m_LoadCaseNodeList,list m_LoadNodeContactList,list m_OutputParamList)

入力​

1. String​

ADVC熱転送一時プロセスの名前

2. Int​

終了タイプ[1：最大時間; 2：安定率; 3：両方]

3. Double​

最大時間

4. Double​

安定率

5. Int​

固定または自動タイプ[0：自動; 1：固定]

6. Double​

最大変化温度

7. Double​

初期dt時間

8. Int​

max dtを定義する場合[0：しない; 1：する]

9. Double​

最大dt時間

10. Int​

min dtを定義する場合[0：しない; 1：する]

11. Double​

最小dt時間

12. Double​

固定dt時間

13. Int​

最終出力[-1：デフォルト; 0：いいえ; 1：はい]

14. Int​

出力間隔

15. Int​

再起動最終[-1：デフォルト; 0：いいえ; 1：はい]

16. Int​

再起動間隔

17. Double​

出力時間間隔

18. Double​

再起動時間間隔

19. Int​

初期結果を出力[-1：デフォルト; 0：いいえ; 1：はい]

20. Int​

リスト出力間隔

21. Bool​

収束パラメータが定義されているか

22. Double​

cg_tol

23. Double​

cg_nr_tol

24. Double​

cg_disp_tol

25. Double​

cg_nr_disp_tol

26. Double​

cg_disp_limit_tol

27. Double​

cg_total_disp_limit_tol

28. Double​

newton_tol

29. Double​

newton_disp_tol

30. Double​

newton_disp_limit_tol

31. Double​

newton_total_disp_limit_tol

32. Int​

cgloop_max

33. Int​

newton_max

34. Double​

ht_nl_loop_tol

35. Int​

ht_nl_loop_max

36. Cursor​

編集カーソル

137. List​

負荷の状態

38. List​

負荷ケースの状態

39. List​

接触の状態とその他のデータ

40. List​

出力パラメータ

戻り値​

"1"：機能を実行できます

"0"：機能を実行できません

サンプルコード​

AdvcTHProcess("Test",1,0.001,0.001,1,0.001,0.001,1,0.001,1,0.001,0.001,1,1,1,1,0.001,0.001,
    1,1,1,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,1,1,0.001,1,1:11,,,,)

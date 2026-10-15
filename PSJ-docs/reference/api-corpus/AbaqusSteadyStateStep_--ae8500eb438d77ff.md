# AbaqusSteadyStateStep()

AbaqusSteadyStateStep()

説明​

ABAQUSステディステートステップを作成します。

設定とプロセス指示以外のすべてのパラメーターは、これらの設定間で同じです。

構文​

AbaqusSteadyStateStep(string m_strName, string m_strDesp, int m_bAutomatic, int m_maxInc, double m_initSize, double m_minSize, double m_maxSize, double  m_MaxAllowTChange, int m_EndStepT.bChecked,               std::vector<double> m_EndStepT.TList double m_MaxAllowEmissivityChange, int m_Method, int m_MatrixStorage, int m_SolutionTech,	int m_AllowedIters,	double m_AdjustFactor, int m_MaxContactIter,  
int m_bNlgeom, double m_TimePeriod, int m_ConvertDscntIter,	int m_Ramp,	int m_ExtrapolateMethod, AbaOutputParam[] m_Output)

入力​

1. String​

Abaqus Steady State Stepの名前

2. String​

Abaqus Steady State Stepの説明

3. Int​

Automatic[0:固定; 1:自動;]

4. Int​

最大インクリメント数

5. Double​

初期インクリメントサイズ

6. Double​

最小インクリメントサイズ

7. Double​

最大インクリメントサイズ

8. Double​

最大許容温度変化

9. Int​

End Step Time[0:無効; 1:有効]

10. std::vector<Double>​

End Step Timeリスト

11. Double​

最大許容放射率変化

12. Int​

方程式ソルバーメソッド[0:直接;1:反復]

13. int​

行列ストレージ[0:ソルバーのデフォルト使用;1:非対称;2:対称]

14. Int​

ソリューションテクノロジー[0:完全ニュートン; 1:準ニュートン;2:接触反復]

15. Int​

カーネル行列が再形成される前に許可される反復回数

16. Double​

調整係数

17. Int​

最大接触反復数

18. Int​

Nlgem[0:無効; 1:有効]

19. Double​

時間間隔

20. Int​

重大な不連続性の反復を変換

21. Int​

斜面[0:瞬時; 1:ステップごとに線形に斜面]

22. Int​

ExtrapolateMethod[0:なし; 1:線形; 2:放物線]

23. AbaOutputParam[]​

出力設定

30. Cursor​

編集時にAbaqusSteadyStateStepを指示します。

戻り値コード​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

JPT.Exec('AbaqusSteadyStateStep("Step1", "", 1, 100, 1, 1e-05, 1, 1.79769e+308, 0, [], 0.1, 0, 0, 0, 8, 1, 30, 0, 1, 0, 1, 0, [], 0:0)')

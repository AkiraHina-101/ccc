# AdvcRandomProcess()

AdvcRandomProcess()

説明​

ADVCランダム応答プロセスを作成します。

構文​

AdvcRandomProcess(string m_strName,string strRefEigenDir,double dRefLowFreq,
    double  dRefHighFreq,cursor crModalDampingRatio,cursor crExcitationFreq,
    Bool bAutoFreqInterval,double dMaxFreq,double dMinFreq,int iNumFreqPoint,
    double  dBiasParam,int iPropMethod,int iPSDtype,int iPSDdir,cursor crPSDLoad,
    double  dPSDFactor,double dGravityAccel,int iOutputEigenFreqStep,
    cursor m_crEdit,list m_LoadNodeList,list m_LoadCaseNodeList,
    list m_LoadNodeContactList,list m_OutputParamList,int m_iRefType,
    string m_strRefPath,list m_ReferenceResultList)

入力​

1. String​

ADVCランダム応答プロセスの名前

2. String​

結果ファイルのパス

3. Double​

参照低周波数

4. Double​

参照高周波数

5. Cursor​

モーダル減衰比

6. Cursor​

励起周波数

7. Bool​

自動周波数間隔

8. Double​

最大周波数

9. Double​

最小周波数

10. Int​

周波数点の数

11. Double​

バイアスパラメータ

12. Int​

MultiPointExcitation_Correlation[0:無相関; 1:相関]

13. Int​

PSDタイプ[0:変位; 1:速度; 2:加速度]

14. Int​

PSD方向[0:X軸; 1:Y軸; 2:Z軸; 3:RX軸; 4:RY軸; 5:RZ軸]

15. Cursor​

PSD負荷

16. Double​

PSD振幅スケールファクター

17. Double​

重力加速度

18. Int​

出力周波数ステップ[-1:デフォルト; 0:いいえ; 1:はい]

19. Cursor​

編集カーソル

20. リスト​

負荷の状態

21. リスト​

負荷ケースの状態

22. リスト​

接触状態およびその他のデータ

23. リスト​

出力パラメータ

24. Int​

参照結果タイプ[0:温度負荷; 1:応力]

1. String​

参照結果のパス

25. リスト​

参照結果のデータ

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

AdvcRandomProcess("テスト",,0.001,0.001,1:11,1:11,1,0.001,0.001,1,0.001,
    1,1,1,1:11,0.001,0.001,1,1:11,,,,,1,"テスト",)

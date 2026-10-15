# AdvcModalFreqRespProcess()

AdvcModalFreqRespProcess()

説明​

ADVCモーダル周波数応答プロセスを作成します。

構文​

AdvcModalFreqRespProcess(string m_strName,string strRefEigenDir,double dRefLowFreq,
    double dRefHighFreq,Cursor crModalDampingRatio,Cursor crExcitationFreq,
    bool bAutoFreqInterval,double dMaxFreq,double dMinFreq,int iNumFreqPoint,
    double dBiasParam,Cursor m_crEdit,list m_LoadNodeList,list m_LoadCaseNodeList,
    list m_LoadNodeContactList,list m_OutputParamList,int m_iRefType,string m_strRefPath,
    list m_ReferenceResultList)

入力​

1. String​

ADVCモーダル周波数応答プロセスの名前

2. string​

結果ファイルのパス

3. Double​

参照低周波数

4. Double​

参照高周波数

5. Cursor​

モーダル減衰比

6. Cursor​

励振周波数

7. Bool​

自動周波数間隔

8. Double​

最大周波数

9. Double​

最小周波数

10 Int​

周波数ポイントの数

11. Double​

バイアスパラメータ

12. Cursor​

編集カーソル

13. List​

負荷の状態

14. List​

負荷ケースの状態

15. List​

接触の状態およびその他のデータ

16. List​

出力パラメータ

17 Int​

参照結果の種類[0：温度負荷；1：応力]

18. String​

参照結果のパス

19. List​

参照結果のデータ

戻り値​

"1"：関数は実行可能です

"0"：関数は実行できません

サンプルコード​

AdvcModalFreqRespProcess("Test",,0.001,0.001,1:11,1:11,1,0.001,0.001,1,0.001,1:11,,,,,1,"Test",)

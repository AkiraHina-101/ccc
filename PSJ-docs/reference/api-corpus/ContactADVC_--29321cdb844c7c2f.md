# ContactADVC()

ContactADVC()

説明​

advcに連絡先を作成します

構文​

ContactADVC(String m_strName,int m_iType,int slidingType,int InitialState,
    double initialStateTol,double kineticFrictionCoef,double exponentialCoef,
    int Behavior,double Clearance,int adjust2Clearance,double interference,
    int adjust2Interference,int autoShrink,int badvAdjust,double adjustValue,
    double FrictionCoef,double MaxShear,double elastic_slip,double slip_tolerance,
    double searchWidth,double SearchGap,double searchDepth,double critialPenetration,
    int estimation_impact_time,int formula,int constraintType,int iDataType,
    int m_TypeId,bool m_btemperatureDependency,int m_idependencies,TSheetd m_table,
    int stabilized,int type,double residual_factor,double effective_dist,double cn,
    double ct,Cursor[] m_taCClearance,Cursor[] m_taTarget,Cursor m_crEdit,
    double searchAngle,int constraintType_explicit,double penaltyFact,
    double penaltyFactExplicit,int m_Color,int m_iAlg,int m_iMethod)

入力​

1. String​

連絡先の名前

2. Int​

連絡先タイプ[0:一般; 1:結合]

3. Int​

有限スライディング[0:なし; 1:あり]

4. Int​

初期状態[0:空白; 1:自動; 2:開いている; 3:閉じている]

5. Double​

初期状態許容差

6. Double​

動摩擦係数

7. Double​

指数係数

8. Int​

挙動[0:空白; 1:分離; 2:分離なし]

9. Double​

クリアランス

10. Int​

クリアランスに合わせる[0:空白; 1:はい; 2:いいえ]

11. Double​

干渉

12. Int​

干渉に合わせる[0:空白; 1:はい; 2:いいえ]

13. Int​

自動縮小[0:空白; 1:はい; 2:いいえ]

14. Int​

調整[0:空白; 1:はい; 2:値]

15. Double​

調整値

16. Double​

摩擦係数

17. Double​

最大せん断応力値

18. Double​

弾性ずり

19. Double​

ずり許容差

20. Double​

検索幅

21. Double​

検索ギャップ

22. Double​

検索深度

23. Double​

致命的侵入

24. Int​

衝突時推定時間[0:空白; 1:はい; 2:いいえ]

25. Int​

形成[0:空白; 1:節点からセグメント; 2:セグメントからセグメント]

26. Int​

拘束タイプ[0:空白; 1:ラグランジュ; 2:ペナルティ]

27. Int​

熱伝導タイプ[0:空白; 1:クリアランス依存]

28. Int​

タイプ[0:クリアランス依存; 1:圧力依存]

29. Bool​

温度依存データを使用する場合

30. Int​

フィールド変数の数

31. TSheetd​

クリアランス依存のテーブル

32. Int​

安定化パラメータが定義されているか[0:未定義; 1:定義済み]

33. Int​

タイプ[0:空白; 1:剛性; 2:面積]

34. Double​

残留ファクター

35. Double​

効果的距離

36. Double​

法線ファクターcn

37. Double​

法線ファクターct

38. Cursor[]​

クリアランスリスト

39. Cursor[]​

ターゲット

40. Cursor​

編集カーソル

41. Double​

検索角度値

42. Int​

明示タイプの拘束[0:空白; 1:運動学; 2:ペナルティ]

43. Double​

ペナルティスケールファクター

44. Double​

明示用のペナルティスケールファクター

45. Int​

連絡先の色

46. Int​

アルゴリズム[0:面対面]

47. Int​

メソッドタイプ[0:MANUAL_FACE; 1:MANUAL_GROUP; 2:BY_GROUP_MATRIX; 3:SHARE_FACE; 4:AUTO_SETTING; 5:METHOD_UNKNOWN]

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ContactADVC("テスト",1,1,1,0.001,0.001,0.001,1,0.001,1,0.001,1,1,1,0.001,0.001,
    0.001,0.001,0.001,0.001,0.001,0.001,0.001,1,1,1,1,1,1,1,,1,1,0.001,0.001,
    0.001,0.001,[1:11,2:12],[1:11,2:12],1:11,,1,0.001,0.001,1,1,1)

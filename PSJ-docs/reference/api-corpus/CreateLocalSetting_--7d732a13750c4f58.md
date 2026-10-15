# CreateLocalSetting()

CreateLocalSetting()

説明​

ローカル設定の作成

構文​

CreateLocalSetting(string name, MeshLocalParam param, cursor[] target, int[] hard_point_id,
    point[] hard_Point_xyz, cursor[] hard_point_target, cursor edit_target)

入力​

1. String​

節点リスト

2. MeshLocalParam::整数​

エンティティタイプ 0=なし,1= パート,2=フェース,3=エッジ,8=フェースポイント,9=エッジポイント

3. MeshLocalParam::ブール​

サイズパラメータを有効にする 0=しない, 1=する

4. MeshLocalParam::倍精度​

平均要素サイズ

5. MeshLocalParam::倍精度​

最大要素サイズ

6. MeshLocalParam::倍精度​

最小要素サイズ

7. MeshLocalParam::ブール​

トリム角を有効にする 0=しない, 1=する

8. MeshLocalParam::倍精度​

トリム角

9. MeshLocalParam::ブール​

メッシュ数を有効にする 0=しない, 1=する

10. MeshLocalParam::整数​

節点数

11. MeshLocalParam::整数​

バイアス節点ID

12. MeshLocalParam::倍精度​

バイアスファクター

13. MeshLocalParam::整数​

バイアスメソッド 0=線形, 1=バイアス, 2=バイアス中心, 3=バイアス側

14. MeshLocalParam::整数​

バイアス進行 0=幾何学, 1=等差数列

15. MeshLocalParam::ブール​

メッシュパターンを有効にする 0=しない, 1=する

16. MeshLocalParam::整数​

メッシュパターンの種類 0=非構造化, 1=構造化等値線, 2=印刷等値線

17. MeshLocalParam::ブール​

エンティティを保持するを有効にする 0=しない, 1=する

18. MeshLocalParam::倍精度​

ハードポイントX

19. MeshLocalParam::倍精度​

ハードポイントY

20. MeshLocalParam::倍精度​

ハードポイントZ

21. MeshLocalParam::整数​

ハードポイントID

22. MeshLocalParam::ブール​

メッシュをフリーズするを有効にする 0=しない, 1=する

23. Cursor[]​

ターゲットリスト（ パート/フェース/エッジ）

24. Int[]​

ハードポイントIDリスト

25. Point[]​

ハードポイントXYZリスト

26. Cursor[]​

ハードポイントターゲットリスト

27. Cursor​

編集ターゲット

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

CreateLocalSetting("MeshParam_1", {2, 1, 0.005, 0.01, 0.001, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0}, [6:8], [], [], [], 0:0)

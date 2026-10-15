# VolMeshing()

VolMeshing()

説明​

固体メッシュ化

構文​

VolMeshing(cursor[] body, volMeshParam param, bool use_mesh_color, color color)

入力​

1. Cursor[]​

パートリスト

2. VolMeshParam::bool​

Tet10 0=No、1=Yes

3. VolMeshParam::double​

グレーディング係数

4. VolMeshParam::bool​

重心 0=No、1=Yes

5. VolMeshParam::double​

ストレッチ限界

6. VolMeshParam::int​

品質 0=最速、1=標準、2=最適化

7. VolMeshParam::int​

メモリ 0=標準、1=低メモリ

8. VolMeshParam::int​

領域 0=全領域、1=主要領域

9. VolMeshParam::bool​

内部節点 0=No、1=Yes

10. VolMeshParam::bool​

セーフモード 0=No、1=Yes

11. VolMeshParam::int​

並列数

12. VolMeshParam::bool​

表面節点 0=No、1=Yes

13. VolMeshParam::bool​

エッジ節点 0=No、1=Yes

14. VolMeshParam::bool​

保存 0=No、1=Yes

15. VolMeshParam::bool​

内部メッシュのみ 0=No、1=Yes

16. Bool​

メッシュカラーの使用 0=No、1=Yes

17. Color​

メッシュカラー

戻り値​

"1": 関数を実行できる

"0": 関数を実行できない

サンプルコード​

VolMeshing([3:1], {1, 1.05, 0, 0.1, 1, 0, 1, 1, 0, 4, 1, 1, 1, 0}, 0, 65280)

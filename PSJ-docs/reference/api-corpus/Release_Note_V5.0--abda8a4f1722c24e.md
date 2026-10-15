# Release Note V5.0

Release Note V5.0

ハイライトの更新

このリリースでは、PSJ-Command と新しい PSJ ウェブドキュメントが導入されました。さらに以下が追加されました：

Pythonコアとその依存関係をバージョン3.6.3から3.9.0にアップグレード

PSJに慣れるためのチュートリアルを追加

新しいPSJ-Utilityコマンド（API）を追加

GUIコマンドビルダー、カスタマイズされたシェル、カスタマイズされたIDEの新機能を追加

PSJのカスタムダイアログを使用中にクラッシュする問題を修正

🚀 新機能​

⌘ PSJ-Command​

現在のマクロをPSJ-Command で置き換え、スクリプトAPIマニュアル を導入します。

🛠 PSJ-Utility​

📝 API​

データベースクエリ、キャスティング、選択に関連するAPIコマンドが追加されました：

新しく追加されたコマンドのリスト

JPT.BeginDatabaseTransaction ：Jupiterのパフォーマンスを向上させるために、画面アニメーション、画面更新、ステータスバー更新情報を無効にします。

JPT.CastDItemToDConnect ：DItemオブジェクトをDConnectオブジェクトに変換して、選択された座標系の情報を取得します。

JPT.CastDItemToDCoord ：DItemオブジェクトをDCoordオブジェクトに変換して、選択された座標系の情報を取得します。

JPT.CastDItemToDLoadBC ：DItemオブジェクトをDLoadBCオブジェクトに変換して、選択された座標系の情報を取得します。

JPT.ClearAllSelection ：選択されたすべてのエンティティをクリアします。

JPT.CollapseAssemblyTree ：アセンブリウィンドウに存在するすべてのアイテムを折り畳みます。

JPT.DisableOutputMessage ：Python APIウィンドウに書き込まれるすべての出力メッセージを無効にします。

JPT.DisableScreenAnimation ：画面アニメーション効果を無効にします。

JPT.EnableLicenseFeature ：現在のJupiterに存在するライセンス機能を有効にします/無効にします。

JPT.EnableOutputMessage ：Python APIウィンドウに書き込まれる出力メッセージを有効にします。

JPT.EnableScreenAnimation ：画面アニメーション効果を有効にします。

JPT.EndDatabaseTransaction ：JPT.BeginDatabaseTransaction() を使用した後、データトランザクションを再度有効にします。

JPT.ExpandAssemblyTree ：アセンブリウィンドウに存在するすべてのアイテムを展開します。

JPT.GetAllConnections ：すべての既存の接続の情報を取得します。

JPT.GetAllCoordinates ：作成されたすべての座標系の情報を取得します。

JPT.GetAllLoadBoundaryConditions ：既存のすべての荷重と境界条件の情報を取得します。

JPT.GetAvailableResultOption ：入力された結果タイプのすべての利用可能な結果オプションを取得します。

JPT.GetDefaultResultOption ：入力された結果タイプのすべてのデフォルト結果オプションを取得します。

JPT.GetElemsByType ：タイプ（Tri3、Hex8、Tet10など）を入力して要素のリストを取得します。

JPT.GetGroupFromSubGroup ：指定したグループ名の下にあるグループのリストを取得します。

JPT.GetMaterialFromProperty ：入力されたプロパティIDから使用されている材料情報（名前、IDなど）を取得します。

JPT.GetMaxResultCoord ：プロット結果の最大値を持つ要素の節点/中心節点の座標を取得します。

JPT.GetMaxResultId ：タイプによってすべての既存のエンティティを選択します。

JPT.GetMaxResultValue ：現在のプロット結果の最大値を取得します。

JPT.GetMinResultCoord ：プロット結果の最小値を持つ要素の節点/中心節点の座標を取得します。

JPT.GetMinResultId ：プロット結果の最小値を持つ節点/要素のIDを取得します。

JPT.GetMinResultValue ：現在のプロット結果の最小値を取得します。

JPT.GetResultComponentNames ：入力された結果タイプと方向に存在するすべての利用可能なデータ位置を取得します。

JPT.GetResultIncrements ：入力された結果ステップのすべての既存のインクリメントを取得します。

JPT.GetResultLocations ：入力された結果タイプと方向に存在するすべての利用可能なデータ位置を取得します。

JPT.GetResultNames ：モデルに存在するすべての利用可能な結果タイプを取得します。

JPT.GetResultSteps ：現在の結果のすべての結果タイプとタイムステップを取得します。

JPT.GetResultTimeStepInfo ：入力された結果ステップとそのタイムステップに関連する情報を取得します。

JPT.GetResultUseIncrement ：入力された結果ステップのすべての既存のインクリメントを取得します。

JPT.GetThicknessOfEntity ：入力されたエンティティIDの厚みを取得します（Part/Face/Elementのみ使用可能）。

JPT.MessageBoxPSJ ：Jupiterダイアログ（情報、警告）を表示します。

JPT.SelectionByID ：IDを使用してエンティティを選択します。

JPT.SelectionByType ：入力されたタイプのすべての既存のエンティティを選択します。

JPT.SetSelectMethod ：Jupiterの選択方法を指定されたものに変更します。

JPT.UpdateCheckboxWatchSelected ：Watch Selectedウィンドウのチェックボックスの状態を指定したエンティティのIDとタイプで変更します。

📐 PSJ-GUI​

📏 GUIコマンドビルダー​

テーブル内でTabキーをサポートして、次のセルに移動できるようにします。

"Save dialog to customer folder" ダイアログにグループ名を追加して、カスタマイズされたリボン内でグループを作成します。

📟 カスタマイズされたシェル​

Python APIウィンドウでエラーライン/警告ラインをダブルクリックすると、特定の行に移動します。

右クリックメニューに "Copy As Python Execution" オプションを追加して、マクロをPSJスクリプトとしてコピーし、IDEに貼り付けます。

🗒 カスタマイズされたIDE​

IDEでコードを編集する際にスペース（タブ）を自動挿入します。

最初の文字を入力した後にPSJオートコンプリートの提案を追加します。

"Find" と "Find And Replace" ダイアログの選択された単語に対して初期検索値を追加します。

編集メニュー に "Convert To Upper Case", "Convert To Lower Case", "Insert Tab", "Duplicate Selection/Line" のオプションを追加します。

入力ファイルをIDEにドラッグアンドドロップしてサポートします。

ショートカットキーをサポートします。

📦 追加機能​

Pythonコアとその依存関係をバージョン3.6.3から3.9.0にアップグレードしました。

Python-pptx と Numba ライブラリを追加しました。

PSJ用の Visual Studio Code拡張機能 を追加しました（ベータ版）。

🐛 バグ修正​

📐 PSJ-GUI​

JPT-GUIとJupiterの関数を同時に実行するとJupiterがクラッシュします。

「ファイルを開く/フォルダを開く」コンポーネントの文字数に制限があります。

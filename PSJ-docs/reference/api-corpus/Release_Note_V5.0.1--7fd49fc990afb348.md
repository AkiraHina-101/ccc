# Release Note V5.0.1

Release Note V5.0.1

主なアップデート内容

本リリースは主に新しいPSJ-GUIとPSJ-Utility機能に焦点を当てています。詳細：

PSJ-GUIコマンド（API）とGUIコマンドビルダーの使いやすさを向上。

新しいPSJ-Utilityコマンド（API）を追加、特にプレビューとポストユーティリティ。

PSJ-Command、PSJ-Utility、PSJ-GUI用の新しいデータ型を追加。

PSJコマンドで使用される引数名を修正。

PSJ-GUI、GUIコマンドビルダーのクラッシュ問題と軽微なバグを修正。

🚀 新機能​

📦 データ型​

PSJ-Command: EntityTypeは_DItemTypeに統合され、JupiterでDItemの型を表す公式タイプになりました。
新しいDItemType_のタイプも追加されました。

新しく追加されたDItemTypeのリスト

 | INT 記法 | DItemの型

 | 8 | JPT.DItemType.SHAPELINK

 | 9 | JPT.DItemType.BODYLINK

 | 17 | JPT.DItemType.REF_SHAPELINK

 | 18 | JPT.DItemType.REF_BODYLINK

 | 48 | JPT.DItemType.LBC_TEMP_LOAD

 | 59 | JPT.DItemType.LBC_DYNAMIC_INITIAL_CONDITION

 | 62 | JPT.DItemType.LBC_MAPPING_FORCE

 | 63 | JPT.DItemType.LBC_MAPPING_TEMP_LOAD

 | 174 | JPT.DItemType.LBC_MAPPING_TEMP_INIT

 | 66 | JPT.DItemType.LBC_INITSTRESS_GENERAL

 | 77 | JPT.DItemType.LBC_WELD

 | 92 | JPT.DItemType.PROPERTY_3D_WELDBEAD

 | 95 | JPT.DItemType.SECTION_SKETCHER

 | 100 | JPT.DItemType.CONNECT_PROD

 | 104 | JPT.DItemType.CONNECT_MOMENT

 | 105 | JPT.DItemType.CONNECT_WELD

 | 113 | JPT.DItemType.CONTACT

 | 114 | JPT.DItemType.CUSTOM_ATTR_STRING

 | 115 | JPT.DItemType.CUSTOM_ATTR_VECTOR

 | 116 | JPT.DItemType.CUSTOM_ATTR_DOUBLE

 | 128 | JPT.DItemType.ADVCPROCESS_SSH

 | 129 | JPT.DItemType.ADVCPROCESS_TH

 | 149 | JPT.DItemType.WELDORDER

 | 150 | JPT.DItemType.ATTRIBUTE_FXWELD

 | 154 | JPT.DItemType.ATTRIBUTE_PS_BLENDSURFACE

 | 160 | JPT.DItemType.LBC_PRETENSION_NXN

 | 161 | JPT.DItemType.LBC_MAPPING_TEMP_MARINE_ENGINE

 | 162 | JPT.DItemType.USER_PROP

 | 165 | JPT.DItemType.LBC_MAPPING_FORCEDDISPLACEMENT

 | 166 | JPT.DItemType.LBC_MAPPING_FORCED_TEMP

 | 167 | JPT.DItemType.NASTRAN_POSTJOB

 | 168 | JPT.DItemType.ADVC2_POSTJOB

 | 183 | JPT.DItemType.TSV_POSTJOB

 | 184 | JPT.DItemType.MARCJOB

 | 173 | JPT.DItemType.PERMASJOB

 | 180 | JPT.DItemType.FRONTISTRJOB

 | 192 | JPT.DItemType.POST_NODE

 | 193 | JPT.DItemType.POST_ELEM

 | 232 | JPT.DItemType.OPTISHAPE_TS_JOB

また、新しく_ElemKindとElemType_のタイプも追加されました：

新しく追加されたElemKindとElemTypeのリスト

 | ElemKind Int記法 | 要素の種類 | ElemType Int記法 | 要素のタイプ

 | 3 | ELEMKIND_2D | 17 | ELEMTYPE_QUAD6

 |  |  | 18 | ELEMTYPE_QUAD9

 | 4 | ELEMKIND_3D | 19 | ELEMTYPE_PRISM12

 |  |  | 20 | ELEMTYPE_HEX18

 | 5 | ELEMKIND_SP | 16 | ELEMTYPE_PLOT

 |  |  | 21 | ELEMTYPE_RBE

 |  |  | 22 | ELEMTYPE_MASS

 |  |  | 23 | ELEMTYPE_VIRTUAL

PSJ-Utility: プリユーティリティとポストユーティリティの2つのタイプに分離されました：

プリユーティリティ: 前処理ワークフローで使用されるデータ型で、新しいクラスとアップデートを含みます：

組み込み型: 新しい_DItemPair、DItemPairVector、DCoord、CoordVector、DConnect、ConnectVector、DLoadBC、LoadBCVector、DSolverJob、SolverJobVector、Documentを追加。
さらに、DBody_に新しい属性propertiesが追加されました。

列挙型: _パス型の新しいタイプJPT.PathType.FILE_PATHを追加。
また、新しいDTableType_のタイプが追加されました：

新しく追加されたDTableTypeのリスト

 | ID | Dtableタイプ

 | 58 | JPT.DTableType.DTABLE_SUP_GROUP

 | 60 | JPT.DTableType.DTABLE_ELEMEDGE_GROUP

 | 62 | JPT.DTableType.DTABLE_SECTION

 | 65 | JPT.DTableType.DTABLE_CUSTOM_ATTRIBUTE

 | 79 | JPT.DTableType.DTABLE_LBC_DOFSET

 | 86 | JPT.DTableType.DTABLE_POSTJOB

 | 87 | JPT.DTableType.DTABLE_USER_RESULT

新しい_UnitType_も追加されました：

新しく追加されたUnitTypeのリスト

 | ID | 単位タイプ | 文字列単位

 | 28 | JPT.UnitType.Unit_LinearDensity | kg/moz/ftoz/inlb/ydkg/m\\oz/ft\\oz/in\\lb/ydkg/moz/ftoz/inlb/yd

 | 29 | JPT.UnitType.Unit_SurfaceDensity | 

 | 30 | JPT.UnitType.Unit_AreaMomentInertia | mm4m4ft4in4cm4mm^4\\m^4\\ft^4\\in^4\\cm^4mm4m4ft4in4cm4

 | 37 | JPT.UnitType.Unit_StrainEnergy | N−mmN−mN-mm\\N-mN−mmN−m

 | 41 | JPT.UnitType.Unit_ElectricalResistivity | Ohm−mmOhm−mOhm-mm\\Ohm-mOhm−mmOhm−m

ポストユーティリティ: 後処理ワークフローで使用されるデータ型で、全く新しいクラスが追加されました：

組み込み型: DPostElem、DPostNode、ポストデータオプション、ポストタイムステップ情報。

列挙型: ポスト解析タイプ、ポストデータ範囲タイプ、ポスト結果データ位置タイプ、ポスト結果データ変換タイプ、ポスト結果データ連続タイプ、ポスト結果データ座標タイプ、ポスト結果データ荷重1Dタイプ、ポスト結果データ荷重2Dタイプ、ポスト結果データ複素数タイプ。

PSJ-GUI: テーブル操作用の新しいクラスを追加：TableCellID、TableCellVector、TableCellRange、TableCellRangeVector、TableColumnInfo、TableColumnInfoVector。

⌘ PSJ-Command​

PSJ-Commandのキーワード引数名を変更し、使用時の可読性を確保し、科学用語の側面を統一しました。

変更されたコマンドのリスト

 | PSJ-Command | 旧 | 新

 | Analysis.AbaqusStep.CoupledTDStep | dDampingfactor | dDampingFactor

 | Analysis.AbaqusStep.DynamicStep | iNlgeom | iNlGeom

 | Analysis.AbaqusStep.SteadyStateStep | iNlgeom | iNlGeom

 | BoundaryConditions.Pressure.General | iArrowdir | iArrowDir

 | Connections.MPC.Equation.SemiAuto | listMPCConnection | listMpcConnection

🛠 PSJ-Utility​

📝 API​

データベースクエリ、プレビュー、後処理に関連する29の新しいAPIコマンドが追加されました：

新しく追加されたコマンドのリスト

JPT.GetAllCoordinates(): 作成されたすべての座標系の情報を取得。

JPT.GetAssemblyEntityData() : アセンブリツリーから特定のアイテムのすべての情報を取得。

JPT.GetSelectedElemEdges() : 選択された要素エッジのすべての情報を取得。

JPT.GetSuppressedParts() : すべての抑制されたパーツのすべての情報を取得。

JPT.GetPostElemFromPosition() : 特定の位置からポスト要素を取得。

JPT.GetAllAvailableResultOptions() : 入力された結果タイプの利用可能なすべての結果オプションを取得。

JPT.GetActiveDataOption() : 作業中の結果のアクティブなポストデータオプションを取得。

JPT.GetResultByNodeId() : IDで指定されたノードの結果値を取得。

JPT.GetResultByElemId() : IDで指定された要素の結果値を取得。

JPT.GetElementResult() : 条件を満たす結果がロードされた要素を取得。

JPT.GetNodeResult() : 条件を満たす結果がロードされたノードを取得。

JPT.GetResultSetName() : 結果セット（サブケース）の名前を取得。

JPT.GetTimeStepInfoName() : タイムステップ情報の名前を取得。

JPT.GetActivePostJob() : アクティブなポストジョブの情報を取得。

JPT.PostHasDeform() : 作業中の結果に変形があるかどうかを確認。

JPT.SelectionByID() : IDを使用してエンティティを選択。

JPT.ClearPreview() : メイン画面のプレビューレンダリングをクリア。

JPT.HidePreview() : メイン画面のプレビューレンダリングを非表示。プレビューは存在しているが、非表示になります。

JPT.ShowPreview() : メイン画面のプレビューレンダリングを表示。

JPT.PreviewTranslation() : ボディ移動の結果プレビューを表示。

JPT.PreviewScaling() : ボディスケーリングの結果プレビューを表示。

JPT.PreviewRotate() : ボディ回転の結果プレビューを表示。

JPT.PreviewMirror() : ボディミラーの結果プレビューを表示。

JPT.PreviewBCForceGeneral() : ターゲットに一般的な力を適用する結果プレビューを表示。

JPT.PreviewBCForceNormal() : ターゲットに法線力を適用する結果プレビューを表示。

JPT.PreviewBCPressureGeneral() : ターゲットに一般的な圧力を適用する結果プレビューを表示。

JPT.UpdateCheckboxAssembly() : アセンブリツリーのアイテムのチェックボックスの状態を設定。

JPT.GetAllSolverJobs() : ソルバージョブのすべての情報（ジョブ名、ステップ、ジョブ説明）を取得。

JPT.MacroTCursorPairToDItemPair() : カーソルペア（マクロ文字列タイプ）をDItemオブジェクトのペアに変換。

📐 PSJ-GUI​

📏 GUIコマンドビルダー​

階層ツールバーに展開/折りたたみ機能を追加。

すべてのツリーノードを展開：選択されたコンテナ内のすべてのコンポーネントを展開。

すべてのツリーノードを折りたたみ：選択されたコンテナ内のすべてのコンポーネントを折りたたみ。

ツールバーメニューに名前を付けて保存ボタンを追加。

*.jdbを開いたときの左上角にファイル名を追加し、データ保存時の作業動作（データが変更された場合、*.jdbの名前にアスタリスク*が追加されます）。

階層ウィンドウでのドラッグ&ドロップ操作をサポート。これにより、コンポーネントの異なる場所への移動がより速く簡単になります。

左下角にステータスバーを追加：GUIコマンドビルダー使用時にメッセージを表示。

ダイアログに「モーダルモード」と「アイコン  ファイル」を追加。

2つのヘッダー間の境界をダブルクリックした後、テーブルの列幅を自動調整。

DoubleまたはInteger型のセルの値がゼロの場合、テーブルセルは空白として表示されます。

コンポーネント名の変更：TabWnd、Browser、PagesCtrl。

チェックラベルありを使用するGroupBoxコンテナ内の他のコンポーネント/コンテナの有効オプションは自動的に無効化され、グレーアウトされます。その時、それらの有効制御は親GroupBoxに依存します。

📝 API​

TabWnd、PagesCtrl、Browser、PagesCtrlなど、GUIコマンドビルダーで説明されているように、一部のAPIの名前が変更されました。

GUIコンポーネント内の値を取得するために、コンポーネント名を入力引数として渡す代わりにAPIを使用します。例：

現在

以前

def on_execute_button_clicked(dlg):
  argument1=dlg.get_item_text(name="...")
  argument2=dlg.get_combox_sel(name="...")
  argument3=dlg.get_listbox_sel(name="...")
  argument4=dlg.get_combobox_option(name="...",index=1)
  #以下実行関数

def on_execute_button_clicked(dlg,argument1,argument2,argument3,argument4):
  #以下実行関数

一部のコマンドの引数名は統一のために変更されました。

引数名変更のリスト

 | コンポーネントグループ | 旧引数名 | 新引数名 | 新引数名の例

 | TABITEM | tabwnd_name | name | dlg.add_tabwnd_page(name="TabWnd1",…)

 | COMBOBOX | combobox_name | name | dlg.add_combobox_option(name="ComboBox2",…)

 | LISTBOX | listbox_name | name | dlg.add_listbox_option(name="ListBox3",…)

 | TABLE | table_name | name | dlg.get_cell_value(name="Table4",…)

 | PAGEITEM | pagesctrl_name | name | dlg.add_pageitem(name="PagesCtrl5",…)

また、以下のコマンドが追加・変更されました：

新しく追加されたコマンドのリスト

JDGCreator(): Jupiterでダイアログを生成するためのクラス。

dlg.on_dlg_apply(): 適用ボタンがクリックされたときに作成した関数を実行。

dlg.on_dlg_cancel(): キャンセルボタンがクリックされたときに作成した関数を実行。

dlg.on_dlg_ok(): OKボタンがクリックされたときに作成した関数を実行。

dlg.on_dlg_help(): ヘルプボタンがクリックされたときに作成した関数を実行。

dlg.do_modal(): 作成したダイアログをモーダルモードで実行（作成したすべての関数とともにダイアログを表示）。

dlg.close(): ダイアログを閉じる。

dlg.set_icon_file(): 作成するGUIダイアログにアイコンを設定。

dlg.show_tooltip(): ユーザーがUIコンポーネントにマウスをホバーしたときにツールチップを表示。

dlg.show_dlg_help_button(): 作成するダイアログでヘルプボタンの表示/非表示を設定。

dlg.on_combobox_sel(): コンボボックスアイテムが選択された後に作成した関数を実行。

dlg.on_button_clicked(): ボタン/ラジオボタン/チェックボックスに作成した関数をバインド。

dlg.on_browse(): ファイル/フォルダブラウザコンポーネントに作成した関数をバインド。

dlg.add_table_right_menu(): テーブルのコンテキストメニュー（右クリックイベント）にオプションを追加。

dlg.enable_table_column_filter(): テーブルの列のフィルタオプションを追加。

dlg.get_cell_value(): 特定のセルの値を取得。

dlg.get_table_column_width(): テーブルの指定された列の幅を取得。

dlg.get_table_sel_cell(): 選択されたセルの情報と属性を取得。

dlg.get_table_sel_range(): 選択されたセル範囲の情報と属性を取得。

dlg.insert_table_rows(): テーブルの特定の位置に行を挿入。

dlg.insert_table_columns(): テーブルの特定の位置に列を挿入。

dlg.delete_table_row(): テーブルの特定の位置の行を削除。

dlg.delete_table_column(): テーブルの特定の位置の列を削除。

dlg.is_table_cell_button(): 入力されたセルがボタンセルかどうかを確認。

dlg.is_table_cell_checkbox(): 入力されたセルがチェックボックスセルかどうかを確認。

dlg.is_table_cell_combobox(): 入力されたセルがコンボボックスセルかどうかを確認。

dlg.is_table_cell_checked(): チェックボックスセルの状態を確認。

dlg.on_table_right_menu(): コンテキストメニューを開く/実行するときのイベントを設定。

dlg.on_table_sel_changed(): セルを選択するときのイベントを設定。

dlg.on_table_button_clicked(): ボタンセルを選択するときのイベントを設定。

dlg.set_cell_value(): 特定のセルに値を設定。

dlg.set_table_cell_fill_color(): 選択/指定されたセルに塗りつぶし色を設定。

dlg.set_table_cell_text_color(): 選択/指定されたセルのテキストに色を設定。

dlg.set_table_cell_alignment(): セルのテキスト配置を設定。

dlg.set_table_column_width(): テーブルの指定された列の幅を設定。

dlg.set_table_column_data_type(): テーブルのセルのデータ型検証を設定。

dlg.set_table_cell_button(): テーブルにボタンセルを設定。

dlg.set_table_cell_checkbox(): テーブルにチェックボックスセルを設定。

dlg.select_table_range(): テーブルの位置による特定の範囲を選択。

dlg.clear_table_range(): テーブルの位置による特定の範囲の内容をクリア。

dlg.clear_table_all(): テーブルのすべての内容をクリア。

dlg.get_pagesctrl_current_page(): PagesCtrlの現在選択されているPageItemのインデックス順序を取得。

dlg.get_pagesctrl_page_name(): PagesCtrlの現在選択されているPageItemの名前を取得。

dlg.on_pagesctrl_active_page(): PageItemを選択するときのイベントを設定。

dlg.set_item_size_behavior(): TabWnd、ImageCtrl、Table、PagesCtrlの表示動作を設定。

変更または修正されたコマンドのリスト

dlg.add_groupbox(): GroupBoxのwidthとheight引数を削除。

dlg.add_textbox(): テキストボックス内のテキストの配置と読み取り専用状態を制御する引数をサポート。

dlg.add_combobox(): コンボボックスのデフォルト表示オプションを制御する引数をサポート。

dlg.add_checkbox(): チェックボックス内のテキストの配置を制御する引数をサポート。

dlg.add_table(): テーブルの制御を強化する引数をサポート。

dlg.add_tabwnd(): TabCtrlからTabWndに名前を変更。

dlg.add_button(): 画像ボタンをサポート。

dlg.add_spin(): 整数と倍精度浮動小数点のスピンをサポート。

⚙ マクロ​

後処理とテンプレート利用に関連するマクロが追加されました：

新しく追加されたマクロのリスト

CmdActivateWindow: 特定のPreまたはPostウィンドウをアクティブ化するマクロ。

CmdDistancePlot: 距離プロットのマクロ。

CmdMaxMinPlot: 最大最小プロットのマクロ。

CreateTemplate: テンプレート作成のマクロ。

DeleteTemplate: テンプレート削除のマクロ。

LoadTemplate: 現在のドキュメントにテンプレートを読み込むマクロ。

CopyTemplate: テンプレートコピーのマクロ。

UpdateTemplate: 指定されたテンプレートを更新するマクロ。

ExportTemplate: テンプレートを.xmlファイルにエクスポートするマクロ。

ImportTemplate: .xmlファイルからテンプレートをインポートするマクロ。

AttachTemplateContour: 既存のテンプレートにコンター設定を添付するマクロ。

AttachTemplateDeformation: 既存のテンプレートに変形設定を添付するマクロ。

AttachTemplateViewPoint: 既存のテンプレートにビューポイント設定を添付するマクロ。

AttachTemplateDiagram: 既存のテンプレートにダイアログ設定を添付するマクロ。

AttachTemplateVector: 既存のテンプレートにベクトル設定を添付するマクロ。

AttachTemplateCircle: 既存のテンプレートに円設定を添  付するマクロ。

AttachTemplateCrossSection: 既存のテンプレートに断面設定を添付するマクロ。

AttachTemplateAnimation: 既存のテンプレートに断面設定を添付するマクロ。

CmdSaveOpenTsdv: ポストツールウィンドウのツリーを保存/読み込みするマクロ。

CreateNewChartWindow: 新しいチャートウィンドウを作成するマクロ。

CmdMarkupSearchPoint: 入力値から結果データ上/内部の位置を選択するマクロ。

CmdMarkupSearchMultiPoints: 入力値から結果データ上/内部の複数の位置を選択するマクロ。

マクロのパス記述はスラッシュ（/）で区切るように統一され、CmdExportLoad、CmdImportGaugeなどの一部のインポートおよび保存コマンドが更新されました。

マクロの文字列記述は二重引用符（""）で囲むように統一され、引数で文字列を使用する一部のコマンド（CmdDataPaneSaveToFile、CmdChartSetTitleX、CmdChartSetTitleYなど）が更新されました。

CmdShowPostContourマクロ引数に構造を意味する中括弧（）を追加し、このマクロも追加された新しいオプションに応じて更新されました。

🚅 サンプル​

ユーザーがデータ型を熟練して使用/処理する方法を指導するサンプル_PSJデータ型の操作_を追加。

ユーザーが選択から取得したエンティティを取得し、処理する方法を指導するサンプル_選択からエンティティを取得_を追加。

ユーザーがアセンブリツリーと選択監視ウィンドウのチェックボックスを効率的に制御する方法を指導するサンプル_ウィンドウチェックボックスの更新_を追加。

PSJ-GUI、特にテーブルコンポーネントを効果的に使用する方法をユーザーに指導するため、_12の基本テーブルサンプルと6つの高度なテーブルサンプル_を追加。

📝 その他​

新しいタイプJPT.PathType.FILE_PATHでチュートリアル_Jupiterパス情報の取得_を更新。

新しくアップグレードされたPSJ-GUIでサンプル_標準ボルトの作成_を更新。

🐛 バグ修正​

⌘ PSJ-Command​

引数名の誤字を修正

 | PSJ-Command | 旧 | 新

 | Home.Find | strSeletedType | strSelectedType

📐 PSJ-GUI​

📝 API​

ユーザーがPySide2ライブラリ（以前Jupiter Dialog Generator - JDGで使用）をインポートできない問題を修正。

📏 GUIコマンドビルダー​

GUIコマンドビルダーの外観に関する問題を修正。

階層ウィンドウでの元に戻す/やり直し、コンポーネントの追加、jdbファイルの保存/開くが展開/折りたたみに影響する問題を修正。

GUIコマンドビルダーとPSJダイアログの使用時のクラッシュ問題を修正。

GUIコマンドビルダーからPSJコードを生成する際のコンポーネントのキーワード引数/APIの欠落を修正。

ダイアログを拡大すると内部の画像の位置が変わる問題を修正。

ボタンを押した後にランダムなダイアログが表示される問題を修正。

⚙ マクロ​

CmdPostAnimationIncPlayマクロが動作しないバグを修正。

CmdPostAnimationIncPlayマクロがマクロウィンドウに表示されないバグを修正。

CmdPostAnimationIncPausemacroがマクロウィンドウに表示されないバグを修正。

CmdPlotStrainGauge2Nodesの7番目の引数の単位変換エラーを修正。

ポストドキュメントでメッシュファイルがインポートされるときに表示される余分なマクロ行を削除。

🚅 サンプル​

サンプルパーツから情報を取得のインポートコマンドを修正。

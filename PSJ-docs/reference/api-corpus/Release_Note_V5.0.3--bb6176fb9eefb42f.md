# Release Note V5.0.3

Release Note V5.0.3

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

:::tip[更新のハイライト]
このリリースでは、主に事後処理を強化するためのAPI機能が追加されました。また、新機能や新しいオプションのために、マクロとPSJコマンドが更新されています。詳細は以下の通りです:

- カスタムノート（新機能）コントロール用の新しいデータ型、マクロ、APIが追加されました。
- 事後結果表示情報を取得するためのAPIが追加されました。
- 事後ドキュメントで要素と節点を操作するためのAPIが追加されました。
- 事後ドキュメントで要素と節点を取得する際のバグが修正されました。
- 現在表示されているドキュメントのアクティベーション、選択、クローズを切り替えるためのAPIが追加されました。
- PSJ-GUIでのクラッシュ問題やその他の細かいバグが修正されました。
- preinstalled python libraryにopenpyxlが追加されました。

:::
import ReactPlayer from "react-player/lazy";

## 🚀 新機能

### 📦 データ型

- PSJ-Command:
  - 新しい列挙型 _[`DItemType`](../data-type/psj-command/DItem-types)_ が追加されました。
    <details>
    <summary>新しく追加されたDItemTypeの一覧</summary>

    | INT NOTATION  | DITEMの種別         |
    | ------------- | --------------------- |
    | 270          | `CUSTOM_NOTE`           | 
    | 271          | `CUSTOM_NOTE_COLLECTION`| 
    </details>

  - 新しい列挙型 _[`PathType`](../data-type/psj-utility/pre-utility/enumeration-types/path-types)_ が追加されました。
    <details>
    <summary>新しく追加されたPathTypeの一覧</summary>

    | INT NOTATION  | PATHTYPEの種別         |
    | ------------- | --------------------- |
    | 10   | `JPT.PathType.PSJ_COMMAND_PATH`               |
    </details>
- PSJ-Utility:
  - 新しい列挙型 _[`DTableType`](../data-type/psj-utility/pre-utility/enumeration-types/dtable-types)_ が追加されました。
    <details>
    <summary>新しく追加されたDTableTypeの一覧</summary>

    | INT NOTATION  | DTABLEの種別         |
    | ------------- | --------------------- |
    | 154 | `JPT.DTableType.DTABLE_CUSTOM_NOTE`|
    | 155 | `JPT.DTableType.DTABLE_CUSTOM_NOTE_COLLECTION`| 
    </details>

### ⌘ PSJ-Command

新オプションの追加や使いやすさ/保守性の観点から更新されました。

<details>

<summary>変更されたコマンドの一覧</summary>

- `Connections.Contacts.CheckPattern()`: チェックパターンの結果 - 一致する要素IDと一致しない要素IDを取得できるようになりました。
- `Connections.Pretension.Abaqus()`: ターゲット指定がマクロ実装に合わせて、顔カーソルから任意のエンティティのカーソルリストに変更されました。また、参照節点を指定するための引数が1つ追加されました。
- `Analysis.ADVC.Structure()`: ADVC最適化設定が追加されました。
- `Analysis.Ansys.Structure()`: 互換性維持のためにコマンドバージョンを指定するための引数が1つ追加されました。

</details>

### 🛠 PSJ-Utility

#### 📝 API

- 新たに26のAPIコマンドが追加されました:

  <details>

  <summary>新しく追加されたコマンドの一覧</summary>

  - `JPT.GetAppPathInfo()`: PathTypeで指定されたパスの情報を取得します。
  - `JPT.SelectionByIDs()`: IDを使用してエンティティを選択します。
  - `JPT.IsSpatialPointRendered()`: 現在のビューで(X, Y, Z)の空間座標を持つ指定された点（節点）が表示されているかを確認します。
  - `JPT.CloseAllGraphViews()` : すべてのグラフビューを閉じます。
  - `JPT.CloseGraphViewByDocumentName()`: 指定されたドキュメントのすべてのグラフビューを閉じます。
  - `JPT.ConvertCoordinateFromGlobalToLocal()`: 選択したDItem Typeのグローバル座標を指定されたローカル座標に変換します。
  - `JPT.HighlightByID()`: コマンドはアセンブルツリー内のLBCおよびプロパティアイテムをハイライトします。同時に、ハイライトされたLBC/プロパティに接続されたパーツのフェースの表示も変更されます。
  - `JPT.SetActiveDocumentByID()`: 指定されたIDのドキュメントをアクティブにします。
  - `JPT.SetActiveDocumentByName()`: 指定された名前のドキュメントをアクティブにします。
  - `JPT.GetDocumentList()`: 現在開いているドキュメントのリストを取得します。
  - `JPT.GetActiveDocument()`: アクティブなドキュメントを取得します。
  - `JPT.GetDocumentByID()`: 指定されたIDのドキュメントを取得します。
  - `JPT.GetDocumentByName()`: 指定された名前のドキュメントを取得します。
  - `JPT.CloseDocumentByID()`: 指定されたIDのドキュメントを閉じます。
  - `GetAllCustomNotes`: すべてのカスタムノートを取得します。
  - `GetAllCustomNoteCollections`: すべてのカスタムノートコレクションを取得します。
  - `JPT.GetCurrentDeformation()`: 現在の変形設定を取得します。
  - `JPT.GetCurrentViewPoint()`: 現在のビューポイント設定を取得します。
  - `JPT.GetCurrentCrossSection()`: 現在の断面設定を取得します。
  - `JPT.GetCurrentContour()`: 現在のコンター設定を取得します。
  - `JPT.GetCurrentCircle()`: 現在の円設定を取得します。
  - `JPT.GetCurrentDiagram()`: 現在のダイアグラム設定を取得します。 
  - `JPT.GetCurrentVector()`: 現在のベクトル設定を取得します。
  - `JPT.GetCurrentAnimation()`: 現在のアニメーション設定を取得します。
  - `JPT.CastDItemToDRONode()`: DItemオブジェクトをDPostNodeオブジェクトに変換します。
  - `JPT.CastDItemToDROElem()`: DItemオブジェクトをDPostElemオブジェクトに変換します。

  </details>

- さらに、以下のいくつかのコマンドが修正されました:

  <details>

  <summary>変更および修正されたコマンドの一覧</summary>

  - `JPT.EnableLicenseFeature()`: JPT_BASEが自動的に有効化されるように変更されました。

  </details>

### 📐 PSJ-GUI

#### 📝 API

- 7つの新しいAPIコマンドが追加されました:

  <details>
  <summary>新しく追加されたコマンドの一覧</summary>

  - `dlg.remove_combobox_option()`: Comboboxのすべてまたは一部のオプションを削除します。
  - `dlg.remove_listbox_options()`: Listboxのすべてまたは一部のオプションを削除します。
  - `dlg.get_listbox_sels()`: Listbox内の全ての選択されたインデックスを取得します。
  - `dlg.get_table_cell_fill_color()`: 選択した/指定したセルの塗りつぶし色を取得します。
  - `dlg.on_spin_changed()`: Spinの値が変更された後に関数を実行できるようになります。
  - `dlg.on_listbox_sel()`: ListBoxアイテムが選択された後に関数を実行できるようになります。
  - `dlg.fill_table_by_file()`: GUI上で右クリックを使用せずに、ファイルからテーブルデータを直接設定します。

  </details>

### ⚙ マクロ

- 9つの新しいマクロが追加されました:

  <details>

  <summary>新しく追加されたマクロの一覧</summary>

  - `ViewRemoveMode`: リムーブモードのON/OFFを切り替えるためのマクロ。
  - `ViewShowGroupMode`: グループモードのON/OFFを切り替えるためのマクロ。
  - `ViewShowGlobalCoordinate`: グローバル座標の表示をON/OFFするためのマクロ。
  - `CmdSetPreUnit`: ドキュメントの単位設定用のマクロ。
  - `SetDefaultInitialViewPoint`: 初期ビューポイントを設定するためのマクロ。
  - `ShowContactPairData`: コンタクトペア選択ダイアログでの選択の表示を実装するマクロ。
  - `CreateCustomNote`: 指定されたコレクションの下にカスタムノートを作成するマクロ。
  - `CreateCollection`: コレクションを作成するマクロ。
  - `EditCustomNoteWndPosition`: 指定したカスタムノートを指定した画面位置に移動するマクロ。

  </details>

- さらに、以下のいくつかのマクロが修正されました:

  <details>
  <summary>変更および修正されたマクロの一覧</summary>

  - `LaunchOperation()`: 成功/失敗の値を返すようになりました。

  </details>

### 🚅 サンプル

- 中級者向けの新しいチュートリアルが追加されました。
  - _[Solving plane stress problem.](../tutorials/intermediate/parts-name-mesh-property)_
  - _[Small sample of model setting, analysis and result check.](../tutorials/intermediate/plate-static)_
  - _[Small sample to read / write CSV file.](../tutorials/intermediate/user-material)_
- Pythonコードの新しいチュートリアルが追加されました。
  - _[Python Tips - File I/O](../tutorials/basic/python-tips-file-io)_

### 📝 その他

- 配布物にopenpyxlが含まれています。

## 🐛 バグ修正

### ⌘ PSJ-Command

- Analysis.ADVC.StructureがPython APIウィンドウに表示されないバグを修正しました。
- Analysis.MakeProcess.Staticで、一部のLBCがカーソル文字列表記を受け入れなかったバグを修正しました。
- Geometry.Transform.Translationが空のリストを返すことによる無効なリテラルエラーを修正しました。

### 📐 PSJ-GUI

#### 📝 API

- dlg.set_table_column_widthを66未満に設定できないバグを修正しました。22以上に設定可能です。
- dlg.on_browseがフォルダパスを返さなかったバグを修正しました。
- dlg.on_dlg_selector_changedでのクラッシュバグを修正しました。
- dlg.on_dlg_selector_changedの実行中に選択が削除されるとクラッシュするバグを修正しました。

#### 📏 GUIコマンドビルダー

- テキストボックスのタイプが*.jdbファイルに正しく保存されないバグを修正しました。
- Comboboxのオプション数に誤った値が入力されることでクラッシュするバグを修正しました。
- テーブルの総行数に誤った値が入力されることでクラッシュするバグを修正しました。
- テーブルの総列数に誤った値が入力されることでクラッシュするバグを修正しました。

### 🛠 PSJ-Utility

#### 📝 API

- JPT.GetEntitiesByPositionが誤ったターゲットを見つけるバグを修正しました。
- JPT.GetSelectedNodesがポストドキュメントのソリッド要素の節点を取得できないバグを修正しました。
- JPT.MacroListTCursorToListDItemがポストドキュメントで正しく機能しないバグを修正しました。

### ⚙ マクロ
- テンプレートをロードするマクロが順次実行されるとビューポイントが変更されないエラーを修正しました。
- SetDefaultInitialTreeConditionが正しく機能しないエラーを修正しました。
- CmdShowPostContourが正しく機能しないエラーを修正しました。
- CmdShowPostContourがショーミドル節点アイコンのステータスを変更しないエラーを修正しました。

### 📝 その他
- IDEのImport Python Macro Log (Ctrl+J)で一部のコマンドがインポートされないエラーを修正しました。

# Repository Guidelines

## プロジェクト構成とモジュール整理
- `FleaMarketSearch/` 直下に SwiftUI ビューがまとまり、`TabView/` は各マーケットごとの WebView ラッパー、`SubView/` は検索ボタンなどの共通コンポーネントを保持します。
- `Assets.xcassets` に配色やアイコン、`Preview Content/` に Xcode プレビュー用データが格納されます。
- `FleaMarketSearchTests/` および `FleaMarketSearchUITests/` に XCTest と UI テストが分離されているので、追加テストは該当ディレクトリ内でファイルを分けてください。

## ビルド・テスト・開発コマンド
- `xed .` : Xcode プロジェクトを開き、シミュレータ設定や Preview をそのまま利用できます。
- `xcodebuild -scheme FleaMarketSearch -destination 'platform=iOS Simulator,name=iPhone 15' build` : CI 互換のビルド検証。シミュレータ名は手元の環境に合わせて調整します。
- `xcodebuild -scheme FleaMarketSearch -destination 'platform=iOS Simulator,name=iPhone 15' test` : 単体・UI テストをまとめて実行し、失敗時は該当テストクラスで原因を特定します。

## コーディングスタイルと命名規約
- インデントは Xcode 既定の 4 スペース。クロージャは末尾トレーリング構文を優先し、`guard` で早期リターンを徹底します。
- 型名・ビュー名は `CamelCase`、メンバーは `lowerCamelCase`。画面を表す構造体は `SomethingView`、ユーティリティは現在の `UserDefaultsOp` に倣い `SomethingOp` を推奨します。
- 文字列リテラルはローカライズ予定を踏まえ、`Text("...")` では将来 `NSLocalizedString` への移行を想定して TODO コメントを残さないまま定義してください。

## テストガイドライン
- 単体テストは `FleaMarketSearchTests.swift` を参考に、検索キーワード保存など状態管理ロジックを個別メソッドごとに検証します。
- UI テストは `FleaMarketSearchUITests.swift` で画面遷移と WebView 表示確認を行い、ファイル命名は `FeatureNameUITests` を推奨します。
- 新規テストでは `xcodebuild … test` または Xcode の `⌘U` 実行結果をプルリク説明に添付し、主要分岐(検索成功・履歴空)を網羅してください。

## コミットとプルリクエスト
- Git 履歴では `fix`, `update`, `release` などの接頭辞が多用されています。同様に英語または短い日本語で目的を 50 文字以内にまとめてください。
- プルリクでは変更概要、関連 Issue、主要画面のスクリーンショット (UI 変更時) を含め、影響範囲とテスト結果 (`xcodebuild … test`) を明記します。
- レビュー前に `git status` で差分を確認し、不要な生成ファイル (`DerivedData/` など) が含まれないよう `.gitignore` を再確認してください。

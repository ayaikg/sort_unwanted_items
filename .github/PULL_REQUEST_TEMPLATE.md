## 概要
rails newをした後、gemの追加とアプリの初期設定を行いました。
CSSフレームワークのtailwind cssとdaisyuiの追加も合わせて行なっております。
また、gemにrails-i18nを追加しておりますので、日本語化対応の設定もしました。
## 確認方法
config/application.rbで、不要なファイルを生成しない設定と日本語化対応の確認ができます。
tailwind.config.jsでCSSフレームワーク導入の確認ができます。
config/locales以下に日本語化対応のymlファイルを作成しています。
## 影響範囲
viewでの表示方法が日本語、日本時間に変更されます。
## チェックリスト

## コメント
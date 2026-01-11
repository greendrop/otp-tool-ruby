# otp-tool-ruby

Ruby で書かれた、OTP (TOTP) 用の簡易 CLI ツールです。

- `code` コマンド: 現在の TOTP コードを 30 秒間隔と同期して自動更新しながら表示
- `qr` コマンド: OTP URI からターミナル上に QR コードを表示

## 必要環境

- Ruby
- Bundler

## セットアップ

```bash
bundle install
```

## Lint (RuboCop)

```bash
bundle exec rubocop
```

## テスト (RSpec)

```bash
bundle exec rspec
```

## 使い方

### 基本形式

```bash
ruby otp_tool.rb [code|qr] OTP_URI
```

`OTP_URI` は、`secret` パラメータを含む otpauth URI です。

例:

```text
otpauth://totp/Example:alice@example.com?secret=BASE32SECRET&issuer=Example
```

### コマンド詳細

#### 1. TOTP コードを表示する (`code`)

```bash
bundle exec ruby otp_tool.rb code "otpauth://totp/Example:alice@example.com?secret=BASE32SECRET&issuer=Example"
```

- 現在の TOTP コードを表示し、30 秒間隔と同期して 1 秒ごとに残り秒数を更新します。
- 終了するには `Ctrl + C` を押します。

#### 2. QR コードを表示する (`qr`)

```bash
bundle exec ruby otp_tool.rb qr "otpauth://totp/Example:alice@example.com?secret=BASE32SECRET&issuer=Example"
```

- ターミナル上に QR コードを表示します。
- 表示された QR コードをスマートフォンの認証アプリでスキャンできます。

## エラー

- URI に `secret` パラメータが含まれていない場合: `The URI does not contain a 'secret' parameter.`
- URI の形式が不正な場合: `Invalid URI format.`

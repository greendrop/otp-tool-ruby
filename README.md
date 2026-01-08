# otp-tool-ruby

A simple CLI tool for OTP (TOTP) written in Ruby.

- `code` command: Shows the current TOTP code and automatically refreshes it in sync with 30-second intervals
- `qr` command: Renders a QR code in the terminal from an OTP URI

## Requirements

- Ruby
- Bundler

## Setup

```bash
bundle install
```

## Lint (RuboCop)

```bash
bundle exec rubocop
```

## Usage

### Basic usage

```bash
ruby otp_tool.rb [code|qr] OTP_URI
```

`OTP_URI` is an otpauth URI that contains a `secret` parameter.

Example:

```text
otpauth://totp/Example:alice@example.com?secret=BASE32SECRET&issuer=Example
```

### Commands

#### 1. Show TOTP code (`code`)

```bash
bundle exec ruby otp_tool.rb code "otpauth://totp/Example:alice@example.com?secret=BASE32SECRET&issuer=Example"
```

- Displays the current TOTP code and updates it automatically every 30 seconds, showing the remaining seconds every second.
- Press `Ctrl + C` to exit.

#### 2. Show QR code (`qr`)

```bash
bundle exec ruby otp_tool.rb qr "otpauth://totp/Example:alice@example.com?secret=BASE32SECRET&issuer=Example"
```

- Renders a QR code in the terminal.
- You can scan the displayed QR code with an authenticator app on your smartphone.

## Errors

- If the URI does not contain a `secret` parameter: `The URI does not contain a 'secret' parameter.`
- If the URI format is invalid: `Invalid URI format.`

# frozen_string_literal: true

require_relative 'uri_parser'
require_relative 'code_command'
require_relative 'qr_command'

module OtpTool
  class CLI
    USAGE = <<~USAGE
      Usage:
        ruby otp_tool.rb code OTP_URI
            Display the current TOTP code and automatically refresh it
            in sync with the 30-second interval. Press Ctrl+C to stop.

        ruby otp_tool.rb qr OTP_URI
            Render the OTP URI as a QR code in the terminal so that it
            can be scanned by an authenticator app on your phone.

      Arguments:
        OTP_URI
            An otpauth URI that contains a `secret` parameter, such as:
            otpauth://totp/Example:alice@example.com?secret=BASE32SECRET&issuer=Example
    USAGE

    def self.run(argv)
      command = argv.shift
      otp_uri = argv.shift

      if command.nil? || otp_uri.nil?
        puts USAGE
        return
      end

      case command
      when 'code'
        CodeCommand.new(otp_uri).run
      when 'qr'
        QrCommand.new(otp_uri).run
      else
        puts "Unknown command: #{command}"
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end

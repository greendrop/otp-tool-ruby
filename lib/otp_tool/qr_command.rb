# frozen_string_literal: true

require 'rqrcode'

module OtpTool
  class QrCommand
    def initialize(otp_uri)
      @otp_uri = otp_uri
    end

    def run
      qrcode = build_qrcode
      print_qrcode(qrcode)
      print_hint
    end

    private

    def build_qrcode
      RQRCode::QRCode.new(@otp_uri)
    end

    def print_qrcode(qrcode)
      puts qrcode.as_ansi(light: "\033[47m", dark: "\033[40m", fill_character: '  ', quiet_zone_size: 2)
    end

    def print_hint
      puts "\nScan this QR code with an authenticator app on your phone."
    end
  end
end

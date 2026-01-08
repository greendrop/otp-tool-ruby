# frozen_string_literal: true

require 'rotp'

module OtpTool
  class CodeCommand
    def initialize(otp_uri)
      @otp_uri = otp_uri
    end

    def run
      secret = UriParser.new(@otp_uri).secret
      totp = ROTP::TOTP.new(secret)

      puts 'Press Ctrl+C to stop...'
      display_loop(totp)
    end

    private

    def display_loop(totp)
      loop do
        print_current_code_line(totp)
        sleep 1
      end
    rescue Interrupt
      puts "\nExiting."
    end

    def print_current_code_line(totp)
      now = Time.now.to_i
      remaining = totp.interval - (now % totp.interval)
      code = totp.now

      print "\rCode: \e[32m#{code}\e[0m (#{remaining.to_s.rjust(2)} seconds left) \e[K"
    end
  end
end

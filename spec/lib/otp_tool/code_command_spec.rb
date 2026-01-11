# frozen_string_literal: true

require 'spec_helper'
require 'otp_tool/code_command'
require 'otp_tool/uri_parser'
require_relative '../../support/capture_stdout'

RSpec.describe OtpTool::CodeCommand do
  let(:otp_uri) { 'otpauth://totp/Example:alice@example.com?secret=SECRET&issuer=Example' }
  let(:secret) { 'SECRET' }
  let(:totp_double) { instance_double(ROTP::TOTP) }

  before do
    allow(OtpTool::UriParser).to receive(:new).with(otp_uri).and_return(instance_double(OtpTool::UriParser,
                                                                                        secret: secret))
    allow(ROTP::TOTP).to receive(:new).with(secret).and_return(totp_double)
  end

  describe '#run' do
    it 'UriParser と ROTP::TOTP を使って display_loop を呼び出す' do
      command = described_class.new(otp_uri)

      allow(command).to receive(:display_loop)

      capture_stdout { command.run }

      expect(command).to have_received(:display_loop).with(totp_double)
    end

    it '開始メッセージを出力する' do
      command = described_class.new(otp_uri)
      allow(command).to receive(:display_loop)

      expect { command.run }.to output(/Press Ctrl\+C to stop\.\.\./).to_stdout
    end
  end
end

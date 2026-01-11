# frozen_string_literal: true

require 'spec_helper'
require 'stringio'
require 'otp_tool/qr_command'

RSpec.describe OtpTool::QrCommand do
  let(:otp_uri) { 'otpauth://totp/Example:alice@example.com?secret=SECRET&issuer=Example' }
  let(:qrcode_double) { instance_double(RQRCode::QRCode, as_ansi: 'QR_CODE') }

  before do
    allow(RQRCode::QRCode).to receive(:new).with(otp_uri).and_return(qrcode_double)
  end

  describe '#run' do
    it 'QR コードを生成し、端末に出力する' do
      command = described_class.new(otp_uri)

      expect { command.run }.to output(/QR_CODE/).to_stdout
    end
  end
end

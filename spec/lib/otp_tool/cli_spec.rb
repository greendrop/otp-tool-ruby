# frozen_string_literal: true

require 'spec_helper'
require 'stringio'
require 'otp_tool/cli'
require 'otp_tool/code_command'
require 'otp_tool/qr_command'
require_relative '../../support/capture_stdout'

RSpec.describe OtpTool::CLI do
  describe '.run' do
    let(:otp_uri) { 'otpauth://totp/Example:alice@example.com?secret=SECRET&issuer=Example' }

    it '引数が不足している場合は USAGE を表示する' do
      output = capture_stdout { described_class.run([]) }

      expect(output).to include('Usage:')
      expect(output).to include('otp_tool.rb code OTP_URI')
    end

    it '未知のコマンドの場合は Unknown command を表示する' do
      output = capture_stdout { described_class.run(['unknown', otp_uri]) }

      expect(output).to include('Unknown command: unknown')
    end

    it 'code コマンドの場合は CodeCommand を実行する' do
      code_command_double = instance_double(OtpTool::CodeCommand)

      allow(OtpTool::CodeCommand).to receive(:new).with(otp_uri).and_return(code_command_double)
      allow(code_command_double).to receive(:run)

      described_class.run(['code', otp_uri])

      expect(code_command_double).to have_received(:run)
    end

    it 'qr コマンドの場合は QrCommand を実行する' do
      qr_command_double = instance_double(OtpTool::QrCommand)

      allow(OtpTool::QrCommand).to receive(:new).with(otp_uri).and_return(qr_command_double)
      allow(qr_command_double).to receive(:run)

      described_class.run(['qr', otp_uri])

      expect(qr_command_double).to have_received(:run)
    end

    it '実行時に StandardError が発生した場合はエラーメッセージを表示する' do
      allow(OtpTool::CodeCommand).to receive(:new).and_raise(StandardError, 'something went wrong')

      output = capture_stdout { described_class.run(['code', otp_uri]) }

      expect(output).to include('Error: something went wrong')
    end
  end
end

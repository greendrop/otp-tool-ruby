# frozen_string_literal: true

require 'spec_helper'
require 'otp_tool/uri_parser'

RSpec.describe OtpTool::UriParser do
  describe '#secret' do
    let(:label) { 'Example:alice@example.com' }
    let(:issuer) { 'Example' }
    let(:secret_value) { 'BASE32SECRET' }

    let(:uri) do
      "otpauth://totp/#{label}?secret=#{secret_value}&issuer=#{issuer}"
    end

    it 'secret パラメータを返す' do
      parser = described_class.new(uri)

      expect(parser.secret).to eq(secret_value)
    end

    it 'secret パラメータが存在しない場合は例外を送出する' do
      uri_without_secret = "otpauth://totp/#{label}?issuer=#{issuer}"
      parser = described_class.new(uri_without_secret)

      expect { parser.secret }.to raise_error(RuntimeError, "The URI does not contain a 'secret' parameter.")
    end

    it 'secret パラメータが空の場合は例外を送出する' do
      uri_with_empty_secret = "otpauth://totp/#{label}?secret=&issuer=#{issuer}"
      parser = described_class.new(uri_with_empty_secret)

      expect { parser.secret }.to raise_error(RuntimeError, "The URI does not contain a 'secret' parameter.")
    end

    it '不正なURI形式の場合は例外を送出する' do
      invalid_uri = 'not a uri'
      parser = described_class.new(invalid_uri)

      expect { parser.secret }.to raise_error(RuntimeError, 'Invalid URI format.')
    end
  end
end

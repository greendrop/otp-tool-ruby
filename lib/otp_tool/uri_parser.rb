# frozen_string_literal: true

require 'uri'
require 'cgi'

module OtpTool
  class UriParser
    def initialize(uri_str)
      @uri_str = uri_str
    end

    def secret
      uri = URI.parse(@uri_str)
      params = CGI.parse(uri.query || '')
      secret = params['secret']&.first
      raise "The URI does not contain a 'secret' parameter." if secret.nil? || secret.empty?

      secret
    rescue URI::InvalidURIError
      raise 'Invalid URI format.'
    end
  end
end

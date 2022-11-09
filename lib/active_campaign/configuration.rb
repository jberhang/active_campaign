# frozen_string_literal: true

module ActiveCampaign
  #
  # Class Configuration provides configuration of ActiveCampaign
  #
  # @author Mikael Henriksson <mikael@mhenrixon.com>
  #
  class Configuration
    API_URL   = 'https://account.api-us1.com/api/3'
    API_TOKEN = 'ACCOUNT_TOKEN'

    #
    # @!attribute [r] api_url
    #   @return [String, URI] the URI for your personal API
    attr_reader :api_url

    #
    # @!attribute [r] api_timeout
    #   @return [Integer] timeout in seconds
    attr_reader :api_timeout

    #
    # @!attribute [r] api_token
    #   @return [String] the authorization token to use for all requests
    attr_reader :api_token

    #
    # @!attribute [r] debug
    #   @return [true,false] turn verbose debug info on or off
    attr_reader :debug
    alias debug? debug

    def initialize
      self.api_url         = API_URL
      self.api_timeout     = 5
      self.api_token       = API_TOKEN
      self.debug           = false
    end


    def api_url=(obj)
      raise ArgumentError, "api_url (#{obj}) needs to be a String or URI" unless obj.is_a?(String) || obj.is_a?(URI)

      @api_url = obj
    end

    def api_timeout=(obj)
      raise ArgumentError, "api_timeout (#{obj}) is not a number" unless obj.is_a?(Integer)

      @api_timeout = obj
    end

    def api_token=(obj)
      raise ArgumentError, "api_token (#{obj}) is not a string" unless obj.is_a?(String)

      @api_token = obj
    end

    def debug=(obj)
      unless [NilClass, TrueClass, FalseClass].include?(obj.class)
        raise ArgumentError, "debug (#{obj}) must be nil, true or false"
      end

      @debug = obj
    end

    def to_h
      {
        api_url: api_url,
        api_timeout: api_timeout,
        api_token: api_token
      }
    end
  end
end
# frozen_string_literal: true

require "active_campaign/version"
require "active_campaign/errors"
require "active_campaign/api"
require "active_campaign/configuration"
require "active_campaign/client"

module ActiveCampaign
  module_function

  def client
    @client ||= ActiveCampaign::Client.new(config.to_h)
  end  

  def config
    @config ||= Configuration.new
  end

  def configure
    yield config if block_given?
  end

end

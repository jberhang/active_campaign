require 'simplecov'
SimpleCov.start

require 'rspec'
require 'bundler/setup'
Bundler.setup

require 'active_campaign'


require_relative 'support/concerns'


ActiveCampaign.configure do |config|
  config.api_url   = ENV['ACTIVE_CAMPAIGN_URL']
  config.api_token = ENV['ACTIVE_CAMPAIGN_TOKEN']
  config.debug     = ENV.fetch('ACTIVE_CAMPAIGN_DEBUG', 'false') == 'true'
end
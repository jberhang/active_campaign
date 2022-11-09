require 'spec_helper'

describe ActiveCampaign::Api::Accounts, :vcr do

  include_context "active_campaign"

  describe '#create_account' do
    include_context "account_paramable"
    let(:response) {client.create_account(account_params)}

    after do
      client.delete_account(response["account"]["id"])      
    end

    it 'returns an account hash' do
      expected_result = {"name" => account_name, "accountUrl" => account_url}
      response["account"].should include(expected_result)
    end
  end  

  describe '#show_account' do

    include_context "accountable"
    let(:response) { client.show_account(account_id) }  

    it 'returns an account hash' do
      expected_result = {"name" => account_name, "accountUrl" => account_url}
      response["account"].should include(expected_result)
    end
  end

  describe '#update_account' do

    include_context "accountable"
    let(:new_account_name) { 'Deeky Freaks' }
    let(:new_account_url)  { 'https://www.giberish.com' }
    let(:update_params) do
      {
        name: new_account_name,
        account_url: new_account_url
      }
    end    
    let(:response) { client.update_account(account_id, update_params) }  

    it 'returns an account hash' do
      expected_result = {"name" => new_account_name, "accountUrl" => new_account_url}
      response["account"].should include(expected_result)
    end
  end

  describe '#show_accounts' do
    include_context "accountable"
    let(:response) { client.show_accounts(search) }
    let(:search) { 'Freak' }

    it 'returns an accounts array' do
      expected_result = {"name" => account_name, "accountUrl" => account_url}
      response["accounts"].first.should include(expected_result)
    end
  end  
end
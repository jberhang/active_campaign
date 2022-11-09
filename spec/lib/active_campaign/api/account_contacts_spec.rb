require 'spec_helper'

describe ActiveCampaign::Api::AccountContacts, :vcr do

  include_context "active_campaign"

  describe '#create_account_contact' do

    include_context "accountable"
    include_context "contactable"

    let(:account_contact_params) {{account: account_id, contact: contact_id, title: "The Man"}}
    let(:response) {client.create_account_contact(account_contact_params)}

    after do
      client.delete_account_contact(response["accountContact"]["id"])      
    end

    it 'returns an account contact hash' do
      expected_result = {"account" => account_id, "contact" => contact_id}
      response["accountContact"].should include(expected_result)
    end
  end  

  describe '#delete_account_contact' do
    include_context "account_contactable"

    before {client.delete_account_contact(account_contact_id)}

    it "should remove the association" do
      response = client.show_account_contact(account_contact_id)
      response["message"].should include("No Result found")
    end

    it "should not delete the contact" do
      response = client.show_contact(contact_id)
      response["contact"].should include({"id" => contact_id})
    end

    it "should not delete the account" do
      response = client.show_account(account_id)
      response["account"].should include({"id" => account_id})      
    end
  end

end
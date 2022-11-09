require 'spec_helper'

describe ActiveCampaign::Api::Contacts, :vcr do

  include_context "active_campaign"

  describe '#create_contact' do
    include_context "contact_paramable"
    let(:response) {client.create_contact(contact_params)}

    after do
      client.delete_contact(response["contact"]["id"])      
    end

    it 'returns an contact hash' do
      expected_result = {"firstName" => contact_first_name, "lastName" => contact_last_name, "email" => contact_email}
      response["contact"].should include(expected_result) 
    end
  end  

  describe '#show_contact' do

    include_context "contactable"
    let(:response) { client.show_contact(contact_id) }  

    it 'returns an contact hash' do
      expected_result = {"firstName" => contact_first_name, "lastName" => contact_last_name, "email" => contact_email}
      response["contact"].should include(expected_result)
    end
  end

  describe '#update_contact' do

    include_context "contactable"
    let(:update_params) do
      {
        firstName: "Someone",
        lastName: "Else"
      }
    end    
    let(:response) { client.update_contact(contact_id, update_params) }  

    it 'returns an contact hash' do
      expected_result = {"firstName" => "Someone", "lastName" => "Else"}
      response["contact"].should include(expected_result)
    end
  end

  describe '#show_contacts' do
    include_context "contactable"
    let(:search) { 'Tester' }
    let(:response) { client.show_contacts(search: search) }

    it 'returns an contacts array' do
      expected_result = {"firstName" => contact_first_name, "lastName" => contact_last_name}
      response["contacts"].first.should include(expected_result)
    end
  end  
end
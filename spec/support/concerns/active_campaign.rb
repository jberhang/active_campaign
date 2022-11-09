RSpec.shared_context "active_campaign", :shared_context => :metadata do
  let(:client) { ActiveCampaign.client }
end

RSpec.shared_context "account_paramable", :shared_context => :metadata do
  let(:account_name) { 'Freaky Deeks' }
  let(:account_url)  { 'https://hokus.pokus.io' }
  let(:account_params) { { name: account_name, account_url: account_url } }  
end

RSpec.shared_context "accountable", :shared_context => :metadata do

  include_context "account_paramable"

  let(:account) {client.create_account(account_params)}
  let!(:account_id) {account["account"]["id"]}

  after {client.delete_account(account_id)}
end

RSpec.shared_context "contact_paramable", :shared_context => :metadata do
  let(:contact_email) { "slytester@testers.com" }
  let(:contact_first_name) { 'Sly' }
  let(:contact_last_name)  { 'Tester' }
  let(:contact_phone) {"8554569987"}
  let(:contact_params) { { email: contact_email, firstName: contact_first_name, lastName: contact_last_name, phone: contact_phone} }  
end

RSpec.shared_context "contactable", :shared_context => :metadata do

  include_context "contact_paramable"
  
  let(:contact) {client.create_contact(contact_params)}
  let!(:contact_id) {contact["contact"]["id"]}

  after {client.delete_contact(contact_id)}  
end

RSpec.shared_context "account_contactable", :shared_context => :metadata do

  include_context "accountable"
  include_context "contactable"

  let(:account_contact_params) {{account: account_id, contact: contact_id, title: "Title TBD"}}
  let(:account_contact) {client.create_account_contact(account_contact_params)}
  let!(:account_contact_id) {account_contact["accountContact"]["id"]}
end
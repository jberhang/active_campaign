module ActiveCampaign
  module Api
    module Contacts
      def create_contact(params)
        post('contacts', contact: params)
      end
      def show_contact(id)
        get("contacts/#{id}")
      end   
      def show_contacts(query)
        get('contacts', query)
      end         
      def update_contact(id, params)
        put("contacts/#{id}", contact: params)
      end      
      def delete_contact(id)
        delete("contacts/#{id}")
      end      
    end
  end
end
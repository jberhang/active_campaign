# frozen_string_literal: true

module ActiveCampaign
  module Api
    #
    # Refactor from active_campaign gem: 
    # https://github.com/mhenrixon/active_campaign
    #
    module AccountContacts

      def create_account_contact(params)
        post('accountContacts', accountContact: params)
      end

      def show_account_contact(id)
        get("/accountContacts/#{id}")
      end

      def show_account_contacts(query)
        get('/accountContacts', query)
      end

      def update_account_contact(id, params)
        put("/accountContacts/#{id}", accountContact: params)
      end

      def delete_account_contact(id)
        delete("/accountContacts/#{id}")
      end
    end
  end
end
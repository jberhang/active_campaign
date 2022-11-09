module ActiveCampaign
  module Api
    module Users
      def show_user(id)
        get("users/#{id}")
      end   
    end
  end
end
module ActiveCampaign
  module Api
    module Deals
      def create_deal(params)
        post('deals', deal: params)
      end
      def show_deal(id)
        get("deals/#{id}")
      end   
      def find_deals(query)
        get('deals', query)
      end             
      def delete_deal(id)
        delete("deals/#{id}")
      end    
      def update_deal(id, params)
        put("deals/#{id}", deal: params)
      end        
    end
  end
end
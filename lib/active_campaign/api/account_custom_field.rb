module ActiveCampaign
  module Api
    module AccountCustomField
      def show_account_custom_field_data(account_id)
        get("/accounts/#{account_id}/accountCustomFieldData")
      end

      def find_account_custom_field_data(account_id, field_id)
        response = show_account_custom_field_data(account_id)
        return nil if response.nil?
        found = response["customerAccountCustomFieldData"].select{|cfm| cfm["custom_field_id"] == field_id}
        found.first if found.any?
      end

      def create_account_custom_field_data(params)
        post('accountCustomFieldData', accountCustomFieldDatum: params)
      end 

      def show_account_custom_field_meta(field_id)
        get("/accountCustomFieldMeta/#{field_id}")
      end 

      def find_account_custom_field_meta(field_label)
        response = get("/accountCustomFieldMeta")
        return nil if response.nil?
        found = response["accountCustomFieldMeta"].select{|cfm| cfm["fieldLabel"] == field_label}
        found.first if found.any?
      end     

      def find_account_custom_field_text_value(account_id, field_label) 
        response = find_account_custom_field_meta(field_label)
        return nil if response.nil?
        field_id = response["id"]
        field_data = find_account_custom_field_data(account_id, field_id)
        field_data["custom_field_text_value"] if field_data        
      end

    end
  end
end
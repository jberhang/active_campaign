require 'uri'
require 'net/http'
require 'openssl'

module ActiveCampaign
  #
  # Refactor from active_campaign gem: 
  # https://github.com/mhenrixon/active_campaign
  #
  class Client
    include Api        

    endpoint :accounts
    endpoint :contacts
    endpoint :account_contacts
    endpoint :deals
    endpoint :users
    endpoint :account_custom_field
    
    def initialize(conf)      
      @base_uri = conf[:api_url]
      @api_token = conf[:api_token]
    end

    def post(endpoint, body)
      url = prepare_url(endpoint)  
      request = Net::HTTP::Post.new(url)
      request.body = body.to_json
      process_request(url, request)
    end

    def patch(*args)
    end

    def put(endpoint, body)
      url = prepare_url(endpoint)  
      request = Net::HTTP::Put.new(url)
      request.body = body.to_json
      process_request(url, request)      
    end

    def delete(endpoint)
      url = prepare_url(endpoint)
      request = Net::HTTP::Delete.new(url)    
      process_request(url, request)      
    end

    def get(endpoint, query={})
      url = prepare_url(endpoint)
      url.query = URI.encode_www_form(query) unless query.empty?
      request = Net::HTTP::Get.new(url)    
      process_request(url, request)
    end

    private 
      def process_request(url, request)
        #puts "#{request.class.name}: #{url}"
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true         
        prepare_headers(request)   
        begin 
          response = http.request(request)     
          JSON.parse(response.read_body)
        rescue => e
          puts "#{e.class.name}: #{e.message}"
        end
      end

      def prepare_headers(request)
        request["accept"] = 'application/json'
        request["content-type"] = 'application/json'
        request["api-token"] = @api_token
      end

      def prepare_url(endpoint)
        URI("#{@base_uri}/#{endpoint}")
      end
  end
end
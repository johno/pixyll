module PocketApi
  class Connection
    include HTTParty
    base_uri 'https://getpocket.com'
    headers "Content-Type" => "application/json; charset=UTF-8"
    headers "X-Accept" => "application/json"

    class <<self
      attr_accessor :client_key
      attr_accessor :request_token

      #####################################################
      # OAuth authorization Helpers
      # Sample Workflow:
      # 1. generate_authorize_url, redirect user to URL
      # 2. generate_access_token if user comes back
      # 3. Do a sample call to API to see if it works
      #####################################################
      def generate_request_token(body_options={}, headers_options={})
        response = post("/v3/oauth/request", :body => MultiJson.dump({:consumer_key => @client_key}.merge(body_options)), :headers => {"Content-Type" => "application/json; charset=UTF-8", "X-Accept" => "application/json"}.merge(headers_options))
        if response.success? && response.parsed_response["code"]
          # Should be a string body like "code=12345678"
          @request_token = response.parsed_response["code"]
        else
          raise "could not generate request token: #{response.inspect}"
        end
      end
      
      def generate_access_token(request_token=@request_token)
        response = post("/v3/oauth/authorize", :body => MultiJson.dump({:code => request_token, :consumer_key => @client_key}), :headers => {"Content-Type" => "application/json; charset=UTF-8", "X-Accept" => "application/json"})
        raise response.headers["X-Error"] if response.headers["X-Error"]
        
        response.parsed_response["access_token"]
      end
      
      def generate_authorize_url(redirect_uri, state=nil)
        @request_token = generate_request_token({:redirect_uri => redirect_uri})
        
        "#{default_options[:base_uri]}/auth/authorize?request_token=#{CGI.escape(request_token)}&redirect_uri=#{CGI.escape(redirect_uri)}#{"&state=#{CGI.escape(state)}"if state}"
      end
      
    end # <<self
    
    
  end
end

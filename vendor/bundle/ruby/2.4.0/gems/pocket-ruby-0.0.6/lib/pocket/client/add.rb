module Pocket
  class Client
    # http://getpocket.com/developer/docs/v3/add
    module Add
      # required params: url, consumer_key, access_token
      def add params
        response = connection.post("/v3/add", params)
        response.body
      end
    end
  end
end

module Pocket
  class Client
    # http://getpocket.com/developer/docs/v3/modify
    module Modify
      # required params: actions, consumer_key, access_token
      def modify actions
        response = connection.post("/v3/send", {actions: actions})
        response.body
      end
    end
  end
end

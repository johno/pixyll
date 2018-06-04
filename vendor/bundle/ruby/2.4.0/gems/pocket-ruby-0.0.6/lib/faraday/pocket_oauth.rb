require 'faraday'

# @private
module FaradayMiddleware
  # @private
  class PocketOAuth < Faraday::Middleware
    def call(env)
      env[:body] = {} if env[:body].nil?
      env[:body] = env[:body].merge(:consumer_key => @consumer_key)

      if @access_token
        env[:body] = env[:body].merge(:access_token => @access_token)
      end

      @app.call env
    end

    def initialize(app, consumer_key, access_token=nil)
      @app = app
      @consumer_key = consumer_key
      @access_token = access_token
    end
  end
end

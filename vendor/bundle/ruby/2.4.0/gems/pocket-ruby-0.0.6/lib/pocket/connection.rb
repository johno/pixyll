require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Pocket
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'User-Agent' => user_agent},
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => endpoint,
      }

      Faraday::Connection.new(options) do |conn|
        conn.use FaradayMiddleware::PocketOAuth, consumer_key, access_token
        conn.use Faraday::Response::RaisePocketError

        conn.request :json

        conn.response :json, :content_type => /\bjson$/

        conn.adapter Faraday.default_adapter
      end
    end
  end
end

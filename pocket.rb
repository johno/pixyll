require "rubygems"
require "bundler/setup"
require "json"
require "pocket_api"

# PocketApi::Connection.client_key = API_KEY
# puts PocketApi::Connection.generate_authorize_url("http://localhost:4000", "https://getpocket.com/developer/app/77648/345feec8f80328ced141dc35")
# puts PocketApi::Connection.generate_access_token()
PocketApi.configure(:client_key=> ENV["CLIENT_KEY"], :access_token => ENV["ACCESS_TOKEN"])

PocketApi.retrieve({:tag => "feedly"}).each do |article|
  puts article.inspect
end

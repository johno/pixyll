lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minitest/spec'
require 'minitest/autorun'
require 'pocket_api'

describe PocketApi do
  describe "configure" do
    it "sets client_key and access_token" do
      PocketApi.configure(:client_key => "mykey", :access_token => "myat")
      PocketApi.client_key.must_equal "mykey"
      PocketApi.access_token.must_equal "myat"
    end
  end
  
  describe "request" do
    it "should convert :body of argument into JSON"
    it "should insert consumer_key and access_token into argument :body"
    it "should call Connection.get"
    it "should call Connection.post"
  end

  describe "retrieve" do
  end

  describe "add" do
  end

  describe "modify" do
  end
  
end
require "rubygems"
require "bundler/setup"
require "json"
require "pocket_api"
require "pocket-ruby"
require "pp"
require 'date'
require "http"
require "net/http"
require "uri"
require "logger"

logger = Logger.new(STDOUT)

key = ENV["CLIENT_KEY"]
token = ENV["ACCESS_TOKEN"]
PocketApi.configure(:client_key=> key, :access_token => token)

def archive_item(item_id)
  key = ENV["CLIENT_KEY"]
  token = ENV["ACCESS_TOKEN"]
  url = "https://getpocket.com/v3/send?actions=%5B%7B%22action%22%3A%22archive%22%2C%22item_id%22%3A#{item_id}%7D%5D&access_token=#{token}&consumer_key=#{key}"
  uri = URI.parse(url)
  request = Net::HTTP::Post.new(uri)

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
  puts response.code
end

# def generate_access_token
#   key = ENV["CLIENT_KEY"]
#   PocketApi::Connection.client_key = key
#   puts PocketApi::Connection.generate_authorize_url("http://localhost:4000", "https://getpocket.com/developer/app/77648/345feec8f80328ced141dc35")
#   puts PocketApi::Connection.generate_access_token( )
# end

logger.info "Loading all blog tagged, non archived"
PocketApi.retrieve({:tag => "blog"}).each do |article, art|
  item_id        = art["item_id"].to_i
  url            = art["resolved_url"]
  title          = art["resolved_title"]
  slug           = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  date           = art["time_added"]
  date           = Time.at(date.to_i).utc.to_datetime
  published_date = date.strftime("%Y-%m-%d %T %z")
  year           = date.strftime("%Y")
  month          = date.strftime("%m")
  day            = date.strftime("%d")

  logger.info "Processing #{item_id} - #{title}"
  val = <<-eos
---
title: "#{title}"
layout: post
date: #{published_date}
external-url: #{url}
---
  eos

  post_directory = "#{Dir.pwd}/_posts/#{year}/#{month}"
  filename = "#{Dir.pwd}/_posts/#{year}/#{month}/#{year}-#{month}-#{day}-#{item_id}-#{slug}.md"
  logger.info "post_directory = #{post_directory}"
  logger.info "filename       = #{filename}"
  Dir.mkdir(post_directory) unless Dir.exists?(post_directory)
  File.open(filename, "wb") do |file|
    file.write(val)
  end
  archive_item(item_id)
end

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
require 'stringio'

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
articles = PocketApi.retrieve({:tag => "blog"})

parsed = articles.inject({}) do |acc, item|
  article = item[1]

  item_id = article["item_id"].to_i
  title   = article["resolved_title"]

  excerpt = article["excerpt"]

  date  = article["time_added"].to_i
  date  = Time.at(date).utc.to_datetime

  logger.info "Processing #{item_id} - #{title} - #{date}"

  year  = date.strftime("%Y")
  month = date.strftime("%m")
  day   = date.strftime("%d")

  value = {
    item_id: item_id,
    url:     article["resolved_url"],
    title:   title,
    excerpt: excerpt,
    date:    date.strftime("%Y-%m-%d %T %z"),
    year:    date.strftime("%Y"),
    month:   date.strftime("%m"),
    day:     date.strftime("%d")
  }

  full_day = date.strftime("%Y-%m-%d")
  acc[full_day] = [] unless acc[full_day]
  acc[full_day] << value
  acc
end

parsed.each do |date, item|
  io = StringIO.new

  io.write <<-eos
---
title: "Links for #{date}”
layout: post
date: #{date}
---

eos
  item.each do |article|
    io.write "* [#{article[:title]}](#{article[:url]})\r\n"
    logger.info "Archiving #{article[:item_id]}"
    archive_item(article[:item_id])
  end

  year, month, day = date.split("-")
  post_directory = "#{Dir.pwd}/_posts/#{year}/#{month}"
  filename = "#{post_directory}/#{year}-#{month}-#{day}-links.md"

  logger.info "post_directory = #{post_directory}"
  logger.info "filename       = #{filename}"
  Dir.mkdir(post_directory) unless Dir.exists?(post_directory)
  File.open(filename, "wb") do |file|
    file.write(io.string)
  end
end

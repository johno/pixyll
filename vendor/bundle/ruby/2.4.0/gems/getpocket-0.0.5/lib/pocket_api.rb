require 'httparty'
require 'cgi'
require 'multi_json'
require "pocket_api/version"
require "pocket_api/connection"

module PocketApi
  class <<self
    attr_accessor :client_key
    attr_accessor :access_token

    def configure(credentials={})
      @client_key   = credentials[:client_key]
      @access_token = credentials[:access_token]
    end
    
    # Retrieve API
    # Options:
    # * state
    #   unread = only return unread items (default)
    #   archive = only return archived items
    #   all = return both unread and archived items
    # * favorite
    #   0 = only return un-favorited items
    #   1 = only return favorited items
    # * tag
    #   tag_name = only return items tagged with tag_name
    #   _untagged_ = only return untagged items
    # * contentType
    #   article = only return articles
    #   video = only return videos or articles with embedded videos
    #   image = only return images
    # * sort
    #   newest = return items in order of newest to oldest
    #   oldest = return items in order of oldest to newest
    #   title = return items in order of title alphabetically
    #   site = return items in order of url alphabetically
    # * detailType
    #   simple = only return the titles and urls of each item
    #   complete = return all data about each item, including tags, images, authors, videos and more
    # * search - search query
    # * domain - search within a domain
    # * since - timestamp of modifed items after a date
    # * count - limit of items to return
    # * offset - Used only with count; start returning from offset position of results
    def retrieve(options={})
      response = request(:get, "/v3/get", {:body => options})
      response["list"]
    end

    # Add API
    # Options:
    # * title 
    # * tags - comma-seperated list of tags
    # * tweet_id - Twitter tweet_id
    def add(url, options={})
      request(:post, '/v3/add', :body => {:url => url}.merge(options))
    end
    
    # Modify API
    # Actions:
    # * add
    # * archive
    # * readd - re-add
    # * favorite
    # * unfavorite
    # * delete
    # * tags_add 
    # * tags_remove
    # * tags_replace
    # * tags_clear
    # * tags_rename
    def modify(action, options={})
      request(:post, '/v3/send', :body => {:action => action}.merge(options))
    end
    
    
    def request(method, *arguments)
      arguments[1] ||= {}
      arguments[1][:body] ||= {}
      arguments[1][:body] = MultiJson.dump(arguments[1][:body].merge({:consumer_key => @client_key, :access_token => @access_token}))
      response = Connection.__send__(method.downcase.to_sym, *arguments)
      raise response.headers["X-Error"] if response.headers["X-Error"]

      response.parsed_response
    end
    
  end # <<self
end

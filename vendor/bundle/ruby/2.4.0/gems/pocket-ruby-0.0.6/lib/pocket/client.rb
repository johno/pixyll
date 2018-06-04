module Pocket
  # Wrapper for the Pocket REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {TODO:doc_URL the Pocket API Documentation}.
  # @see TODO:doc_url
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include Pocket::Client::Add
    include Pocket::Client::Modify
    include Pocket::Client::Retrieve
  end
end

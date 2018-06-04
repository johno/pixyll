require File.expand_path('../connection', __FILE__)
require File.expand_path('../oauth', __FILE__)

module Pocket
  # @private
  class API
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = Pocket.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Connection
    include OAuth
  end
end

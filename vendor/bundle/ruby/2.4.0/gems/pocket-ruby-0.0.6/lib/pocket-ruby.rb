require File.expand_path('../pocket/error', __FILE__)
require File.expand_path('../pocket/configuration', __FILE__)
require File.expand_path('../pocket/api', __FILE__)
require File.expand_path('../pocket/client', __FILE__)

module Pocket
  extend Configuration

  # Alias for Pocket::Client.new
  #
  # @return [Pocket::Client]
  def self.client(options={})
    Pocket::Client.new(options)
  end

  # Delegate to Pocket::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Pocket::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end

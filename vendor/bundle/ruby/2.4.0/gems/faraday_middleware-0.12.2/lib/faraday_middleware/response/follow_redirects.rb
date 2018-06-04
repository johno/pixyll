require 'faraday'
require 'set'

module FaradayMiddleware
  # Public: Exception thrown when the maximum amount of requests is exceeded.
  class RedirectLimitReached < Faraday::Error::ClientError
    attr_reader :response

    def initialize(response)
      super "too many redirects; last one to: #{response['location']}"
      @response = response
    end
  end

  # Public: Follow HTTP 301, 302, 303, 307, and 308 redirects.
  #
  # For HTTP 301, 302, and 303, the original GET, POST, PUT, DELETE, or PATCH
  # request gets converted into a GET. With `:standards_compliant => true`,
  # however, the HTTP method after 301/302 remains unchanged. This allows you
  # to opt into HTTP/1.1 compliance and act unlike the major web browsers.
  #
  # This middleware currently only works with synchronous requests; i.e. it
  # doesn't support parallelism.
  #
  # If you wish to persist cookies across redirects, you could use
  # the faraday-cookie_jar gem:
  #
  #   Faraday.new(:url => url) do |faraday|
  #     faraday.use FaradayMiddleware::FollowRedirects
  #     faraday.use :cookie_jar
  #     faraday.adapter Faraday.default_adapter
  #   end
  class FollowRedirects < Faraday::Middleware
    # HTTP methods for which 30x redirects can be followed
    ALLOWED_METHODS = Set.new [:head, :options, :get, :post, :put, :patch, :delete]
    # HTTP redirect status codes that this middleware implements
    REDIRECT_CODES  = Set.new [301, 302, 303, 307, 308]
    # Keys in env hash which will get cleared between requests
    ENV_TO_CLEAR    = Set.new [:status, :response, :response_headers]

    # Default value for max redirects followed
    FOLLOW_LIMIT = 3

    # Regex that matches characters that need to be escaped in URLs, sans
    # the "%" character which we assume already represents an escaped sequence.
    URI_UNSAFE = /[^\-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]%]/

    # Public: Initialize the middleware.
    #
    # options - An options Hash (default: {}):
    #           :limit               - A Numeric redirect limit (default: 3)
    #           :standards_compliant - A Boolean indicating whether to respect
    #                                  the HTTP spec when following 301/302
    #                                  (default: false)
    #           :callback            - A callable that will be called on redirects
    #                                  with the old and new envs
    def initialize(app, options = {})
      super(app)
      @options = options

      @convert_to_get = Set.new [303]
      @convert_to_get << 301 << 302 unless standards_compliant?
    end

    def call(env)
      perform_with_redirection(env, follow_limit)
    end

    private

    def convert_to_get?(response)
      ![:head, :options].include?(response.env[:method]) &&
        @convert_to_get.include?(response.status)
    end

    def perform_with_redirection(env, follows)
      request_body = env[:body]
      response = @app.call(env)

      response.on_complete do |response_env|
        if follow_redirect?(response_env, response)
          raise RedirectLimitReached, response if follows.zero?
          new_request_env = update_env(response_env.dup, request_body, response)
          callback.call(response_env, new_request_env) if callback
          response = perform_with_redirection(new_request_env, follows - 1)
        end
      end
      response
    end

    def update_env(env, request_body, response)
      env[:url] += safe_escape(response['location'] || '')

      if convert_to_get?(response)
        env[:method] = :get
        env[:body] = nil
      else
        env[:body] = request_body
      end

      ENV_TO_CLEAR.each {|key| env.delete key }

      env
    end

    def follow_redirect?(env, response)
      ALLOWED_METHODS.include? env[:method] and
        REDIRECT_CODES.include? response.status
    end

    def follow_limit
      @options.fetch(:limit, FOLLOW_LIMIT)
    end

    def standards_compliant?
      @options.fetch(:standards_compliant, false)
    end

    def callback
      @options[:callback]
    end

    # Internal: escapes unsafe characters from an URL which might be a path
    # component only or a fully qualified URI so that it can be joined onto an
    # URI:HTTP using the `+` operator. Doesn't escape "%" characters so to not
    # risk double-escaping.
    def safe_escape(uri)
      uri = uri.split('#')[0] # we want to remove the fragment if present
      uri.to_s.gsub(URI_UNSAFE) { |match|
        '%' + match.unpack('H2' * match.bytesize).join('%').upcase
      }
    end
  end
end

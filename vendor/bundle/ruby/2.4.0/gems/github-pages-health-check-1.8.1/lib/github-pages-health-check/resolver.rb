# frozen_string_literal: true

module GitHubPages
  module HealthCheck
    class Resolver
      DEFAULT_RESOLVER_OPTIONS = {
        :retry_times => 2,
        :query_timeout => 5,
        :dnssec => false
      }.freeze

      PREFERS_AUTHORITATIVE_ANSWER = [
        Dnsruby::Types::A,
        Dnsruby::Types::CAA,
        Dnsruby::Types::MX
      ].freeze

      class << self
        def default_resolver
          @default_resolver ||= Dnsruby::Resolver.new(DEFAULT_RESOLVER_OPTIONS)
        end
      end

      attr_reader :domain

      def initialize(domain)
        @domain = domain
      end

      # rubocop:disable Metrics/AbcSize
      def query(type)
        if PREFERS_AUTHORITATIVE_ANSWER.include?(type)
          answer = authoritative_resolver.query(domain, type).answer
          return answer unless answer.empty?
        end

        self.class.default_resolver.query(domain, type).answer
      rescue Dnsruby::ResolvTimeout, Dnsruby::ResolvError
        self.class.default_resolver.query(domain, type).answer
      end
      # rubocop:enable Metrics/AbcSize

      private

      def authoritative_resolver
        return self.class.default_resolver if nameservers.nil? || nameservers.empty?

        Dnsruby::Resolver.new(DEFAULT_RESOLVER_OPTIONS.merge(:nameservers => nameservers))
      end

      def nameservers
        @nameservers ||= begin
          self.class.default_resolver.query(domain, Dnsruby::Types::NS).answer.map do |rr|
            next rr.nsdname.to_s if rr.type == Dnsruby::Types::NS
          end.compact
        end
      end
    end
  end
end

# frozen_string_literal: true

require "jekyll"
require "gemoji"
require "html/pipeline"

module Jekyll
  class Emoji
    GITHUB_DOT_COM_ASSET_HOST_URL = "https://assets-cdn.github.com".freeze
    ASSET_PATH = "/images/icons/".freeze
    BODY_START_TAG = "<body".freeze

    class << self
      def emojify(doc)
        return unless doc.output =~ HTML::Pipeline::EmojiFilter.emoji_pattern
        doc.output = if doc.output.include? BODY_START_TAG
                       replace_document_body(doc)
                     else
                       src = emoji_src(doc.site.config)
                       filter_with_emoji(src).call(doc.output)[:output].to_s
                     end
      end

      # Public: Create or fetch the filter for the given {{src}} asset root.
      #
      # src - the asset root URL (e.g. https://assets-cdn.github.com/images/icons/)
      #
      # Returns an HTML::Pipeline instance for the given asset root.
      def filter_with_emoji(src)
        filters[src] ||= HTML::Pipeline.new([
          HTML::Pipeline::EmojiFilter,
        ], { :asset_root => src, :img_attrs => { :align => nil } })
      end

      # Public: Filters hash where the key is the asset root source.
      # Effectively a cache.
      def filters
        @filters ||= {}
      end

      # Public: Calculate the asset root source for the given config.
      # The custom emoji asset root can be defined in the config as
      # emoji.src, and must be a valid URL (i.e. it must include a
      # protocol and valid domain)
      #
      # config - the hash-like configuration of the document's site
      #
      # Returns a full URL to use as the asset root URL. Defaults to the root
      # URL for assets provided by an ASSET_HOST_URL environment variable,
      # otherwise the root URL for emoji assets at assets-cdn.github.com.
      def emoji_src(config = {})
        if config.key?("emoji") && config["emoji"].key?("src")
          config["emoji"]["src"]
        else
          default_asset_root
        end
      end

      # Public: Defines the conditions for a document to be emojiable.
      #
      # doc - the Jekyll::Document or Jekyll::Page
      #
      # Returns true if the doc is written & is HTML.
      def emojiable?(doc)
        (doc.is_a?(Jekyll::Page) || doc.write?) &&
          doc.output_ext == ".html" || (doc.permalink && doc.permalink.end_with?("/"))
      end

      private

      def default_asset_root
        if !ENV["ASSET_HOST_URL"].to_s.empty?
          # Ensure that any trailing "/" is trimmed
          asset_host_url = ENV["ASSET_HOST_URL"].chomp("/")
          "#{asset_host_url}#{ASSET_PATH}"
        else
          "#{GITHUB_DOT_COM_ASSET_HOST_URL}#{ASSET_PATH}"
        end
      end

      def replace_document_body(doc)
        src           = emoji_src(doc.site.config)
        parsed_doc    = Nokogiri::HTML::Document.parse(doc.output)
        body          = parsed_doc.at_css("body")
        body.children = filter_with_emoji(src).call(body.inner_html)[:output].to_s
        parsed_doc.to_html
      end
    end
  end
end

Jekyll::Hooks.register %i[pages documents], :post_render do |doc|
  Jekyll::Emoji.emojify(doc) if Jekyll::Emoji.emojiable?(doc)
end

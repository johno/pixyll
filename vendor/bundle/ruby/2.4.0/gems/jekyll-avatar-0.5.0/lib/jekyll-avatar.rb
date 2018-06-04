# frozen_string_literal: true

require "zlib"

module Jekyll
  class Avatar < Liquid::Tag
    include Jekyll::LiquidExtensions

    SERVERS      = 4
    DEFAULT_SIZE = 40
    API_VERSION  = 3

    def initialize(_tag_name, text, _tokens)
      super
      @text = text
    end

    def render(context)
      @context = context
      @text    = Liquid::Template.parse(@text).render(@context)
      attrs    = attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
      "<img #{attrs} />"
    end

    private

    def attributes
      {
        :class                => classes,
        :src                  => url,
        :alt                  => username,
        :srcset               => srcset,
        :width                => size,
        :height               => size,
        "data-proofer-ignore" => true,
      }
    end

    def username
      matches = @text.match(%r!\buser=([\w\.]+)\b!)
      if matches
        lookup_variable(@context, matches[1])
      else
        @text.split(" ").first.sub("@", "")
      end
    end

    def size
      matches = @text.match(%r!\bsize=(\d+)\b!i)
      matches ? matches[1].to_i : DEFAULT_SIZE
    end

    def path(scale = 1)
      "#{username}?v=#{API_VERSION}&s=#{size * scale}"
    end

    def server_number
      Zlib.crc32(path) % SERVERS
    end

    def host
      if ENV["PAGES_AVATARS_URL"].to_s.empty?
        "https://avatars#{server_number}.githubusercontent.com"
      else
        ENV["PAGES_AVATARS_URL"]
      end
    end

    def url(scale = 1)
      uri = Addressable::URI.parse host
      uri.path << "/" unless uri.path.end_with?("/")
      uri.join path(scale)
    end

    def srcset
      (1..4).map { |scale| "#{url(scale)} #{scale}x" }.join(", ")
    end

    # See http://primercss.io/avatars/#small-avatars
    def classes
      size < 48 ? "avatar avatar-small" : "avatar"
    end
  end
end

Liquid::Template.register_tag("avatar", Jekyll::Avatar)

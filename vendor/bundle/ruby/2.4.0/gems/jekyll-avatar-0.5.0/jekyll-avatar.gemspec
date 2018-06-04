# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-avatar/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-avatar"
  spec.version       = Jekyll::Avatar::VERSION
  spec.authors       = ["Ben Balter"]
  spec.email         = ["ben.balter@github.com"]

  spec.summary       = "A Jekyll plugin for rendering GitHub avatars"
  spec.homepage      = "https://github.com/benbalter/jekyll-avatar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r!^(test|spec|features)/!)
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
end

# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-seo-tag/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-seo-tag"
  spec.version       = Jekyll::SeoTag::VERSION
  spec.authors       = ["Ben Balter"]
  spec.email         = ["ben.balter@github.com"]
  spec.summary       = "A Jekyll plugin to add metadata tags for search engines and social networks to better index and display your site's content."
  spec.homepage      = "https://github.com/benbalter/jekyll-seo-tag"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|spec|features)/!) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r!^exe/!) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", "~> 3.3"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "html-proofer", "~> 3.7"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rubocop", "~> 0.5"
end

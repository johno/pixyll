# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/unicode/display_width"

Gem::Specification.new do |s|
  s.name        = "unicode-display_width"
  s.version     = Unicode::DisplayWidth::VERSION
  s.authors     = ["Jan Lelis"]
  s.email       = "mail@janlelis.de"
  s.homepage    = "http://github.com/janlelis/unicode-display_width"
  s.summary = "Determines the monospace display width of a string in Ruby."
  s.description =  "[Unicode #{Unicode::DisplayWidth::UNICODE_VERSION}] Determines the monospace display width of a string using EastAsianWidth.txt, Unicode general category, and other data."
  s.files = Dir.glob(%w[{lib,spec}/**/*.rb [A-Z]*.{txt,rdoc} data/display_width.marshal.gz]) + %w{Rakefile unicode-display_width.gemspec}
  s.extra_rdoc_files = ["README.md", "MIT-LICENSE.txt", "CHANGELOG.md"]
  s.license = 'MIT'
  s.required_ruby_version = '>= 1.9.3'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'rake', '~> 10.4'
end

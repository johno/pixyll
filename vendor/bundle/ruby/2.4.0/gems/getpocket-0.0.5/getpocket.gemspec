# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pocket_api/version'

Gem::Specification.new do |spec|
  spec.name          = "getpocket"
  spec.version       = PocketApi::VERSION
  spec.authors       = ["Alex Chee"]
  spec.email         = ["alexchee11@gmail.com"]
  spec.description   = %q{API Wrapper for Pocket (was Read It Later)}
  spec.summary       = %q{API Wrapper for Pocket (was Read It Later)}
  spec.homepage      = "https://github.com/alexchee/pocket_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_dependency "httparty"
end

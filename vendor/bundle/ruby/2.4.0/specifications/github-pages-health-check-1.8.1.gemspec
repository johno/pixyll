# -*- encoding: utf-8 -*-
# stub: github-pages-health-check 1.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "github-pages-health-check".freeze
  s.version = "1.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["GitHub, Inc.".freeze]
  s.date = "2018-05-07"
  s.description = "Checks your GitHub Pages site for commons DNS configuration issues.".freeze
  s.email = "support@github.com".freeze
  s.homepage = "https://github.com/github/github-pages-health-check".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Checks your GitHub Pages site for commons DNS configuration issues".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_runtime_dependency(%q<dnsruby>.freeze, ["~> 1.60"])
      s.add_runtime_dependency(%q<octokit>.freeze, ["~> 4.0"])
      s.add_runtime_dependency(%q<public_suffix>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<dotenv>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<gem-release>.freeze, ["~> 0.7"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.10"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.52"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.21"])
    else
      s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_dependency(%q<dnsruby>.freeze, ["~> 1.60"])
      s.add_dependency(%q<octokit>.freeze, ["~> 4.0"])
      s.add_dependency(%q<public_suffix>.freeze, ["~> 2.0"])
      s.add_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
      s.add_dependency(%q<dotenv>.freeze, ["~> 1.0"])
      s.add_dependency(%q<gem-release>.freeze, ["~> 0.7"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.52"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.21"])
    end
  else
    s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
    s.add_dependency(%q<dnsruby>.freeze, ["~> 1.60"])
    s.add_dependency(%q<octokit>.freeze, ["~> 4.0"])
    s.add_dependency(%q<public_suffix>.freeze, ["~> 2.0"])
    s.add_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
    s.add_dependency(%q<dotenv>.freeze, ["~> 1.0"])
    s.add_dependency(%q<gem-release>.freeze, ["~> 0.7"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.52"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.21"])
  end
end

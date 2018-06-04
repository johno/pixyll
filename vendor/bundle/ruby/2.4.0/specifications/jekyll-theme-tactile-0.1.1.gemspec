# -*- encoding: utf-8 -*-
# stub: jekyll-theme-tactile 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-theme-tactile".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jason Long".freeze, "GitHub, Inc.".freeze]
  s.date = "2018-04-11"
  s.email = ["opensource+jekyll-theme-tactile@github.com".freeze]
  s.homepage = "https://github.com/pages-themes/tactile".freeze
  s.licenses = ["CC0-1.0".freeze]
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Tactile is a Jekyll theme for GitHub Pages".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 3.5"])
      s.add_runtime_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<html-proofer>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.50"])
      s.add_development_dependency(%q<w3c_validators>.freeze, ["~> 1.3"])
    else
      s.add_dependency(%q<jekyll>.freeze, ["~> 3.5"])
      s.add_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.0"])
      s.add_dependency(%q<html-proofer>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.50"])
      s.add_dependency(%q<w3c_validators>.freeze, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<jekyll>.freeze, ["~> 3.5"])
    s.add_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.0"])
    s.add_dependency(%q<html-proofer>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.50"])
    s.add_dependency(%q<w3c_validators>.freeze, ["~> 1.3"])
  end
end

# -*- encoding: utf-8 -*-
# stub: jekyll-commonmark 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-commonmark".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pat Hawks".freeze]
  s.date = "2018-03-30"
  s.email = "pat@pathawks.com".freeze
  s.homepage = "https://github.com/pathawks/jekyll-commonmark".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "CommonMark generator for Jekyll".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<commonmarker>.freeze, ["~> 0.14"])
      s.add_runtime_dependency(%q<jekyll>.freeze, ["< 4.0", ">= 3.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.52.0"])
    else
      s.add_dependency(%q<commonmarker>.freeze, ["~> 0.14"])
      s.add_dependency(%q<jekyll>.freeze, ["< 4.0", ">= 3.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.52.0"])
    end
  else
    s.add_dependency(%q<commonmarker>.freeze, ["~> 0.14"])
    s.add_dependency(%q<jekyll>.freeze, ["< 4.0", ">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.52.0"])
  end
end

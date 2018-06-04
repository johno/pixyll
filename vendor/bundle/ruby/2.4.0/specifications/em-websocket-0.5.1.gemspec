# -*- encoding: utf-8 -*-
# stub: em-websocket 0.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "em-websocket".freeze
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ilya Grigorik".freeze, "Martyn Loughran".freeze]
  s.date = "2014-04-23"
  s.description = "EventMachine based WebSocket server".freeze
  s.email = ["ilya@igvita.com".freeze, "me@mloughran.com".freeze]
  s.homepage = "http://github.com/igrigorik/em-websocket".freeze
  s.rubyforge_project = "em-websocket".freeze
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "EventMachine based WebSocket server".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>.freeze, [">= 0.12.9"])
      s.add_runtime_dependency(%q<http_parser.rb>.freeze, ["~> 0.6.0"])
    else
      s.add_dependency(%q<eventmachine>.freeze, [">= 0.12.9"])
      s.add_dependency(%q<http_parser.rb>.freeze, ["~> 0.6.0"])
    end
  else
    s.add_dependency(%q<eventmachine>.freeze, [">= 0.12.9"])
    s.add_dependency(%q<http_parser.rb>.freeze, ["~> 0.6.0"])
  end
end

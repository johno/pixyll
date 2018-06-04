# -*- encoding: utf-8 -*-
# stub: ethon 0.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ethon".freeze
  s.version = "0.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hans Hasselberg".freeze]
  s.date = "2017-10-26"
  s.description = "Very lightweight libcurl wrapper.".freeze
  s.email = ["me@hans.io".freeze]
  s.homepage = "https://github.com/typhoeus/ethon".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Libcurl wrapper.".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>.freeze, [">= 1.3.0"])
    else
      s.add_dependency(%q<ffi>.freeze, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<ffi>.freeze, [">= 1.3.0"])
  end
end

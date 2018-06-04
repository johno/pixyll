# -*- encoding: utf-8 -*-
# stub: dnsruby 1.60.2 ruby lib

Gem::Specification.new do |s|
  s.name = "dnsruby".freeze
  s.version = "1.60.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Dalitz".freeze]
  s.date = "2017-08-10"
  s.description = "Dnsruby is a pure Ruby DNS client library which implements a\nstub resolver. It aims to comply with all DNS RFCs, including\nDNSSEC NSEC3 support.".freeze
  s.email = "alex@caerkettontech.com".freeze
  s.extra_rdoc_files = ["DNSSEC".freeze, "EXAMPLES".freeze, "README.md".freeze, "EVENTMACHINE".freeze]
  s.files = ["DNSSEC".freeze, "EVENTMACHINE".freeze, "EXAMPLES".freeze, "README.md".freeze]
  s.homepage = "https://github.com/alexdalitz/dnsruby".freeze
  s.licenses = ["Apache License, Version 2.0".freeze]
  s.post_install_message = "Installing dnsruby...\n  For issues and source code: https://github.com/alexdalitz/dnsruby\n  For general discussion (please tell us how you use dnsruby): https://groups.google.com/forum/#!forum/dnsruby".freeze
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Ruby DNS(SEC) implementation".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.10"])
      s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 10.3.2", "~> 10"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.4"])
      s.add_development_dependency(%q<rubydns>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<nio4r>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<minitest-display>.freeze, [">= 0.3.0"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.7"])
    else
      s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
      s.add_dependency(%q<pry-byebug>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rake>.freeze, [">= 10.3.2", "~> 10"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.4"])
      s.add_dependency(%q<rubydns>.freeze, ["~> 1.0"])
      s.add_dependency(%q<nio4r>.freeze, ["~> 1.1"])
      s.add_dependency(%q<minitest-display>.freeze, [">= 0.3.0"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.7"])
    end
  else
    s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
    s.add_dependency(%q<pry-byebug>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rake>.freeze, [">= 10.3.2", "~> 10"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.4"])
    s.add_dependency(%q<rubydns>.freeze, ["~> 1.0"])
    s.add_dependency(%q<nio4r>.freeze, ["~> 1.1"])
    s.add_dependency(%q<minitest-display>.freeze, [">= 0.3.0"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.7"])
  end
end

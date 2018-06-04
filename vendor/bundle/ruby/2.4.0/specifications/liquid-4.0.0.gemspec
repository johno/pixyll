# -*- encoding: utf-8 -*-
# stub: liquid 4.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "liquid".freeze
  s.version = "4.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tobias L\u00FCtke".freeze]
  s.date = "2016-12-14"
  s.email = ["tobi@leetsoft.com".freeze]
  s.extra_rdoc_files = ["History.md".freeze, "README.md".freeze]
  s.files = ["History.md".freeze, "README.md".freeze]
  s.homepage = "http://www.liquidmarkup.org".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "A secure, non-evaling end user template engine with aesthetic markup.".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 11.3"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 11.3"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 11.3"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
  end
end

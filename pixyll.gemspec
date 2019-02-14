# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "pixyll"
  spec.version       = "3.0.0"
  spec.authors       = ["John Otander"]
  spec.email         = ["johnotander@gmail.com"]

  spec.summary       = %q{A simple, beautiful Jekyll theme that's mobile first.}
  spec.homepage      = "http://pixyll.com"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^((_includes|_layouts|_sass|css)/|Rakefile|(LICENSE|README)((\.(txt|md|markdown)|$)))}i)
  end

  spec.add_runtime_dependency "jekyll", "~> 3.3"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"
  spec.add_development_dependency "bundler", ">= 1.12"
  spec.add_development_dependency "rake", "~> 10.0"

end

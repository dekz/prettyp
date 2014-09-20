lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prettyp/version'

Gem::Specification.new do |spec|
  spec.name          = "prettyp"
  spec.version       = Prettyp::VERSION
  spec.authors       = ["Jacob Evans"]
  spec.email         = ["jacob@dekz.net"]
  spec.summary       = %q{Pretty Print language formatter}
  spec.description   = %q{Pretty Print using popular tools and many languages}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "github-linguist", "~> 3.1"
  spec.add_dependency "thor"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

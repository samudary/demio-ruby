
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "demio/version"

Gem::Specification.new do |spec|
  spec.name          = "demio-ruby"
  spec.version       = Demio::VERSION
  spec.authors       = ["Robyn-Dale Samuda"]
  spec.email         = ["robyn@yuraki.com"]

  spec.summary       = "A wrapper for interacting with the Demio API"
  spec.description   = "Supports all methods for interacting with the Demio API as described at https://publicdemioapi.docs.apiary.io/"
  spec.homepage      = "https://github.com/samudary/demio-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.required_ruby_version = '>= 2.1'

  spec.add_development_dependency "bundler", "~> 2.2.23"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "rspec", "~> 3.10.0"
  spec.add_development_dependency "rubocop", "~> 1.18.3"
  spec.add_development_dependency "pry", "~> 0.14.1"
  spec.add_development_dependency "webmock", "~> 3.13.0"
end

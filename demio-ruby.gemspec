
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "demio/version"

Gem::Specification.new do |spec|
  spec.name          = "demio-ruby"
  spec.version       = Demio::VERSION
  spec.authors       = ["Robyn-Dale Samuda"]
  spec.email         = ["robyn@yuraki.com"]

  spec.summary       = "A wrapper for interacting with the Demio API"
  spec.description   = "A wrapper for interacting with the Demio API"
  spec.homepage      = "https://github.com/samudary/demio-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = Dir["lib/**/*.rb"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.required_ruby_version = '>= 2.1'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.57.1"
  spec.add_development_dependency "pry", "~> 0.10.3"
  spec.add_development_dependency "webmock", "~> 3.4"
end

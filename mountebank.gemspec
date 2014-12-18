# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mountebank/version'

Gem::Specification.new do |spec|
  spec.name          = "mountebank"
  spec.version       = Mountebank::VERSION
  spec.authors       = ["Michael Cheng"]
  spec.email         = ["mcheng.work@gmail.com"]
  spec.summary       = %q{Ruby GEM to manage a Mountebank Test Server}
  spec.description   = %q{A simple Ruby library that lets you manage your Mountebank test server.}
  spec.homepage      = "https://github.com/CoderKungfu/mountebank-gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~>0.9.0"
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "dotenv", "~> 1.0.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end

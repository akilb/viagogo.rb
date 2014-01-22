# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'viagogo/version'

Gem::Specification.new do |spec|
  spec.name          = "viagogo"
  spec.version       = Viagogo::VERSION
  spec.authors       = ["Akil Burgess"]
  spec.email         = ["akilburgess@gmail.com"]
  spec.summary       = %q{Ruby toolkit for working with the viagogo API}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.8.9"
  spec.add_dependency "faraday_middleware", "~> 0.9.0"
  spec.add_dependency "simple_oauth", "~> 0.2.0"
  spec.add_dependency "json", "~> 1.8.1"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "timecop"
end

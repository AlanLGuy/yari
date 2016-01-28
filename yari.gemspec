# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yari/version'

Gem::Specification.new do |spec|
  spec.name          = "yari"
  spec.version       = Yari::VERSION
  spec.authors       = ["Alan Guy"]
  spec.email         = ["Alan.L.Guy@gmail.com"]
  spec.summary       = %q{Yet Another Rspec Implementation}
  spec.description   = %q{An extension for Rspec that merges the advantages of using Gherkin as a communication tool, without the need for Cucumber}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rspec', '>= 3.0'
  spec.add_runtime_dependency 'gherkin', '>= 3.0.0'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'coveralls', '~> 0.7'

end

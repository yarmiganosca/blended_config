# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blended_config/version'

Gem::Specification.new do |spec|
  spec.name          = "blended_config"
  spec.version       = BlendedConfig::VERSION
  spec.authors       = ["Chris Hoffman"]
  spec.email         = ["yarmiganosca@gmail.com"]

  spec.summary       = "Decide how your config objects choose between files, env_vars & default values."
  spec.description   = "Decide how your config objects choose between files, env_vars & default values."
  spec.homepage      = "https://github.com/yarmiganosca/blended_config"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'toml'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

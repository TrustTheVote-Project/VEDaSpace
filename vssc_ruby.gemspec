# coding: utf-8
$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require "vssc/version"

Gem::Specification.new do |spec|
  spec.name          = "vssc-ruby"
  spec.version       = VSSC::VERSION
  spec.authors       = ["OSET", "Alex Mekelburg"]
  spec.email         = ["alex.mekelburg@gmail.com"]
  spec.summary   = %q{Ruby classes based on VSSC election data format}
  spec.description   = %q{Ruby classes based on VSSC election data format}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6"

  spec.add_dependency "activemodel", "~> 4"
  spec.add_dependency "activesupport", "~> 4"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 3.1"
end
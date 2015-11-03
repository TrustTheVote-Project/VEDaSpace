# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

require "vedaspace/version"

Gem::Specification.new do |spec|
  spec.name          = "vedaspace"
  spec.version       = Vedaspace::VERSION
  spec.authors       = ["OSET", "Alex Mekelburg"]
  spec.email         = ["alex.mekelburg@gmail.com"]
  spec.summary   = %q{Ruby classes based on Nist ERR election data format}
  spec.description   = %q{Ruby classes based on Nist ERR election data format http://www.nist.gov/itl/vote/ieee-swg-p1622.cfm}
  spec.license       = "OSET Foundation"

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
  spec.add_development_dependency "equivalent-xml", "~> 0.5.1"
end
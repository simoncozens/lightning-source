# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lightning-source/version'

Gem::Specification.new do |spec|
  spec.name          = "lightning-source"
  spec.version       = Lightning::Source::VERSION
  spec.authors       = ["Simon Cozens"]
  spec.email         = ["simon@simon-cozens.org"]
  spec.description   = "Scrape the LSI publisher's web site"
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "mechanize"
end

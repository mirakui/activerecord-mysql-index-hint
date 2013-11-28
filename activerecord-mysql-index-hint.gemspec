# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/mysql/index/hint/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-mysql-index-hint"
  spec.version       = Activerecord::Mysql::Index::Hint::VERSION
  spec.authors       = ["Issei Naruta"]
  spec.email         = ["naruta@cookpad.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '>= 3.0.0'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'rspec'
end

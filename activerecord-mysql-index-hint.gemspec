# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord-mysql-index-hint/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-mysql-index-hint"
  spec.version       = ActiveRecordMysqlIndexHint::VERSION
  spec.authors       = ["Issei Naruta"]
  spec.email         = ["naruta@cookpad.com"]
  spec.description   = %q{MySQL index hint support for ActiveRecord}
  spec.summary       = %q{MySQL index hint support for ActiveRecord}
  spec.homepage      = "https://github.com/mirakui/activerecord-mysql-index-hint"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord', '>= 3.1'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'mysql2', '~> 0.4.1'
end

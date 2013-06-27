# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pagoid/version'

Gem::Specification.new do |spec|
  spec.name          = "pagoid"
  spec.version       = Pagoid::VERSION
  spec.authors       = ["Jon Phenow"]
  spec.email         = ["j.phenow@gmail.com"]
  spec.description   = %q{Standardize paging abstraction}
  spec.summary       = %q{Easy way to paginate with will_paginate or kaminari backends}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "kaminari"
  spec.add_development_dependency "will_paginate"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"
end

# -*- encoding: utf-8 -*-
require File.expand_path('../lib/motion-pixate-layout/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Lind"]
  gem.email         = ["joe@terriblelabs.com"]
  gem.description   = "A RubyMotion DSL to add subviews that are styled with Pixate"
  gem.summary   = "A RubyMotion DSL to add subviews that are styled with Pixate"
  gem.homepage = 'http://github.com/terriblelabs/motion-pixate-layout'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|lib_spec|features)/})
  gem.name          = "motion-pixate-layout"
  gem.require_paths = ["lib"]
  gem.version       = MotionPixateLayout::Version

  gem.add_development_dependency 'motion-pixate'
  gem.add_development_dependency 'bacon'
  gem.add_development_dependency 'rake'
end

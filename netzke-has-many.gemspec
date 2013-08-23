# encoding: utf-8
require File.expand_path(File.join('..', 'lib', 'netzke', 'has_many', 'version'), __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'netzke-has-many'
  gem.version     = Netzke::HasMany::VERSION
  gem.homepage    = 'https://github.com/bamorim/netzke-has-many'

  gem.author      = "Bernardo Amorim"
  gem.email       = 'contato@bamorim.com'
  gem.description = 'Has Many Grid Editor for Netzke'
  gem.summary     = gem.description

  gem.license     = "MIT"

  gem.add_dependency "netzke-core"
  gem.add_dependency "netzke-basepack"
  gem.add_dependency "activesupport"

  gem.add_development_dependency 'rake'

  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.require_paths = ['lib']
end
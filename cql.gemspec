# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'cql/version'


Gem::Specification.new do |s|
  s.name        = 'cql'
  s.version     = CQL::VERSION
  s.authors     = ['Eric Kessler', 'Jarrod Folino']
  s.description = 'Cucumber Query Language'
  s.summary     = "A gem providing functionality to query a Cucumber test suite."
  s.email       = 'morrow748@gmail.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/enkessler/cql'

  s.platform    = Gem::Platform::RUBY
  s.post_install_message = %{
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

Thank you for installing cql (Cucumber Query Language)

(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

}

  s.add_runtime_dependency 'cuke_modeler'

  s.add_development_dependency 'rake', '>= 0.9'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'racatt'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'relish'


  s.rubygems_version = '>= 1.6.1'
  s.files            = Dir.glob('lib/**/*').reject {|path| path =~ /\.gitignore$/ }
  s.test_files       = Dir.glob('spec/**/*')
  s.rdoc_options     = ['--charset=UTF-8']
  s.require_path     = 'lib'
end

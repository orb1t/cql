source "http://rubygems.org"

gemspec

# cql can play with pretty much any version of these but they all play differently with Ruby
if RUBY_VERSION =~ /^1\.8/
  gem 'cucumber', '< 1.3.0'
  gem 'gherkin', '< 2.12.0'
  gem 'mime-types', '< 2.0.0' # (For the relish gem) Ruby 1.8.x dropped somewhere in the 2.x series
  gem 'rest-client', '< 1.7.0' # (For the relish gem) Ruby 1.8.x dropped on/after this version
  gem 'rake', '< 11.0' # Rake dropped 1.8.x support after this version
elsif RUBY_VERSION =~ /^1\./
  gem 'cucumber', '< 2.0.0'
  gem 'mime-types', '< 3.0.0' # Requires Ruby 2.x on/after this version
  gem 'rest-client', '< 2.0.0' # Requires Ruby 2.x on/after this version
end

if RUBY_VERSION =~ /^1\./
  gem 'tins', '< 1.7' # The 'tins' gem requires Ruby 2.x on/after this version
  gem 'json', '< 2.0' # The 'json' gem drops pre-Ruby 2.x support on/after this version
  gem 'term-ansicolor', '< 1.4' # The 'term-ansicolor' gem requires Ruby 2.x on/after this version
  gem 'unf_ext', '< 0.0.7.3' # Requires Ruby 2.x on/after this version

  if RbConfig::CONFIG['host_os'].downcase =~ /mswin|msys|mingw32/
    gem 'ffi', '< 1.9.15' # The 'ffi' gem, for Windows, requires Ruby 2.x on/after this version
  end
end

gem 'coveralls', :require => false, :group => :development

gem 'cuke_modeler', '~> 1.0'

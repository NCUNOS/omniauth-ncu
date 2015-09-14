# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-ncu/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Kuo"]
  gem.email         = ["me@davy.tw"]
  gem.description   = %q{OmniAuth strategy for NCU OAuth.}
  gem.summary       = %q{OmniAuth strategy for NCU OAuth.}
  gem.homepage      = "https://github.com/ncunos/omniauth-ncu"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-ncu"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::NCU::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  # Nothing lower than omniauth-oauth2 1.1.1
  # http://www.rubysec.com/advisories/CVE-2012-6134/
  gem.add_dependency 'omniauth-oauth2', '>= 1.1.1', '< 2.0'
  gem.add_development_dependency 'rspec', '~> 2.99'
  gem.add_development_dependency 'rack-test', '~> 0.6'
  gem.add_development_dependency 'simplecov', '~> 0.10'
  gem.add_development_dependency 'webmock', '~> 1.21'
end

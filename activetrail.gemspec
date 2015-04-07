# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_trail/version'

Gem::Specification.new do |spec|
  spec.name          = "activetrail"
  spec.version       = ActiveTrail::VERSION
  spec.authors       = ["Celso Fernandes"]
  spec.email         = ["fernandes@zertico.com"]

  spec.summary       = %q{Integration between ActiveAdmin and Trailblazer}
  spec.description   = %q{Provide a cool, and seamless, integration between ActiveAdmin and Trailblazer, so you can use your operations inside ActiveAdmin}
  spec.homepage      = "https://github.com/fernandes/activetrail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "capybara", '~> 2.4'
  spec.add_development_dependency "codeclimate-test-reporter", '~> 0.4'
  spec.add_development_dependency "combustion", "~> 0.5.3"
  spec.add_development_dependency "database_cleaner", "~> 1.4"
  spec.add_development_dependency "devise", '~> 3.4'
  spec.add_development_dependency "factory_girl_rails", '~> 4.5'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "pry", '~> 0.10'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails", "~> 3.0"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "trailblazer", "~> 0.2"
  spec.add_development_dependency "metric_fu"
  spec.add_development_dependency "simplecov"
end

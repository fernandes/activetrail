# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_trail/version'

Gem::Specification.new do |spec|
  spec.name          = "activetrail"
  spec.version       = ActiveTrail::VERSION
  spec.authors       = ["Celso Fernandes"]
  spec.email         = ["fernandes@zertico.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Integration between ActiveAdmin and Trailblazer}
  spec.description   = %q{Provide a cool, and seamless, integration between ActiveAdmin and Trailblazer, so you can you your operations inside ActiveAdmin}
  spec.homepage      = "https://github.com/fernandes/activetrail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end

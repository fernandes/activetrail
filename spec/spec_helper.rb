require "codeclimate-test-reporter"

CodeClimate::TestReporter.configure do |config|
  config.logger.level = Logger::WARN
end

CodeClimate::TestReporter.start

require 'rubygems'
require 'bundler'

require 'combustion'
Combustion.initialize! :all

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_trail'

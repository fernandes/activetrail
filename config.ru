# Combustion stuff
require 'rubygems'
require 'bundler'

require 'combustion'

Combustion.initialize! :all
run Combustion::Application

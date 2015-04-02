require 'simplecov'
require 'metric_fu/metrics/rcov/simplecov_formatter'
SimpleCov.profiles.define 'myprofile' do
  add_filter 'vendor' # Don't include vendored stuff
end

SimpleCov.formatter = SimpleCov::Formatter::MetricFu
# or
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::MetricFu
  ]
SimpleCov.start 'myprofile'

require "codeclimate-test-reporter"

CodeClimate::TestReporter.configure do |config|
  config.logger.level = Logger::WARN
end

CodeClimate::TestReporter.start

require 'rubygems'
require 'bundler'

require 'combustion'
require 'devise'
require 'factory_girl_rails'
Combustion.initialize! :all

require 'trailblazer'
require 'trailblazer/autoloading'
require 'rspec/rails'
require 'database_cleaner'
require File.join(File.dirname(__FILE__), 'internal/app/models', 'book.rb')
require File.join(File.dirname(__FILE__), 'internal/app/admin', 'book.rb')

# load support files
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each {|f| require f}
# load factories
Dir[File.join(File.dirname(__FILE__), 'factories/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end

# Helpers borrowed from
# https://github.com/activeadmin/activeadmin/blob/e5ce49a62751a4a69c3f84058d398ce0fb78eb76/spec/rails_helper.rb
module ActiveAdminIntegrationSpecHelper
  extend self

  def load_defaults!
    ActiveAdmin.unload!
    ActiveAdmin.load!
    ActiveAdmin.register(Book)
    # ActiveAdmin.register(Post){ belongs_to :user, optional: true }
    reload_menus!
  end

  def reload_menus!
    ActiveAdmin.application.namespaces.each{|n| n.reset_menu! }
  end

  # Sometimes we need to reload the routes within
  # the application to test them out
  def reload_routes!
    Rails.application.reload_routes!
  end

  # Helper method to load resources and ensure that Active Admin is
  # setup with the new configurations.
  #
  # Eg:
  #   load_resources do
  #     ActiveAdmin.regiser(Post)
  #   end
  #
  def load_resources
    ActiveAdmin.unload!
    yield
    reload_menus!
    reload_routes!
  end

  # Sets up a describe block where you can render controller
  # actions. Uses the Admin::PostsController as the subject
  # for the describe block
  def describe_with_render(*args, &block)
    describe *args do
      include RSpec::Rails::ControllerExampleGroup
      render_views
      # metadata[:behaviour][:describes] = ActiveAdmin.namespaces[:admin].resources['Post'].controller
      module_eval &block
    end
  end

  def arbre(assigns = {}, helpers = mock_action_view, &block)
    Arbre::Context.new(assigns, helpers, &block)
  end

  def render_arbre_component(assigns = {}, helpers = mock_action_view, &block)
    arbre(assigns, helpers, &block).children.first
  end

  # Setup a describe block which uses capybara and rails integration
  # test methods.
  def describe_with_capybara(*args, &block)
    describe *args do
      include RSpec::Rails::IntegrationExampleGroup
      module_eval &block
    end
  end

  # Returns a fake action view instance to use with our renderers
  def mock_action_view(assigns = {})
    controller = ActionView::TestCase::TestController.new
    ActionView::Base.send :include, ActionView::Helpers
    ActionView::Base.send :include, ActiveAdmin::ViewHelpers
    ActionView::Base.send :include, Rails.application.routes.url_helpers
    ActionView::Base.new(ActionController::Base.view_paths, assigns, controller)
  end
  alias_method :action_view, :mock_action_view

  # A mock resource to register
  class MockResource
  end

  def with_translation(translation)
    I18n.backend.store_translations :en, translation
    yield
  ensure
    I18n.backend.reload!
  end

end

include ActiveAdminIntegrationSpecHelper
require File.join(File.dirname(__FILE__), 'support', 'integration_example_group.rb')

RSpec.configure do |config|
  config.include RSpec::Rails::IntegrationExampleGroup, file_path: /\bspec\/requests\//
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before(:each) do
    @__original_application = ActiveAdmin.application
    application = ActiveAdmin::Application.new
    application.default_namespace = :admin
    ActiveAdmin.application = application
    load_defaults!
    reload_routes!
  end
  config.before(:all) do
    ActiveAdmin.application = @__original_application
  end
end

require "rspec/expectations"

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_trail'

require 'action_dispatch'

module RSpec
  module Rails
    module IntegrationExampleGroup
      extend ActiveSupport::Concern

      include ActionDispatch::Integration::Runner
      include RSpec::Rails::TestUnitAssertionAdapter
      include ActionDispatch::Assertions
      include RSpec::Matchers

      def app
        ::Rails.application
      end

      def last_response
        page
      end

      included do
        before do
          @router = ::Rails.application.routes
        end
      end
    end
  end
end

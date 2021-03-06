# frozen_string_literal: true

require 'spec_helper'

if defined?(Rails)
  require 'action_controller/railtie'

  RSpec.describe 'Rails console', :spec_logger do
    before :all do
      class RailsConsoleTestApp < Rails::Application
        configure_rails_for_test

        config.elastic_apm.disable_send = true
        config.logger = Logger.new(SpecLogger)
      end

      # rubocop:disable Style/ClassAndModuleChildren
      class ::ApplicationController < ActionController::Base; end
      class ::Rails::Console; end
      # rubocop:enable Style/ClassAndModuleChildren

      RailsConsoleTestApp.initialize!
    end

    after :all do
      ElasticAPM.stop
    end

    it "doesn't start when console" do
      expect(ElasticAPM.agent).to be nil
    end
  end
end

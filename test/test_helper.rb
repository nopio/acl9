$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'

require "action_controller/railtie"
require "rails/test_unit/railtie"
require "rails/test_help"
require 'context'
require 'matchy'
require 'active_support'
require 'active_record'
#require 'action_controller'
#require 'action_controller/test_process'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'test.sqlite3')

# Define the application and configuration
module Config
  class Application < ::Rails::Application
    # configuration here if needed
    config.active_support.deprecation = :stderr
  end
end

# Initialize the application
Config::Application.initialize!

class Test::Unit::TestCase
  custom_matcher :be_false do |receiver, matcher, args|
    !receiver
  end

  custom_matcher :be_true do |receiver, matcher, args|
    !!receiver
  end
end

Config::Application::routes.draw do
  match ':controller(/:action(/:id(.:format)))'
end

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActionController::Base.logger = ActiveRecord::Base.logger

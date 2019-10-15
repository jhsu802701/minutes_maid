# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/models/application_record.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'
end
puts "*************** Chromedriver version: #{Webdrivers::Chromedriver.current_version} ***************"
Webdrivers::Chromedriver.required_version = ENV['CHROMEDRIVER_VERSION']

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'vcr'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'vcr_cassettes'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
end

# this key is not valid but referenced by VCR cassettes
ENV['MM_GOOGLE_API_KEY'] = 'AIzaSyCTQ7QGkpvV8mw_6HDfxw-4_Sd7vNsJ6G0'
Google::Maps.configure do |config|
  config.authentication_mode = Google::Maps::Configuration::API_KEY
  config.api_key = ENV['MM_GOOGLE_API_KEY']
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
